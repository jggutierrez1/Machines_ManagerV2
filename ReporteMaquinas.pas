unit ReporteMaquinas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEh, Vcl.StdCtrls, DBCtrlsEh, Vcl.ExtCtrls, Vcl.Mask, DBLookupEh, Vcl.Buttons, PngBitBtn,
  inifiles, DateUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.ComCtrls;

type
  TfReporteMaquinas = class(TForm)
    Label3: TLabel;
    oLst_emp: TDBLookupComboboxEh;
    Shape2: TShape;
    olFecha1: TLabel;
    oFecha1: TDBDateTimeEditEh;
    olFecha2: TLabel;
    oFecha2: TDBDateTimeEditEh;
    olCliente: TLabel;
    oLst_Ctes: TDBLookupComboboxEh;
    oAll_Ctes: TCheckBox;
    olModelos: TLabel;
    oLst_Modelos: TDBLookupComboboxEh;
    oAll_Modelos: TCheckBox;
    Shape1: TShape;
    Label1: TLabel;
    Shape4: TShape;
    oBtn_Print: TPngBitBtn;
    oBtnExit: TPngBitBtn;
    oBtn_Preview: TPngBitBtn;
    oDs_Emp: TDataSource;
    oQry_Empresa: TFDQuery;
    oConection: TFDConnection;
    oDS_Ctes: TDataSource;
    oQry_Ctes: TFDQuery;
    oDS_Juegos: TDataSource;
    oQry_Juegos: TFDQuery;
    StatusBar1: TStatusBar;
    oChapa: TEdit;
    oAll_Chapas: TCheckBox;
    oOpt1: TRadioButton;
    oOpt2: TRadioButton;
    oOpt3: TRadioButton;
    Shape5: TShape;
    oOpt4: TRadioButton;
    oAll_Emp: TCheckBox;
    oDS_Rutas: TDataSource;
    otRutas: TFDTable;
    olRuta: TLabel;
    oLst_Rutas: TDBLookupComboboxEh;
    oAll_Routes: TCheckBox;
    oCod_Maq: TEdit;
    oAll_Maq: TCheckBox;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    oLst_Conses: TDBLookupComboboxEh;
    oAll_Conses: TCheckBox;
    oDS_Maq_Prov: TDataSource;
    otMaq_Prov: TFDTable;
    procedure oBtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Make_report(iOpt: integer);
    procedure oAll_CtesClick(Sender: TObject);
    procedure oAll_ModelosClick(Sender: TObject);
    procedure oBtn_PrintClick(Sender: TObject);
    procedure oLst_empCloseUp(Sender: TObject; Accept: Boolean);
    procedure oLst_empExit(Sender: TObject);
    procedure Load_Ctes(iEmp: string);
    Procedure Visible_Modelos(bFlag: Boolean);
    Procedure Visible_Clientes(bFlag: Boolean);
    Procedure Visible_Fechas(bFlag: Boolean);
    Function Generic_Qry(sOrder: string): Widestring;
    procedure oAll_ChapasClick(Sender: TObject);
    procedure Lee_ini;
    procedure Escribe_ini;
    procedure Show_Report(nOption: integer);
    procedure oBtn_PreviewClick(Sender: TObject);
    procedure oAll_EmpClick(Sender: TObject);
    procedure oAll_ConsesClick(Sender: TObject);
    procedure oAll_MaqClick(Sender: TObject);
    procedure oAll_RoutesClick(Sender: TObject);
    procedure oOpt1Click(Sender: TObject);
    procedure oOpt2Click(Sender: TObject);
    procedure oOpt3Click(Sender: TObject);
    procedure oOpt4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    iOption: integer;
    bSwitchPrev: Boolean;
    bActivesOk: Boolean;
  public
    { Public declarations }
  end;

var
  fReporteMaquinas: TfReporteMaquinas;

implementation

uses UtilesV20, reportes;

{$R *.dfm}

procedure TfReporteMaquinas.FormActivate(Sender: TObject);
begin
  if (self.bActivesOk = false) then
  begin
    self.oAll_Ctes.Checked := true;
    self.oAll_CtesClick(self);
    self.oAll_Conses.Checked := true;
    self.oAll_ConsesClick(self);
    self.oAll_Modelos.Checked := true;
    self.oAll_ModelosClick(self);
    self.oAll_Routes.Checked := true;
    self.oAll_RoutesClick(self);

    self.Lee_ini;
    case self.iOption of
      0, 1:
        self.oOpt1.Checked := true;
      2:
        self.oOpt2.Checked := true;
      3:
        self.oOpt3.Checked := true;
      4:
        self.oOpt4.Checked := true;
    end;
    self.bActivesOk := true;
  end;

end;

procedure TfReporteMaquinas.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  self.iOption := 0;
end;

procedure TfReporteMaquinas.FormCreate(Sender: TObject);
begin
  self.iOption := 1;
  self.bActivesOk := false;
  freeandnil(oConection);
  // self.ResizeKit1.Enabled := Utiles.Ctrl_Resize;

  self.oQry_Ctes.Connection := fUtilesV20.oPublicCnn;
  self.oQry_Ctes.Close;

  self.oQry_Juegos.Connection := fUtilesV20.oPublicCnn;
  self.oQry_Juegos.open;

  self.otMaq_Prov.Connection := fUtilesV20.oPublicCnn;
  self.otMaq_Prov.open;

  self.otRutas.Connection := fUtilesV20.oPublicCnn;
  self.otRutas.open;

  self.oQry_Empresa.Connection := fUtilesV20.oPublicCnn;
  self.oQry_Empresa.open;
  self.oLst_emp.Value := UtilesV20.iId_Empresa;

  self.oFecha1.Value := Now();
  self.oFecha2.Value := Now();
  self.bSwitchPrev := true;
end;

procedure TfReporteMaquinas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F11 then
  begin
    if (self.bSwitchPrev = true) then
    begin
      self.oBtn_Preview.Caption := 'Dise�o';
      self.bSwitchPrev := false;
    end
    else
    begin
      self.oBtn_Preview.Caption := 'Visualizar';
      self.bSwitchPrev := true;
    end;
  end;
end;

procedure TfReporteMaquinas.FormShow(Sender: TObject);
begin
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
  FormatSettings.CurrencyDecimals := 2;
  FormatSettings.DateSeparator := '/';
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FormatSettings.LongDateFormat := 'dd/mm/yyyy';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.TimeAMString := 'AM';
  FormatSettings.TimePMString := 'PM';
  FormatSettings.ShortTimeFormat := 'hh:nn';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';
  FormatSettings.CurrencyString := '$';

  self.StatusBar1.Panels[0].Text := 'Servidor: ' + fUtilesV20.oPublicCnn.Params.Values['Server'] + '/' + fUtilesV20.oPublicCnn.Params.Values
    ['Database'];

  if fUtilesV20.query_selectgen_result('SELECT u_acceso1 FROM usuarios WHERE u_usuario=' + QuotedStr(trim(UtilesV20.sUserName))) = '1' then
  begin
    self.oLst_emp.Enabled := true;
    self.oAll_Emp.Enabled := true;
  end
  else
  begin
    self.oLst_emp.Enabled := false;
    self.oAll_Emp.Enabled := false;
  end;

  self.oLst_empExit(self);
  self.oAll_EmpClick(self);

end;

procedure TfReporteMaquinas.oAll_ChapasClick(Sender: TObject);
begin
  if self.oAll_Chapas.Checked = true then
  begin
    self.oChapa.Text := '';
    self.oChapa.Enabled := false;
  end
  else
  begin
    self.oChapa.Enabled := true;
    if (self.oChapa.Visible = true) then
      self.oChapa.SetFocus;
  end;
end;

procedure TfReporteMaquinas.oAll_ConsesClick(Sender: TObject);
begin
  if self.oAll_Conses.Checked = true then
  begin
    self.oLst_Conses.Enabled := false;
  end
  else
  begin
    self.oLst_Conses.Enabled := true;
    if (self.oLst_Conses.Visible = true) then
      self.oLst_Conses.SetFocus;
  end;
end;

procedure TfReporteMaquinas.oAll_CtesClick(Sender: TObject);
begin
  if self.oAll_Ctes.Checked = true then
  begin
    self.oLst_Ctes.Enabled := false;
  end
  else
  begin
    self.oLst_Ctes.Enabled := true;
    if (self.oLst_Ctes.Visible = true) then
      self.oLst_Ctes.SetFocus;
  end;
end;

procedure TfReporteMaquinas.oAll_EmpClick(Sender: TObject);
begin
  if (self.oAll_Emp.Checked = true) then
  begin
    self.oLst_emp.Enabled := true;
  end
  else
  begin
    self.oLst_emp.Enabled := true;
  end;
  self.Load_Ctes(self.oLst_emp.Value);
end;

procedure TfReporteMaquinas.oAll_MaqClick(Sender: TObject);
begin
  if self.oAll_Maq.Checked = true then
  begin
    self.oCod_Maq.Text := '';
    self.oCod_Maq.Enabled := false;
  end
  else
  begin
    self.oCod_Maq.Enabled := true;
    if (self.oCod_Maq.Visible = true) then
      self.oCod_Maq.SetFocus;
  end;
end;

procedure TfReporteMaquinas.oAll_ModelosClick(Sender: TObject);
begin
  if self.oAll_Modelos.Checked = true then
    self.oLst_Modelos.Enabled := false
  else
  begin
    self.oLst_Modelos.Enabled := true;
    if (self.oLst_Modelos.Visible = true) then
      self.oLst_Modelos.SetFocus;
  end;
end;

procedure TfReporteMaquinas.oAll_RoutesClick(Sender: TObject);
begin
  if self.oAll_Routes.Checked = true then
    self.oLst_Rutas.Enabled := false
  else
  begin
    self.oLst_Rutas.Enabled := true;
    if (self.oLst_Rutas.Visible = true) then
      self.oLst_Rutas.SetFocus;
  end;

end;

procedure TfReporteMaquinas.oBtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfReporteMaquinas.oBtn_PreviewClick(Sender: TObject);
begin
  if bSwitchPrev = true then
    self.Show_Report(1)
  else
    self.Show_Report(3);
  self.Escribe_ini;
end;

procedure TfReporteMaquinas.oBtn_PrintClick(Sender: TObject);
begin
  self.Show_Report(2);
  self.Escribe_ini;
end;

procedure TfReporteMaquinas.oLst_empCloseUp(Sender: TObject; Accept: Boolean);
begin
  self.Load_Ctes(self.oLst_emp.Value);
end;

procedure TfReporteMaquinas.oLst_empExit(Sender: TObject);
begin
  self.Load_Ctes(self.oLst_emp.Value);
end;

procedure TfReporteMaquinas.oOpt1Click(Sender: TObject);
begin
  self.iOption := 1;
end;

procedure TfReporteMaquinas.oOpt2Click(Sender: TObject);
begin
  self.iOption := 2;
end;

procedure TfReporteMaquinas.oOpt3Click(Sender: TObject);
begin
  self.iOption := 3;
end;

procedure TfReporteMaquinas.oOpt4Click(Sender: TObject);
begin
  self.iOption := 4;
end;

procedure TfReporteMaquinas.Make_report(iOpt: integer);
begin
  reportes.Initialize;
  reportes.Clear_all;
end;

procedure TfReporteMaquinas.Load_Ctes(iEmp: string);
var
  cSql_Ln: string;
begin
  self.oDS_Ctes.DataSet := nil;
  self.oLst_Ctes.ListSource := nil;

  cSql_Ln := '';
  if (self.oAll_Ctes.Checked = true) then
  begin
    cSql_Ln := cSql_Ln + 'SELECT ct.cte_id, UCASE(trim(ct.cte_nombre_loc)) AS cte_nombre_loc ';
    cSql_Ln := cSql_Ln + 'FROM clientes ct ';
    // cSql_Ln := cSql_Ln + 'WHERE (ct.cte_inactivo=0) ';
    cSql_Ln := cSql_Ln + 'ORDER BY UCASE(trim(ct.cte_nombre_loc)) ';
  end
  else
  begin
    cSql_Ln := cSql_Ln + 'SELECT ct.cte_id, UCASE(trim(ct.cte_nombre_loc)) AS cte_nombre_loc ';
    cSql_Ln := cSql_Ln + 'FROM clientes ct ';
    // cSql_Ln := cSql_Ln + 'LEFT JOIN maquinas_lnk ml ON (ct.cte_id = ml.cte_id) ';
    cSql_Ln := cSql_Ln + 'WHERE (1=1) ';
    // cSql_Ln := cSql_Ln + 'WHERE (ct.cte_inactivo = 0) ';
    // cSql_Ln := cSql_Ln + 'AND   (ml.emp_id = ' + QuotedStr(trim(iEmp)) + ') ';
    cSql_Ln := cSql_Ln + 'AND  ((ct.cte_emp_id=0) or (cte_emp_id = ' + QuotedStr(trim(iEmp)) + ')) ';
    // cSql_Ln := cSql_Ln + 'GROUP BY ml.cte_id ';
    cSql_Ln := cSql_Ln + 'ORDER BY UCASE(trim(ct.cte_nombre_loc)) ';
  end;
  oQry_Ctes.Close;
  oQry_Ctes.Connection := fUtilesV20.oPublicCnn;
  UtilesV20.Exec_Select_SQL(oQry_Ctes, cSql_Ln, true);
  self.oDS_Ctes.DataSet := oQry_Ctes;
  self.oLst_Ctes.ListSource := self.oDS_Ctes;
  self.oLst_Ctes.ListField := 'cte_nombre_loc';
  self.oLst_Ctes.KeyField := 'cte_id';

  self.oLst_Ctes.Refresh;
  self.oLst_Ctes.Value := oQry_Ctes.FieldByName('cte_id').Value;
end;

Procedure TfReporteMaquinas.Visible_Clientes(bFlag: Boolean);
begin
  self.olCliente.Caption := 'Asignado al Cliente:';
  self.olCliente.Visible := bFlag;
  self.oLst_Ctes.Visible := bFlag;
  self.oAll_Ctes.Visible := bFlag;
  self.oLst_Ctes.ListFieldIndex := 1;
  self.oAll_Ctes.Checked := true;
  self.oAll_CtesClick(self);
end;

Procedure TfReporteMaquinas.Visible_Modelos(bFlag: Boolean);
begin
  self.olModelos.Caption := 'Lista de los Modelos disponibles:';

  self.oLst_Modelos.TOP := self.oLst_Ctes.TOP;
  self.oLst_Modelos.LEFT := self.oLst_Ctes.LEFT;
  self.oLst_Modelos.WIDTH := self.oLst_Ctes.WIDTH;
  self.oLst_Modelos.HEIGHT := self.oLst_Ctes.HEIGHT;

  self.olModelos.TOP := self.olCliente.TOP;
  self.olModelos.LEFT := self.olCliente.LEFT;
  self.olModelos.WIDTH := self.olCliente.WIDTH;
  self.olModelos.HEIGHT := self.olCliente.HEIGHT;

  self.oAll_Modelos.TOP := self.oAll_Ctes.TOP;
  self.oAll_Modelos.LEFT := self.oAll_Ctes.LEFT;
  self.oAll_Modelos.WIDTH := self.oAll_Ctes.WIDTH;
  self.oAll_Modelos.HEIGHT := self.oAll_Ctes.HEIGHT;

  self.olModelos.Visible := bFlag;
  self.oLst_Modelos.Visible := bFlag;
  self.oAll_Modelos.Visible := bFlag;
  self.oLst_Modelos.ListFieldIndex := 1;
  self.oAll_Modelos.Checked := true;
  self.oAll_ModelosClick(self);
end;

Procedure TfReporteMaquinas.Visible_Fechas(bFlag: Boolean);
begin
  self.olFecha1.Caption := 'Desde:';
  self.oFecha1.EditFormat := 'DD/MM/YYYY';
  self.oFecha2.EditFormat := 'DD/MM/YYYY';
  self.olFecha1.Visible := bFlag;
  self.oFecha1.Visible := bFlag;
  self.olFecha2.Visible := bFlag;
  self.oFecha2.Visible := bFlag;
end;

Function TfReporteMaquinas.Generic_Qry(sOrder: string): Widestring;
var
  sFecha_Ini: string;
  sFecha_Fin: string;
  cSql_Ln, sCod_Chapa, sCod_Cte, sCod_Rutas, sCod_Juego, sCod_Maqui, sCod_Conse: string;
begin
  FormatSettings.ShortDateFormat := 'yyyy-MM-dd';
  sFecha_Ini := DateToStr(self.oFecha1.Value);
  sFecha_Fin := DateToStr(self.oFecha2.Value);
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';

  sCod_Cte := fUtilesV20.iif(self.oAll_Ctes.Checked = true, '%', self.oLst_Ctes.KeyValue);
  sCod_Juego := fUtilesV20.iif(self.oAll_Modelos.Checked = true, '%', self.oLst_Modelos.KeyValue);
  sCod_Chapa := fUtilesV20.iif(self.oAll_Chapas.Checked = true, '%', self.oChapa.Text);
  sCod_Maqui := fUtilesV20.iif(self.oAll_Maq.Checked = true, '%', self.oCod_Maq.Text);
  sCod_Rutas := fUtilesV20.iif(self.oAll_Routes.Checked = true, '%', self.oLst_Rutas.KeyValue);
  sCod_Conse := fUtilesV20.iif(self.oAll_Conses.Checked = true, '%', self.oLst_Conses.KeyValue);

  cSql_Ln := '';
  cSql_Ln := cSql_Ln + 'SELECT ';
  cSql_Ln := cSql_Ln + '  tc.*,  mp.prov_nombre, mj.jueg_nombre, cl.cte_id, cl.cte_nombre_loc, cl.rut_id, ru.rut_nombre ';
  cSql_Ln := cSql_Ln + 'FROM maquinastc tc ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN maquinas_prov   mp ON (tc.prov_cod = mp.prov_cod) ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN maquinas_juegos mj ON (tc.jueg_cod = mj.jueg_cod) ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN maquinas_lnk    ml ON (tc.maqtc_id = ml.maqtc_id) ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN clientes        cl ON (cl.cte_id   = ml.cte_id  ) ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN rutas           ru ON (cl.rut_id   = ru.rut_id  ) ';
  cSql_Ln := cSql_Ln + 'WHERE (tc.maqtc_tipomaq =1) ';

  if (self.oAll_Emp.Checked = false) then
    cSql_Ln := cSql_Ln + 'AND (tc.emp_id = "' + trim(self.oLst_emp.Value) + '") ';

  if (self.oAll_Chapas.Checked = false) then
  begin
    if not((trim(sCod_Chapa) = '%') or (trim(sCod_Chapa) = '')) then
      cSql_Ln := cSql_Ln + 'AND (tc.maqtc_chapa="' + trim(sCod_Chapa) + '") ';
  end;

  if (self.oAll_Maq.Checked = false) then
  begin
    if not((trim(sCod_Maqui) = '%') or (trim(sCod_Maqui) = '')) then
      cSql_Ln := cSql_Ln + 'AND (tc.maqtc_id="' + trim(sCod_Maqui) + '") ';
  end;

  if (self.oAll_Ctes.Checked = false) then
  begin
    if not((trim(sCod_Cte) = '%') or (trim(sCod_Cte) = '')) then
      cSql_Ln := cSql_Ln + 'AND (ml.cte_id="' + trim(sCod_Cte) + '") ';
  end;

  if (self.oAll_Conses.Checked = false) then
  begin
    if not((trim(sCod_Conse) = '%') or (trim(sCod_Conse) = '')) then
      cSql_Ln := cSql_Ln + 'AND (tc.prov_cod="' + trim(sCod_Conse) + '") ';
  end;

  if (self.oAll_Routes.Checked = false) then
  begin
    if not((trim(sCod_Rutas) = '%') or (trim(sCod_Rutas) = '')) then
      cSql_Ln := cSql_Ln + 'AND   (cl.rut_id="' + trim(sCod_Rutas) + '") ';
  end;

  if (self.oAll_Modelos.Checked = false) then
  begin
    if not((trim(sCod_Juego) = '%') or (trim(sCod_Juego) = '')) then
      cSql_Ln := cSql_Ln + 'AND   (TRIM(mj.jueg_cod)="' + trim(sCod_Juego) + '") ';
  end;

  cSql_Ln := cSql_Ln + 'AND   (';
  cSql_Ln := cSql_Ln + '(DATE_FORMAT(tc.maqtc_fecha_alta, "%Y-%m-%d") >= "' + sFecha_Ini + '") AND ';
  cSql_Ln := cSql_Ln + '(DATE_FORMAT(tc.maqtc_fecha_alta, "%Y-%m-%d") <= "' + sFecha_Fin + '") ) ';

  case StrToInt(sOrder) of
    1:
      cSql_Ln := cSql_Ln + 'ORDER BY  tc.maqtc_chapa ';
    2:
      cSql_Ln := cSql_Ln + 'ORDER BY  ru.rut_nombre, tc.maqtc_chapa ';
    3:
      cSql_Ln := cSql_Ln + 'ORDER BY  mp.prov_nombre, tc.maqtc_chapa ';
    4:
      cSql_Ln := cSql_Ln + 'ORDER BY  cl.cte_nombre_loc, tc.maqtc_chapa ';
  end;
  result := cSql_Ln;
end;

procedure TfReporteMaquinas.Show_Report(nOption: integer);
var
  icnt1: integer;
  icnt2: integer;
  sOrder: string;
  sLn1: Widestring;
  sFecha_Ini: string;
  sFecha_Fin: string;
  dFech_Ini: Tdatetime;
  dFech_Fin: Tdatetime;
begin
  FormatSettings.ShortDateFormat := 'yyyy-mm-dd';
  reportes.Initialize;

  dFech_Ini := self.oFecha1.Value;
  dFech_Fin := self.oFecha2.Value;

  sFecha_Ini := DateToStr(dFech_Ini) + ' 01:00:00';
  sFecha_Fin := DateToStr(dFech_Fin) + ' 23:59:59';

  reportes.Report.Vars[1].Name := 'Fecha_desde';
  reportes.Report.Vars[1].Value := FormatDateTime('dd/mm/yyyy', dFech_Ini);
  reportes.Report.Vars[2].Name := 'Fecha_hasta';
  reportes.Report.Vars[2].Value := FormatDateTime('dd/mm/yyyy', dFech_Fin);

  // reportes.oFrom := self.Generic_Qry();
  sLn1 := 'SELECT * FROM empresas WHERE emp_id= ' + QuotedStr(IntToStr(UtilesV20.iId_Empresa)) + ' ORDER BY emp_descripcion ';
  reportes.Queries[1].active := true;
  reportes.Queries[1].Sql_String := sLn1;
  reportes.Queries[1].DB_DSName := 'dsEmpresa';
  reportes.Queries[1].Sql_IsProcedure := false;

  if (oOpt1.Checked = true) then
  begin
    // Informe general de maquinas
    sOrder := '1';
    reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_Maq_01.fr3';
  end
  else if (oOpt2.Checked = true) then
  begin
    // Informe por rutas de clientes
    sOrder := '2';
    reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_Maq_02.fr3';
  end
  else if (oOpt3.Checked = true) then
  begin
    // Informe por consesionarios de maquinas
    sOrder := '3';
    reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_Maq_03.fr3';
  end
  else if (oOpt4.Checked = true) then
  begin
    // Informe por clientes
    sOrder := '4';
    reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_Maq_04.fr3';
  end;

  sLn1 := self.Generic_Qry(sOrder);

  reportes.Queries[2].active := true;
  reportes.Queries[2].Sql_String := sLn1;
  reportes.Queries[2].DB_DSName := 'dsMaquinas';
  reportes.Queries[2].Sql_IsProcedure := false;

  reportes.Report.OutOption := nOption;
  reportes.Prepare;

  reportes.Make_report;
  reportes.Clear_all;
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
end;

procedure TfReporteMaquinas.Escribe_ini;
var
  oFileIni: Tinifile;
  cUser, cComp: string;
begin
  oFileIni := Tinifile.Create(ExtractFilePath(application.ExeName) + 'Data\Config.ini');
  oFileIni.WriteInteger('MAQ_REPORT', 'ioption', self.iOption);
  oFileIni.WriteDate('MAQ_REPORT', 'oFecha1', self.oFecha1.Value);
  oFileIni.WriteDate('MAQ_REPORT', 'oFecha2', self.oFecha2.Value);

  oFileIni.WriteBool('MAQ_REPORT', 'oAll_Ctes', self.oAll_Ctes.Checked);
  oFileIni.WriteInteger('MAQ_REPORT', 'oLst_Ctes', self.oLst_Ctes.Value);

  oFileIni.WriteBool('MAQ_REPORT', 'oAll_Conses', self.oAll_Conses.Checked);
  oFileIni.WriteInteger('MAQ_REPORT', 'oLst_Conses', self.oLst_Conses.Value);

  oFileIni.WriteBool('MAQ_REPORT', 'oAll_Modelos', self.oAll_Modelos.Checked);
  oFileIni.WriteInteger('MAQ_REPORT', 'oLst_Modelos', self.oLst_Modelos.Value);

  oFileIni.WriteBool('MAQ_REPORT', 'oAll_Routes', self.oAll_Routes.Checked);
  oFileIni.WriteInteger('MAQ_REPORT', 'oLst_Rutas', self.oLst_Rutas.Value);

  oFileIni.WriteBool('MAQ_REPORT', 'oAll_Chapas', self.oAll_Chapas.Checked);
  oFileIni.WriteString('MAQ_REPORT', 'oChapa', self.oChapa.Text);

  oFileIni.WriteBool('MAQ_REPORT', 'oAll_Maq', self.oAll_Maq.Checked);
  oFileIni.WriteString('MAQ_REPORT', 'oCod_Maq', self.oCod_Maq.Text);

  oFileIni.Free;
end;

procedure TfReporteMaquinas.Lee_ini;
var
  oFileIni: Tinifile;
  cUser, cComp: string;
begin
  oFileIni := Tinifile.Create(ExtractFilePath(application.ExeName) + 'Data\Config.ini');
  self.iOption := oFileIni.ReadInteger('MAQ_REPORT', 'ioption', 1);
  self.oFecha1.Value := oFileIni.ReadDate('MAQ_REPORT', 'oFecha1', Now());
  self.oFecha2.Value := oFileIni.ReadDate('MAQ_REPORT', 'oFecha2', Now());

  self.oAll_Ctes.Checked := oFileIni.ReadBool('MAQ_REPORT', 'oAll_Ctes', false);
  self.oLst_Ctes.Value := oFileIni.ReadInteger('MAQ_REPORT', 'oLst_Ctes', 1);

  self.oAll_Conses.Checked := oFileIni.ReadBool('MAQ_REPORT', 'oAll_Conses', false);
  self.oLst_Conses.Value := oFileIni.ReadInteger('MAQ_REPORT', 'oLst_Conses', 1);

  self.oAll_Modelos.Checked := oFileIni.ReadBool('MAQ_REPORT', 'oAll_Modelos', false);
  self.oLst_Modelos.Value := oFileIni.ReadInteger('MAQ_REPORT', 'oLst_Modelos', 1);

  self.oAll_Routes.Checked := oFileIni.ReadBool('MAQ_REPORT', 'oAll_Routes', false);
  self.oLst_Rutas.Value := oFileIni.ReadInteger('MAQ_REPORT', 'oLst_Rutas', 1);

  self.oAll_Chapas.Checked := oFileIni.ReadBool('MAQ_REPORT', 'oAll_Chapas', false);
  self.oChapa.Text := oFileIni.ReadString('MAQ_REPORT', 'oChapa', '');

  self.oAll_Maq.Checked := oFileIni.ReadBool('MAQ_REPORT', 'oAll_Maq', false);
  self.oCod_Maq.Text := oFileIni.ReadString('MAQ_REPORT', 'oCod_Maq', '');

  oFileIni.Free;
end;

end.
