unit RepJCJ_1;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan,
  ComCtrls, PngImageList, Buttons,
  PngBitBtn, DB,
  frxClass, frxDesgn, Mask, DBCtrlsEh,
  DBGridEh, DBLookupEh,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, inifiles, FireDAC.VCLUI.Wait;

type
  TFRepJCJ_1 = class(TForm)
    StatusBar1: TStatusBar;
    oOpt1: TRadioButton;
    oOpt2: TRadioButton;
    oOpt3: TRadioButton;
    oOpt4: TRadioButton;
    oOpt5: TRadioButton;
    oOpt6: TRadioButton;
    oOpt7: TRadioButton;
    oOpt9: TRadioButton;
    oOpt10: TRadioButton;
    oBtn_Print: TPngBitBtn;
    oBtnExit: TPngBitBtn;
    oBtn_Preview: TPngBitBtn;
    oFecha1: TDBDateTimeEditEh;
    oFecha2: TDBDateTimeEditEh;
    olFecha1: TLabel;
    olFecha2: TLabel;
    oChapa: TEdit;
    oAll_Chapas: TCheckBox;
    oDS_Rutas: TDataSource;
    oDS_Ctes: TDataSource;
    oLst_Rutas: TDBLookupComboboxEh;
    oLst_Ctes: TDBLookupComboboxEh;
    olCliente: TLabel;
    olRuta: TLabel;
    oAll_Ctes: TCheckBox;
    oAll_Routes: TCheckBox;
    oDS_Model: TDataSource;
    olModelos: TLabel;
    oLst_Modelos: TDBLookupComboboxEh;
    oAll_Modelos: TCheckBox;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Label3: TLabel;
    oLst_emp: TDBLookupComboboxEh;
    oDs_Emp: TDataSource;
    oAll_Emp: TCheckBox;
    oConection: TFDConnection;
    oQry_Empresa: TFDQuery;
    otRutas: TFDTable;
    oQry_Modelos: TFDQuery;
    oOpt11: TRadioButton;
    oOpt12: TRadioButton;
    oOpt13: TRadioButton;
    oOpt14: TRadioButton;
    oQry_Ctes: TFDQuery;
    oOpt15: TRadioButton;
    procedure Make_report(iOpt: integer);
    procedure oBtn_PreviewClick(Sender: TObject);
    procedure oBtn_PrintClick(Sender: TObject);
    procedure Show_Report(nOption: integer);
    procedure FormCreate(Sender: TObject);
    procedure oAll_ChapasClick(Sender: TObject);
    procedure oAll_CtesClick(Sender: TObject);
    procedure oAll_RoutesClick(Sender: TObject);
    procedure oBtnExitClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure oOpt1Click(Sender: TObject);
    Procedure Visible_Fechas(bFlag: boolean);
    Procedure Visible_Rutas(bFlag: boolean);
    Procedure Visible_Clientes(bFlag: boolean);
    Procedure Visible_Modelos(bFlag: boolean);
    procedure oOpt2Click(Sender: TObject);
    procedure oOpt3Click(Sender: TObject);
    procedure oOpt4Click(Sender: TObject);
    procedure oOpt5Click(Sender: TObject);
    procedure oOpt7Click(Sender: TObject);
    procedure oOpt9Click(Sender: TObject);
    procedure oOpt10Click(Sender: TObject);
    procedure oAll_ModelosClick(Sender: TObject);
    procedure oOpt6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure oAll_EmpClick(Sender: TObject);
    procedure oOpt11Click(Sender: TObject);
    procedure Lee_ini;
    procedure Escribe_ini;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure oOpt12Click(Sender: TObject);
    procedure oOpt13Click(Sender: TObject);
    procedure Load_Ctes(iEmp: string);
    procedure oLst_empExit(Sender: TObject);
    procedure oLst_empCloseUp(Sender: TObject; Accept: boolean);
    procedure oOpt14Click(Sender: TObject);
    procedure oOpt15Click(Sender: TObject);
    Function Generic_Qry(sOrder: string): Widestring;
    Function JCJ_Qry(): Widestring;
    Function NETWIN_Qry(): Widestring;
  private
    iOption: integer;
    cSql_Cte: string;
    sMesAno: string;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRepJCJ_1: TFRepJCJ_1;
  bSwitchPrev: boolean;

implementation

uses UtilesV20, reportes;
{$R *.dfm}

procedure TFRepJCJ_1.oAll_EmpClick(Sender: TObject);
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

procedure TFRepJCJ_1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  iOption := 0;
end;

procedure TFRepJCJ_1.FormCreate(Sender: TObject);
begin
  iOption := 0;
  freeandnil(oConection);
  // self.ResizeKit1.Enabled := Utiles.Ctrl_Resize;

  otRutas.Connection := fUtilesV20.oPublicCnn;
  otRutas.open;

  // otClientes.Connection := fUtilesV20.oPublicCnn;
  // otClientes.Filtered := false;
  // otClientes.open;

  self.oQry_Ctes.Connection := fUtilesV20.oPublicCnn;
  self.oQry_Ctes.Close;

  oQry_Modelos.Connection := fUtilesV20.oPublicCnn;
  oQry_Modelos.open;

  self.oQry_Empresa.Connection := fUtilesV20.oPublicCnn;
  self.oQry_Empresa.open;
  self.oLst_emp.Value := UtilesV20.iId_Empresa;

  oFecha1.Value := Now();
  oFecha2.Value := Now();
  bSwitchPrev := true;
end;

procedure TFRepJCJ_1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F11 then
  begin
    if bSwitchPrev = true then
    begin
      oBtn_Preview.Caption := 'Diseño';
      bSwitchPrev := false;
    end
    else
    begin
      oBtn_Preview.Caption := 'Visualizar';
      bSwitchPrev := true;
    end;
  end;
end;

procedure TFRepJCJ_1.FormShow(Sender: TObject);
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

  self.StatusBar1.Panels[0].Text := 'Servidor: ' + fUtilesV20.oPublicCnn.Params.Values['Server'] + '/' +
    fUtilesV20.oPublicCnn.Params.Values['Database'];

  if fUtilesV20.query_selectgen_result('SELECT u_acceso1 FROM usuarios WHERE u_usuario=' +
    QuotedStr(trim(UtilesV20.sUserName))) = '1' then
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

  self.Lee_ini;
end;

procedure TFRepJCJ_1.Make_report(iOpt: integer);
begin
  reportes.Initialize;
  reportes.Clear_all;
end;

procedure TFRepJCJ_1.oAll_ChapasClick(Sender: TObject);
begin
  if self.oAll_Chapas.Checked = true then
    self.oChapa.Enabled := false
  else
  begin
    self.oChapa.Enabled := true;
    self.oChapa.SetFocus;
  end;
end;

procedure TFRepJCJ_1.oAll_CtesClick(Sender: TObject);
begin
  if self.oAll_Ctes.Checked = true then
  begin
    self.oLst_Ctes.Enabled := false;
  end
  else
  begin
    self.oLst_Ctes.Enabled := true;
  end;
end;

procedure TFRepJCJ_1.oAll_ModelosClick(Sender: TObject);
begin
  if self.oAll_Modelos.Checked = true then
    self.oLst_Modelos.Enabled := false
  else
    self.oLst_Modelos.Enabled := true;
end;

procedure TFRepJCJ_1.oAll_RoutesClick(Sender: TObject);
begin
  if self.oAll_Routes.Checked = true then
    self.oLst_Rutas.Enabled := false
  else
    self.oLst_Rutas.Enabled := true;
end;

procedure TFRepJCJ_1.oBtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFRepJCJ_1.oBtn_PrintClick(Sender: TObject);
begin
  self.Show_Report(2);
  self.Escribe_ini;
end;

procedure TFRepJCJ_1.oLst_empCloseUp(Sender: TObject; Accept: boolean);
begin
  self.Load_Ctes(self.oLst_emp.Value);
end;

procedure TFRepJCJ_1.oLst_empExit(Sender: TObject);
begin
  self.Load_Ctes(self.oLst_emp.Value);
end;

procedure TFRepJCJ_1.Load_Ctes(iEmp: string);
var
  cSql_Ln: string;
  cSql_Cte: string;
begin
  self.oDS_Ctes.DataSet := nil;
  self.oLst_Ctes.ListSource := nil;

  cSql_Cte := '';
  if (self.oAll_Ctes.Checked = true) then
  begin
    cSql_Cte := cSql_Cte + 'SELECT ct.* ';
    cSql_Cte := cSql_Cte + 'FROM clientes ct ';
    cSql_Cte := cSql_Cte + 'WHERE ct.cte_inactivo=0 ';
    cSql_Cte := cSql_Cte + 'ORDER BY ct.cte_nombre_loc ';
  end
  else
  begin
    cSql_Cte := cSql_Cte + 'SELECT ct.* ';
    cSql_Cte := cSql_Cte + 'FROM clientes ct ';
    cSql_Cte := cSql_Cte + 'LEFT JOIN maquinas_lnk ml ON ct.cte_id = ml.cte_id ';
    cSql_Cte := cSql_Cte + 'WHERE ct.cte_inactivo = 0 ';
    cSql_Cte := cSql_Cte + 'AND   ml.emp_id = ' + QuotedStr(trim(iEmp)) + ' ';
    cSql_Cte := cSql_Cte + 'GROUP BY ml.cte_id ';
    cSql_Cte := cSql_Cte + 'ORDER BY ct.cte_nombre_loc ';
  end;
  oQry_Ctes.Close;
  oQry_Ctes.Connection := fUtilesV20.oPublicCnn;
  UtilesV20.Exec_Select_SQL(oQry_Ctes, cSql_Cte, true);
  self.oDS_Ctes.DataSet := oQry_Ctes;
  self.oLst_Ctes.ListSource := self.oDS_Ctes;
  self.oLst_Ctes.ListField := 'cte_nombre_loc';
  self.oLst_Ctes.KeyField := 'cte_id';

  self.oLst_Ctes.Refresh;
  self.oLst_Ctes.Value := oQry_Ctes.FieldByName('cte_id').Value;

  { if (self.oAll_Ctes.Checked = true) then
    begin
    self.otClientes.Filtered := false;
    self.otClientes.Filter := '';
    end
    else
    begin
    self.otClientes.Filtered := false;
    self.otClientes.Filter := 'cte_emp_id=' + QuotedStr(trim(iEmp)) + ' ';
    self.otClientes.Filtered := true;
    end;
    self.otClientes.First;
    self.otClientes.Refresh;
    self.oLst_Ctes.Value := self.otClientes.FieldByName('cte_id').Value;
  }
end;

procedure TFRepJCJ_1.oOpt10Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt10.Checked = true) then
  begin
    iOption := self.oOpt10.Tag;
    self.Visible_Fechas(true);
    self.Visible_Rutas(true);
    self.Visible_Clientes(false);
    self.Visible_Modelos(false);
    self.oAll_Chapas.Visible := true;
    self.oChapa.Visible := true;
  end;
end;

procedure TFRepJCJ_1.oOpt11Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt11.Checked = true) then
  begin
    iOption := self.oOpt11.Tag;
    self.Visible_Fechas(true);

    self.Visible_Clientes(true);
    self.oAll_Ctes.Checked := true;
    self.oAll_CtesClick(self);

    self.Visible_Rutas(false);
    self.oAll_Routes.Checked := true;
    self.oAll_RoutesClick(self);

    self.Visible_Modelos(false);
    self.oAll_Modelos.Checked := true;
    self.oAll_ModelosClick(self);

    self.oAll_Chapas.Checked := true;
    self.oAll_ChapasClick(self);
    self.oAll_Chapas.Visible := false;

    self.oChapa.Text := '';
    self.oChapa.Visible := false;
  end;
end;

procedure TFRepJCJ_1.oOpt12Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt12.Checked = true) then
  begin
    iOption := self.oOpt12.Tag;
    self.Visible_Fechas(true);

    self.Visible_Clientes(true);
    self.oAll_Ctes.Checked := true;
    self.oAll_CtesClick(self);

    self.Visible_Rutas(false);
    self.oAll_Routes.Checked := true;
    self.oAll_RoutesClick(self);

    self.Visible_Modelos(false);
    self.oAll_Modelos.Checked := true;
    self.oAll_ModelosClick(self);

    self.oAll_Chapas.Checked := true;
    self.oAll_ChapasClick(self);
    self.oAll_Chapas.Visible := false;

    self.oChapa.Text := '';
    self.oChapa.Visible := false;
  end;

end;

procedure TFRepJCJ_1.oOpt13Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt13.Checked = true) then
  begin
    iOption := self.oOpt13.Tag;
    self.Visible_Fechas(true);

    self.Visible_Clientes(true);
    self.oAll_Ctes.Checked := true;
    self.oAll_CtesClick(self);

    self.Visible_Rutas(false);
    self.oAll_Routes.Checked := true;
    self.oAll_RoutesClick(self);

    self.Visible_Modelos(false);
    self.oAll_Modelos.Checked := true;
    self.oAll_ModelosClick(self);

    self.oAll_Chapas.Checked := true;
    self.oAll_ChapasClick(self);
    self.oAll_Chapas.Visible := false;

    self.oChapa.Text := '';
    self.oChapa.Visible := false;
  end;
end;

procedure TFRepJCJ_1.oOpt1Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt1.Checked = true) then
  begin
    iOption := self.oOpt1.Tag;
    self.Visible_Fechas(true);
    self.Visible_Rutas(false);
    self.Visible_Clientes(false);
    self.Visible_Modelos(false);
    self.oAll_Chapas.Visible := true;
    self.oChapa.Visible := true;
  end;
end;

procedure TFRepJCJ_1.oOpt2Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt2.Checked = true) then
  begin
    iOption := self.oOpt2.Tag;
    self.Visible_Fechas(true);
    self.Visible_Rutas(false);
    self.Visible_Clientes(false);
    self.Visible_Modelos(false);
    self.oAll_Chapas.Visible := true;
    self.oChapa.Visible := true;
  end;
end;

procedure TFRepJCJ_1.oOpt3Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt3.Checked = true) then
  begin
    iOption := self.oOpt3.Tag;
    self.Visible_Fechas(true);
    self.Visible_Rutas(false);
    self.Visible_Clientes(false);
    self.Visible_Modelos(false);
    self.oAll_Chapas.Visible := true;
    self.oChapa.Visible := true;
  end;
end;

procedure TFRepJCJ_1.oOpt4Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt4.Checked = true) then
  begin
    iOption := self.oOpt4.Tag;
    self.Visible_Fechas(false);
    self.Visible_Rutas(false);
    self.Visible_Clientes(false);
    self.Visible_Modelos(false);
    self.olFecha1.Caption := 'Seleccione [Mes/Año]';
    self.oFecha1.EditFormat := 'MM/YYYY';
    self.olFecha1.Visible := true;
    self.oFecha1.Visible := true;
    self.oAll_Chapas.Visible := false;
    self.oChapa.Visible := false;
  end;
end;

procedure TFRepJCJ_1.oOpt5Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt5.Checked = true) then
  begin
    iOption := self.oOpt5.Tag;
    self.Visible_Fechas(true);
    self.Visible_Rutas(false);
    self.Visible_Clientes(true);
    self.Visible_Modelos(false);
    self.oAll_Chapas.Visible := true;
    self.oChapa.Visible := true;
  end;
end;

procedure TFRepJCJ_1.oOpt6Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt6.Checked = true) then
  begin
    iOption := self.oOpt6.Tag;
    self.Visible_Fechas(true);
    self.Visible_Rutas(false);
    self.Visible_Clientes(false);
    self.Visible_Modelos(true);
    self.oAll_Chapas.Visible := false;
    self.oChapa.Visible := false;
  end;
end;

procedure TFRepJCJ_1.oOpt7Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt7.Checked = true) then
  begin
    iOption := self.oOpt7.Tag;
    self.Visible_Fechas(true);
    self.Visible_Rutas(false);
    self.Visible_Clientes(true);
    self.Visible_Modelos(false);
  end;
end;

procedure TFRepJCJ_1.oOpt9Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt9.Checked = true) then
  begin
    iOption := self.oOpt9.Tag;
    self.Visible_Fechas(true);
    self.Visible_Rutas(false);
    self.Visible_Clientes(true);
    self.Visible_Modelos(false);
    self.oAll_Chapas.Visible := true;
    self.oChapa.Visible := true;
  end;
end;

procedure TFRepJCJ_1.oOpt14Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt14.Checked = true) then
  begin
    iOption := self.oOpt14.Tag;
    self.Visible_Fechas(false);
    self.Visible_Rutas(false);
    self.Visible_Clientes(false);
    self.Visible_Modelos(false);
    self.olFecha1.Caption := 'Seleccione [Mes/Año]';
    self.oFecha1.EditFormat := 'MM/YYYY';
    self.olFecha1.Visible := true;
    self.oFecha1.Visible := true;
    self.oAll_Chapas.Visible := false;
    self.oChapa.Visible := false;
  end;
end;

procedure TFRepJCJ_1.oOpt15Click(Sender: TObject);
begin
  iOption := 0;
  if (self.oOpt15.Checked = true) then
  begin
    iOption := self.oOpt15.Tag;
    self.Visible_Fechas(false);
    self.Visible_Rutas(false);
    self.Visible_Clientes(true);
    self.Visible_Modelos(false);
    self.oAll_Chapas.Visible := true;
    self.oChapa.Visible := true;
    self.olFecha1.Caption := 'Seleccione [Mes/Año]';
    self.oFecha1.EditFormat := 'MM/YYYY';
    self.olFecha1.Visible := true;
    self.oFecha1.Visible := true;
  end;

end;

Procedure TFRepJCJ_1.Visible_Clientes(bFlag: boolean);
begin
  self.olCliente.Caption := 'Asignado al Cliente:';
  self.olCliente.Visible := bFlag;
  self.oLst_Ctes.Visible := bFlag;
  self.oAll_Ctes.Visible := bFlag;
  self.oLst_Ctes.ListFieldIndex := 1;
  self.oAll_Ctes.Checked := true;
  self.oAll_CtesClick(self);
end;

Procedure TFRepJCJ_1.Visible_Modelos(bFlag: boolean);
begin
  self.olModelos.Caption := 'Lista de los Modelos disponibles:';

  oLst_Modelos.TOP := oLst_Ctes.TOP;
  oLst_Modelos.LEFT := oLst_Ctes.LEFT;
  oLst_Modelos.WIDTH := oLst_Ctes.WIDTH;
  oLst_Modelos.HEIGHT := oLst_Ctes.HEIGHT;

  olModelos.TOP := olCliente.TOP;
  olModelos.LEFT := olCliente.LEFT;
  olModelos.WIDTH := olCliente.WIDTH;
  olModelos.HEIGHT := olCliente.HEIGHT;

  oAll_Modelos.TOP := oAll_Ctes.TOP;
  oAll_Modelos.LEFT := oAll_Ctes.LEFT;
  oAll_Modelos.WIDTH := oAll_Ctes.WIDTH;
  oAll_Modelos.HEIGHT := oAll_Ctes.HEIGHT;

  self.olModelos.Visible := bFlag;
  self.oLst_Modelos.Visible := bFlag;
  self.oAll_Modelos.Visible := bFlag;
  self.oLst_Modelos.ListFieldIndex := 1;
  self.oAll_Modelos.Checked := true;
  self.oAll_ModelosClick(self);
end;

Procedure TFRepJCJ_1.Visible_Rutas(bFlag: boolean);
begin
  self.olRuta.Caption := 'Lista de las Rutas disponibles:';

  oLst_Rutas.TOP := oLst_Ctes.TOP;
  oLst_Rutas.LEFT := oLst_Ctes.LEFT;
  oLst_Rutas.WIDTH := oLst_Ctes.WIDTH;
  oLst_Rutas.HEIGHT := oLst_Ctes.HEIGHT;

  olRuta.TOP := olCliente.TOP;
  olRuta.LEFT := olCliente.LEFT;
  olRuta.WIDTH := olCliente.WIDTH;
  olRuta.HEIGHT := olCliente.HEIGHT;

  oAll_Routes.TOP := oAll_Ctes.TOP;
  oAll_Routes.LEFT := oAll_Ctes.LEFT;
  oAll_Routes.WIDTH := oAll_Ctes.WIDTH;
  oAll_Routes.HEIGHT := oAll_Ctes.HEIGHT;

  self.olRuta.Visible := bFlag;
  self.oLst_Rutas.Visible := bFlag;

  self.oAll_Routes.Visible := bFlag;
  self.oLst_Rutas.ListFieldIndex := 1;
  self.oAll_Routes.Checked := true;
  self.oAll_RoutesClick(self);
end;

Procedure TFRepJCJ_1.Visible_Fechas(bFlag: boolean);
begin
  self.olFecha1.Caption := 'Desde:';
  self.oFecha1.EditFormat := 'DD/MM/YYYY';
  self.oFecha2.EditFormat := 'DD/MM/YYYY';
  self.olFecha1.Visible := bFlag;
  self.oFecha1.Visible := bFlag;
  self.olFecha2.Visible := bFlag;
  self.oFecha2.Visible := bFlag;
end;

procedure TFRepJCJ_1.oBtn_PreviewClick(Sender: TObject);
begin
  if bSwitchPrev = true then
    self.Show_Report(1)
  else
    self.Show_Report(3);
  self.Escribe_ini;
end;

Function TFRepJCJ_1.Generic_Qry(sOrder: string): Widestring;
var
  sFecha_Ini: string;
  sFecha_Fin: string;
  cSql_Ln, sCod_Chapa, sCod_Cte, sCod_Ruta, sCod_Modelo: string;
begin
  FormatSettings.ShortDateFormat := 'yyyy-MM-dd';
  sFecha_Ini := DateToStr(self.oFecha1.Value);
  sFecha_Fin := DateToStr(self.oFecha2.Value);
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';

  sCod_Cte := fUtilesV20.iif(self.oAll_Ctes.Checked = true, '%', self.oLst_Ctes.KeyValue);
  sCod_Ruta := fUtilesV20.iif(self.oAll_Routes.Checked = true, '%', self.oLst_Rutas.KeyValue);
  sCod_Modelo := fUtilesV20.iif(self.oAll_Modelos.Checked = true, '%', self.oLst_Modelos.KeyValue);
  sCod_Chapa := fUtilesV20.iif(self.oAll_Chapas.Checked = true, '%', self.oChapa.Text);

  cSql_Ln := '';
  cSql_Ln := cSql_Ln + 'SELECT a.* FROM (';
  cSql_Ln := cSql_Ln + 'SELECT ';
  cSql_Ln := cSql_Ln + '	CASE ';
  cSql_Ln := cSql_Ln + '	WHEN op.op_serie=1 THEN concat(DATE_FORMAT(op.op_fecha,"%m-%d-%Y"),"A") ';
  cSql_Ln := cSql_Ln + '	WHEN op.op_serie=2 THEN concat(DATE_FORMAT(op.op_fecha,"%m-%d-%Y"),"B") ';
  cSql_Ln := cSql_Ln + '	WHEN op.op_serie=3 THEN concat(DATE_FORMAT(op.op_fecha,"%m-%d-%Y"),"C") ';
  cSql_Ln := cSql_Ln + '	END AS MasterO, ';
  cSql_Ln := cSql_Ln + '	IF(TRIM(op.cte_nombre_loc)="",ct.cte_nombre_loc,op.cte_nombre_loc) AS LOCAL2, ';
  cSql_Ln := cSql_Ln + '	op.*, ';
  cSql_Ln := cSql_Ln + '	IF(op.op_tot_colect=0,0,(op.op_tot_cred/op.op_tot_colect)*100) AS Porc_Pag, ';
  cSql_Ln := cSql_Ln + '	rutas.rut_nombre, ';
  cSql_Ln := cSql_Ln + '	mt.maqtc_modelo ';
  cSql_Ln := cSql_Ln + 'FROM operacion op ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN clientes   ct ON op.cte_id   = ct.cte_id ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN maquinastc mt ON op.op_chapa = mt.maqtc_chapa ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN rutas         ON ct.rut_id   = rutas.rut_id ';
  cSql_Ln := cSql_Ln + 'WHERE (op.maqtc_tipomaq =1) ';
  cSql_Ln := cSql_Ln + 'AND   (ct.cte_inactivo  =0) ';
  cSql_Ln := cSql_Ln + 'AND   (mt.maqtc_inactivo=0) ';

  if (self.oAll_Emp.Checked = false) then
    cSql_Ln := cSql_Ln + 'AND (op.op_emp_id = "' + trim(self.oLst_emp.Value) + '") ';

  if (self.oAll_Chapas.Checked = false) then
  begin
    if not((trim(sCod_Chapa) = '%') or (trim(sCod_Chapa) = '')) then
      cSql_Ln := cSql_Ln + 'AND (op.op_chapa="' + trim(sCod_Chapa) + '") ';
  end;

  if (self.oAll_Ctes.Checked = false) then
  begin
    if not((trim(sCod_Cte) = '%') or (trim(sCod_Cte) = '')) then
      cSql_Ln := cSql_Ln + 'AND (op.cte_id="' + trim(sCod_Cte) + '") ';
  end;

  if (self.oAll_Routes.Checked = false) then
  begin
    if not((trim(sCod_Ruta) = '%') or (trim(sCod_Ruta) = '')) then
      cSql_Ln := cSql_Ln + 'AND   (ct.rut_id="' + trim(sCod_Ruta) + '") ';
  end;

  if (self.oAll_Modelos.Checked = false) then
  begin
    if not((trim(sCod_Modelo) = '%') or (trim(sCod_Modelo) = '')) then
      cSql_Ln := cSql_Ln + 'AND   (TRIM(op.op_modelo)="' + trim(sCod_Modelo) + '") ';
  end;

  cSql_Ln := cSql_Ln + 'AND   (';
  cSql_Ln := cSql_Ln + '(DATE_FORMAT(op.op_fecha, "%Y-%m-%d") >= "' + sFecha_Ini + '") AND ';
  cSql_Ln := cSql_Ln + '(DATE_FORMAT(op.op_fecha, "%Y-%m-%d") <= "' + sFecha_Fin + '") ';
  cSql_Ln := cSql_Ln + '      )  ';
  cSql_Ln := cSql_Ln + ') a ';

  case StrToInt(sOrder) of
    1:
      cSql_Ln := cSql_Ln + 'ORDER BY  a.LOCAL2, a.MasterO,  a.op_chapa ';
    2:
      cSql_Ln := cSql_Ln + 'ORDER BY  a.MasterO, a.LOCAL2 ';
    3:
      cSql_Ln := cSql_Ln + 'ORDER BY  a.MasterO, a.op_nodoc ';
    4:
      cSql_Ln := cSql_Ln + 'ORDER BY  a.MasterO, a.op_chapa ';
    5:
      cSql_Ln := cSql_Ln + 'ORDER BY  a.MasterO, a.LOCAL2, a.op_chapa ';
    6:
      cSql_Ln := cSql_Ln + 'ORDER BY  a.maqtc_modelo, a.op_chapa ';
    7:
      cSql_Ln := cSql_Ln + 'ORDER BY  a.MasterO, a.LOCAL2, a.op_chapa ';
    8:
      cSql_Ln := cSql_Ln + 'ORDER BY  a.MasterO, a.LOCAL2, a.op_chapa ';
    9:
      cSql_Ln := cSql_Ln + 'ORDER BY  a.LOCAL2, a.op_chapa '; // ,a.MasterO
    10:
      cSql_Ln := cSql_Ln + 'ORDER BY  a.rut_nombre, a.LOCAL2, a.op_chapa ';
    11:
      BEGIN
        cSql_Ln := cSql_Ln + 'GROUP BY  a.LOCAL2, a.op_chapa ';
        cSql_Ln := cSql_Ln + 'ORDER BY  a.LOCAL2, a.op_chapa ';
      END;
  end;
  result := cSql_Ln;
end;

Function TFRepJCJ_1.JCJ_Qry(): Widestring;
var
  cSql_Ln, sCod_Chapa: string;
  myYear, myMonth, myDay: Word;
BEGIN
  DecodeDate(self.oFecha1.Value, myYear, myMonth, myDay);
  self.sMesAno := IntToStr(myMonth) + ' de ' + IntToStr(myYear);

  sCod_Chapa := fUtilesV20.iif(self.oAll_Chapas.Checked = true, '%', self.oChapa.Text);

  cSql_Ln := '';
  cSql_Ln := cSql_Ln + 'SELECT ';
  cSql_Ln := cSql_Ln + '	CASE ';
  cSql_Ln := cSql_Ln + '	WHEN op.op_serie=1 THEN concat(DATE_FORMAT(op.op_fecha,"%m-%d-%Y"),"A") ';
  cSql_Ln := cSql_Ln + '	WHEN op.op_serie=2 THEN concat(DATE_FORMAT(op.op_fecha,"%m-%d-%Y"),"B") ';
  cSql_Ln := cSql_Ln + '	WHEN op.op_serie=3 THEN concat(DATE_FORMAT(op.op_fecha,"%m-%d-%Y"),"C") ';
  cSql_Ln := cSql_Ln + '	END AS MasterO, ';
  cSql_Ln := cSql_Ln + '	IF(TRIM(op.cte_nombre_loc)="",ct.cte_nombre_loc,op.cte_nombre_loc) AS LOCAL2, ';
  cSql_Ln := cSql_Ln + '	op.*, ';
  cSql_Ln := cSql_Ln + '	IF(op.op_tot_colect=0,0,(op.op_tot_cred/op.op_tot_colect)*100) AS Porc_Pag ';
  cSql_Ln := cSql_Ln + 'FROM operacion op ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN clientes   ct ON op.cte_id   = ct.cte_id ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN maquinastc mt ON op.op_chapa = mt.maqtc_chapa ';
  cSql_Ln := cSql_Ln + 'LEFT JOIN rutas         ON ct.rut_id   = rutas.rut_id ';
  cSql_Ln := cSql_Ln + 'WHERE (op.maqtc_tipomaq =1) ';
  cSql_Ln := cSql_Ln + 'AND   (ct.cte_inactivo  =0) ';
  cSql_Ln := cSql_Ln + 'AND   (mt.maqtc_inactivo=0) ';

  if (self.oAll_Emp.Checked = false) then
    cSql_Ln := cSql_Ln + 'AND (op.op_emp_id = ' + QuotedStr(trim(self.oLst_emp.Value)) + ') ';

  cSql_Ln := cSql_Ln + 'AND   (YEAR(op.op_fecha) =' + QuotedStr(IntToStr(myYear)) + ') ';
  cSql_Ln := cSql_Ln + 'AND 	(MONTH(op.op_fecha)=' + QuotedStr(IntToStr(myMonth)) + ') ';
  if (self.oAll_Chapas.Checked = false) then
  begin
    if not((trim(sCod_Chapa) = '%') or (trim(sCod_Chapa) = '')) then
      cSql_Ln := cSql_Ln + 'AND (op.op_chapa=' + QuotedStr(trim(sCod_Chapa)) + ') ';
  end;
  cSql_Ln := cSql_Ln + 'ORDER BY op.op_chapa ';
  result := cSql_Ln;
END;

Function TFRepJCJ_1.NETWIN_Qry(): Widestring;
var
  cSql_Ln, sCod_Chapa, sCod_Cte, sCod_Ruta, sCod_Modelo: string;
  myYear, myMonth, myDay: Word;
BEGIN
  DecodeDate(self.oFecha1.Value, myYear, myMonth, myDay);
  self.sMesAno := IntToStr(myMonth) + ' de ' + IntToStr(myYear);

  sCod_Cte := fUtilesV20.iif(self.oAll_Ctes.Checked = true, '%', self.oLst_Ctes.KeyValue);
  sCod_Ruta := fUtilesV20.iif(self.oAll_Routes.Checked = true, '%', self.oLst_Rutas.KeyValue);
  sCod_Modelo := fUtilesV20.iif(self.oAll_Modelos.Checked = true, '%', self.oLst_Modelos.KeyValue);
  sCod_Chapa := fUtilesV20.iif(self.oAll_Chapas.Checked = true, '%', self.oChapa.Text);

  cSql_Ln := '';
  cSql_Ln := cSql_Ln + 'SELECT a.*, ';
  cSql_Ln := cSql_Ln + '	ROUND((a.NetWinM/No_Semanas),2) AS NetWinS, ';
  cSql_Ln := cSql_Ln + '	ROUND((a.NetWinM/30),2) 			AS NetWinD, ';
  cSql_Ln := cSql_Ln + '	ROUND((a.No_Semanas*37.50),2) 		AS ImpSem ';
  cSql_Ln := cSql_Ln + 'FROM ( ';
  cSql_Ln := cSql_Ln + '	SELECT ';
  cSql_Ln := cSql_Ln +
    '		@FechaIni := DATE(CONCAT(YEAR(op.op_fecha),"-",MONTH(op.op_fecha),"-01")) 										 AS FechaIni, ';
  cSql_Ln := cSql_Ln +
    '		@FechaFin := DATE_ADD( DATE(CONCAT(YEAR(op.op_fecha),"-",MONTH(op.op_fecha)+1,"-01")), INTERVAL -1 DAY) AS FechaFin, ';
  cSql_Ln := cSql_Ln + '		op.op_chapa, ';
  cSql_Ln := cSql_Ln + '		op.op_modelo, ';
  cSql_Ln := cSql_Ln + '		IF(TRIM(op.cte_nombre_loc)="",ct.cte_nombre_loc,op.cte_nombre_loc) AS LOCAL2, ';
  cSql_Ln := cSql_Ln + '		FLOOR((DATEDIFF(@FechaFin,@FechaIni)+1)/7) AS No_Semanas, ';
  cSql_Ln := cSql_Ln + '		COUNT(op.op_chapa)      AS No_Colect, ';
  cSql_Ln := cSql_Ln + '		SUM(op.op_tot_colect)   AS op_tot_colect, ';
  cSql_Ln := cSql_Ln + '		SUM(op.op_tot_cred)     AS op_tot_cred, ';
  cSql_Ln := cSql_Ln + '		SUM(op.op_tot_dev)      AS op_tot_dev, ';
  cSql_Ln := cSql_Ln + '		SUM(op.op_tot_timbres) + SUM(op.op_tot_impjcj) + SUM(op.op_tot_impmunic) AS IMP, ';
  cSql_Ln := cSql_Ln + '		SUM(op.op_tot_sub)      AS op_tot_sub, ';
  cSql_Ln := cSql_Ln + '		SUM(op.op_tot_netoemp)  AS op_tot_netoemp, ';
  cSql_Ln := cSql_Ln + '		SUM(op.op_tot_brutoemp) AS op_tot_brutoemp, ';
  cSql_Ln := cSql_Ln + '		IF(SUM(op.op_tot_colect)=0,0,(SUM(op.op_tot_cred)/SUM(op.op_tot_colect))*100) AS Porc_Pag, ';
  cSql_Ln := cSql_Ln +
    '		@NetWin := ROUND(IF(SUM(op.op_tot_colect)=0,0.00,(SUM(op.op_tot_colect)-SUM(op.op_tot_cred))),2) AS NetWinM ';
  cSql_Ln := cSql_Ln + '	FROM operacion op ';
  cSql_Ln := cSql_Ln + '	LEFT JOIN clientes   ct ON op.cte_id   = ct.cte_id ';
  cSql_Ln := cSql_Ln + '	LEFT JOIN maquinastc mt ON op.op_chapa = mt.maqtc_chapa ';
  cSql_Ln := cSql_Ln + '	WHERE (op.maqtc_tipomaq =1)  ';
  cSql_Ln := cSql_Ln + '	AND   (ct.cte_inactivo  =0) ';
  cSql_Ln := cSql_Ln + '	AND   (mt.maqtc_inactivo=0) ';
  cSql_Ln := cSql_Ln + '  AND   (YEAR(op.op_fecha) =' + QuotedStr(IntToStr(myYear)) + ') ';
  cSql_Ln := cSql_Ln + '  AND 	(MONTH(op.op_fecha)=' + QuotedStr(IntToStr(myMonth)) + ') ';

  if (self.oAll_Emp.Checked = false) then
    cSql_Ln := cSql_Ln + 'AND (op.op_emp_id = ' + QuotedStr(trim(self.oLst_emp.Value)) + ') ';

  if (self.oAll_Ctes.Checked = false) then
  begin
    if not((trim(sCod_Cte) = '%') or (trim(sCod_Cte) = '')) then
      cSql_Ln := cSql_Ln + 'AND (op.cte_id=' + QuotedStr(trim(sCod_Cte)) + ') ';
  end;

  if (self.oAll_Chapas.Checked = false) then
  begin
    if not((trim(sCod_Chapa) = '%') or (trim(sCod_Chapa) = '')) then
      cSql_Ln := cSql_Ln + 'AND (op.op_chapa=' + QuotedStr(trim(sCod_Chapa)) + ') ';
  end;

  if (self.oAll_Routes.Checked = false) then
  begin
    if not((trim(sCod_Ruta) = '%') or (trim(sCod_Ruta) = '')) then
      cSql_Ln := cSql_Ln + 'AND   (ct.rut_id=' + QuotedStr(trim(sCod_Ruta)) + ') ';
  end;

  if (self.oAll_Modelos.Checked = false) then
  begin
    if not((trim(sCod_Modelo) = '%') or (trim(sCod_Modelo) = '')) then
      cSql_Ln := cSql_Ln + 'AND   (TRIM(op.op_modelo)=' + QuotedStr(trim(sCod_Modelo)) + ') ';
  end;

  cSql_Ln := cSql_Ln + '	GROUP BY  op.op_chapa) a ';
  cSql_Ln := cSql_Ln + 'ORDER BY a.op_chapa ';
  result := cSql_Ln;
END;

procedure TFRepJCJ_1.Show_Report(nOption: integer);
var
  icnt1: integer;
  icnt2: integer;
  sOrder: string;
  sLn1: Widestring;
  sLn2: string;
  sCod_Chapa, sCod_Cte, sCod_Ruta, sCod_Modelo: string;
  sFecha_Ini: string;
  sFecha_Fin: string;
begin

  FormatSettings.ShortDateFormat := 'yyyy-MM-dd';
  sFecha_Ini := DateToStr(self.oFecha1.Value);
  sFecha_Fin := DateToStr(self.oFecha2.Value);
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';

  reportes.Initialize;
  reportes.Report.Vars[1].Name := 'Fecha_desde';
  reportes.Report.Vars[1].Value := FormatDateTime('dd/mm/yyyy', self.oFecha1.Value);
  reportes.Report.Vars[2].Name := 'Fecha_hasta';
  reportes.Report.Vars[2].Value := FormatDateTime('dd/mm/yyyy', self.oFecha2.Value);
  reportes.oFrom := FRepJCJ_1;
  sLn1 := 'SELECT * FROM empresas WHERE emp_id= ' + QuotedStr(IntToStr(UtilesV20.iId_Empresa)) +
    ' ORDER BY emp_descripcion ';
  reportes.Queries[1].active := true;
  reportes.Queries[1].Sql_String := sLn1;
  reportes.Queries[1].DB_DSName := 'dsEmpresa';
  reportes.Queries[1].Sql_IsProcedure := false;

  sCod_Cte := fUtilesV20.iif(self.oAll_Ctes.Checked = true, '%', self.oLst_Ctes.KeyValue);
  sCod_Ruta := fUtilesV20.iif(self.oAll_Routes.Checked = true, '%', self.oLst_Rutas.KeyValue);
  sCod_Modelo := fUtilesV20.iif(self.oAll_Modelos.Checked = true, '%', self.oLst_Modelos.KeyValue);
  sCod_Chapa := fUtilesV20.iif(self.oAll_Chapas.Checked = true, '%', self.oChapa.Text);

  if ((oOpt1.Checked = true) OR (oOpt2.Checked = true) OR (oOpt3.Checked = true) OR (oOpt5.Checked = true) OR
    (oOpt6.Checked = true) OR (oOpt7.Checked = true) OR (oOpt9.Checked = true) OR (oOpt10.Checked = true)) then
  begin

    if ((oOpt1.Checked = true) OR (oOpt5.Checked = true)) then
    begin
      sOrder := '1';
      reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_01.fr3';
    end
    else if (oOpt2.Checked = true) then
    begin
      sOrder := '2';
      reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_02.fr3';
    end
    else if (oOpt3.Checked = true) then
    begin
      sOrder := '3';
      reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_03.fr3';
    end
    else if (oOpt6.Checked = true) then
    begin
      sOrder := '6';
      reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_06.fr3';
    end
    else if (oOpt7.Checked = true) then
    begin
      sOrder := '7';
      reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_07.fr3';
    end
    else if (oOpt9.Checked = true) then
    begin
      sOrder := '9';
      reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_09.fr3';
    end
    else if (oOpt10.Checked = true) then
    begin
      sOrder := '10';
      reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_10.fr3';
    end;

    sLn2 := self.Generic_Qry(sOrder);
  end
  else if ((self.oOpt4.Checked = true) or (self.oOpt14.Checked = true)) then
  begin

    sOrder := '4';
    reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_14.fr3';

    sLn2 := self.JCJ_Qry();

    // reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_04.fr3';
    reportes.Report.Vars[3].Name := 'F_MesAno';
    reportes.Report.Vars[3].Value := sMesAno;

    reportes.Report.Vars[4].Name := 'cEmpresaSel';
    if (self.oAll_Emp.Checked = false) then
      reportes.Report.Vars[4].Value := SysUtils.QuotedStr(trim(self.oLst_emp.Value))
    else
      reportes.Report.Vars[4].Value := 'Todas las empresas.';
  end
  else if (oOpt11.Checked = true) then
  begin
    sOrder := '11';
    reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_11.fr3';

    sLn2 := '';
    sLn2 := sLn2 + 'SELECT a.* FROM (';
    sLn2 := sLn2 + '  SELECT ';
    sLn2 := sLn2 + '	  op.op_chapa, ';
    sLn2 := sLn2 + '	  op.op_modelo, ';
    sLn2 := sLn2 + '	  IF(TRIM(op.cte_nombre_loc)="",ct.cte_nombre_loc,op.cte_nombre_loc) AS LOCAL2, ';
    sLn2 := sLn2 + '	  COUNT(op.op_chapa)		  AS No_Colect, ';
    sLn2 := sLn2 + '	  SUM(op.op_tot_colect) 	AS op_tot_colect, ';
    sLn2 := sLn2 + '	  SUM(op.op_tot_cred) 		AS op_tot_cred, ';
    sLn2 := sLn2 + '	  SUM(op.op_tot_dev) 		AS op_tot_dev, ';
    sLn2 := sLn2 + '	  SUM(op.op_tot_timbres) + SUM(op.op_tot_impjcj) + SUM(op.op_tot_impmunic) AS IMP, ';
    sLn2 := sLn2 + '	  SUM(op.op_tot_sub) 		AS op_tot_sub, ';
    sLn2 := sLn2 + '	  SUM(op.op_tot_netoemp) AS op_tot_netoemp, ';
    sLn2 := sLn2 + '	  SUM(op.op_tot_brutoemp) AS op_tot_brutoemp, ';
    sLn2 := sLn2 + '	  IF(SUM(op.op_tot_colect)=0,0,(SUM(op.op_tot_cred)/SUM(op.op_tot_colect))*100) AS Porc_Pag, ';
    sLn2 := sLn2 + '	  FLOOR(DATEDIFF("' + sFecha_Fin + '","' + sFecha_Ini + '")/7)*37.50 as ImpSem ';
    sLn2 := sLn2 + 'FROM operacion op ';
    sLn2 := sLn2 + 'LEFT JOIN clientes   ct ON op.cte_id   = ct.cte_id ';
    sLn2 := sLn2 + 'LEFT JOIN maquinastc mt ON op.op_chapa = mt.maqtc_chapa ';
    sLn2 := sLn2 + 'WHERE (op.maqtc_tipomaq =1) ';
    sLn2 := sLn2 + 'AND   (ct.cte_inactivo  =0) ';
    sLn2 := sLn2 + 'AND   (mt.maqtc_inactivo=0) ';

    if (self.oAll_Emp.Checked = false) then
      sLn2 := sLn2 + 'AND (op.op_emp_id = ' + QuotedStr(trim(self.oLst_emp.Value)) + ') ';

    if not((trim(sCod_Chapa) = '%') or (trim(sCod_Chapa) = '')) then
      sLn2 := sLn2 + 'AND (op.op_chapa=' + QuotedStr(trim(sCod_Chapa)) + ') ';

    if not((trim(sCod_Cte) = '%') or (trim(sCod_Cte) = '')) then
      sLn2 := sLn2 + 'AND (op.cte_id=' + QuotedStr(trim(sCod_Cte)) + ') ';

    sLn2 := sLn2 + 'AND   (';
    sLn2 := sLn2 + '(DATE_FORMAT(op.op_fecha, "%Y-%m-%d") >= "' + sFecha_Ini + '") AND ';
    sLn2 := sLn2 + '(DATE_FORMAT(op.op_fecha, "%Y-%m-%d") <= "' + sFecha_Fin + '") ';
    sLn2 := sLn2 + '      )  ';
    sLn2 := sLn2 + 'GROUP BY  op.op_chapa ';

    sLn2 := sLn2 + ') a ';
    sLn2 := sLn2 + 'ORDER BY  a.op_chapa ';
  end
  else if (oOpt12.Checked = true) then
  begin
    sOrder := '12';
    reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_12.fr3';

    sLn2 := '';
    sLn2 := sLn2 + ' 	SELECT ';
    sLn2 := sLn2 + '		IF(TRIM(op.cte_nombre_loc)="",ct.cte_nombre_loc,op.cte_nombre_loc) AS LOCAL2, ';
    sLn2 := sLn2 + '		op.op_chapa, ';
    sLn2 := sLn2 + '		op.op_modelo, ';
    sLn2 := sLn2 + '		DATE_FORMAT(op.op_fecha,"%d/%m/%y") AS op_fecha, ';
    sLn2 := sLn2 + '		op.op_tot_colect,';
    sLn2 := sLn2 + '		op.op_tot_cred, ';
    sLn2 := sLn2 + '		op.op_tot_sub, ';
    sLn2 := sLn2 + '		IF(op.op_tot_colect=0,0,(op.op_tot_cred/op.op_tot_colect)*100) AS Porc_Pag ';
    sLn2 := sLn2 + 'FROM operacion op ';
    sLn2 := sLn2 + 'LEFT JOIN clientes   ct ON op.cte_id   = ct.cte_id ';
    sLn2 := sLn2 + 'LEFT JOIN maquinastc mt ON op.op_chapa = mt.maqtc_chapa ';
    sLn2 := sLn2 + 'WHERE (op.maqtc_tipomaq =1) ';
    sLn2 := sLn2 + 'AND   (ct.cte_inactivo  =0) ';
    sLn2 := sLn2 + 'AND   (mt.maqtc_inactivo=0) ';

    if (self.oAll_Emp.Checked = false) then
      sLn2 := sLn2 + 'AND (op.op_emp_id = ' + QuotedStr(trim(self.oLst_emp.Value)) + ') ';

    if not((trim(sCod_Chapa) = '%') or (trim(sCod_Chapa) = '')) then
      sLn2 := sLn2 + 'AND (op.op_chapa=' + QuotedStr(trim(sCod_Chapa)) + ') ';

    if not((trim(sCod_Cte) = '%') or (trim(sCod_Cte) = '')) then
      sLn2 := sLn2 + 'AND (op.cte_id=' + QuotedStr(trim(sCod_Cte)) + ') ';

    sLn2 := sLn2 + 'AND   (';
    sLn2 := sLn2 + '(DATE_FORMAT(op.op_fecha, "%Y-%m-%d") >= "' + sFecha_Ini + '") AND ';
    sLn2 := sLn2 + '(DATE_FORMAT(op.op_fecha, "%Y-%m-%d") <= "' + sFecha_Fin + '") ';
    sLn2 := sLn2 + '      )  ';

    sLn2 := sLn2 + 'ORDER BY  1,2,4 ';
  end
  else if (oOpt13.Checked = true) then
  begin
    reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_13.fr3';

    sLn2 := '';
    sLn2 := sLn2 + 'SELECT ';
    sLn2 := sLn2 + '	IF(TRIM(op.cte_nombre_loc)="",ct.cte_nombre_loc,op.cte_nombre_loc) AS LOCAL2, ';
    sLn2 := sLn2 + '	DATE_FORMAT(op.op_fecha,"%Y-%m") AS op_fecha, ';
    sLn2 := sLn2 + '  SUM(op.op_tot_colect) 	AS op_tot_colect, ';
    sLn2 := sLn2 + '  SUM(op.op_tot_cred) 		AS op_tot_cred  , ';
    sLn2 := sLn2 + '	SUM(op.op_tot_sub) 		  AS op_tot_sub   , ';
    sLn2 := sLn2 +
      '	ROUND(IF(SUM(op.op_tot_colect)=0,0,(SUM(op.op_tot_cred)/SUM(op.op_tot_colect))*100),2) AS Porc_Pag ';
    sLn2 := sLn2 + 'FROM operacion op ';
    sLn2 := sLn2 + 'LEFT JOIN clientes   ct ON op.cte_id   = ct.cte_id ';
    sLn2 := sLn2 + 'LEFT JOIN maquinastc mt ON op.op_chapa = mt.maqtc_chapa ';
    sLn2 := sLn2 + 'WHERE (op.maqtc_tipomaq =1) ';
    sLn2 := sLn2 + 'AND   (ct.cte_inactivo  =0) ';
    sLn2 := sLn2 + 'AND   (mt.maqtc_inactivo=0) ';

    if (self.oAll_Emp.Checked = false) then
      sLn2 := sLn2 + 'AND (op.op_emp_id = ' + QuotedStr(trim(self.oLst_emp.Value)) + ') ';

    if not((trim(sCod_Chapa) = '%') or (trim(sCod_Chapa) = '')) then
      sLn2 := sLn2 + 'AND (op.op_chapa=' + QuotedStr(trim(sCod_Chapa)) + ') ';

    if not((trim(sCod_Cte) = '%') or (trim(sCod_Cte) = '')) then
      sLn2 := sLn2 + 'AND (op.cte_id=' + QuotedStr(trim(sCod_Cte)) + ') ';

    sLn2 := sLn2 + 'AND   (';
    sLn2 := sLn2 + '(DATE_FORMAT(op.op_fecha, "%Y-%m-%d") >= "' + sFecha_Ini + '") AND ';
    sLn2 := sLn2 + '(DATE_FORMAT(op.op_fecha, "%Y-%m-%d") <= "' + sFecha_Fin + '") ';
    sLn2 := sLn2 + '      )  ';

    sLn2 := sLn2 + 'GROUP BY 1,DATE_FORMAT(op.op_fecha,"%Y-%m") ';
    sLn2 := sLn2 + 'ORDER BY 1,DATE_FORMAT(op.op_fecha,"%Y-%m") ';
  end
  else if (oOpt15.Checked = true) then
  begin
    sOrder := '15';
    reportes.Report.File_Name := ExtractFilePath(application.ExeName) + 'Reportes\Rep_15.fr3';
    sLn2 := self.NETWIN_Qry();
  end;

  reportes.Queries[2].active := true;
  reportes.Queries[2].Sql_String := sLn2;
  reportes.Queries[2].DB_DSName := 'dsOperacion';
  reportes.Queries[2].Sql_IsProcedure := false;

  reportes.Report.OutOption := nOption;
  reportes.Prepare;

  reportes.Make_report;
  reportes.Clear_all;
end;

procedure TFRepJCJ_1.Escribe_ini;
var
  oFileIni: Tinifile;
  cUser, cComp: string;
begin
  oFileIni := Tinifile.Create(ExtractFilePath(application.ExeName) + 'Data\Config.ini');
  oFileIni.WriteInteger('REPORTS', 'ioption', iOption);
  oFileIni.WriteDate('REPORTS', 'oFecha1', self.oFecha1.Value);
  oFileIni.WriteDate('REPORTS', 'oFecha2', self.oFecha2.Value);
  oFileIni.WriteBool('REPORTS', 'oAll_Chapas', self.oAll_Chapas.Checked);
  oFileIni.WriteString('REPORTS', 'oChapa', self.oChapa.Text);
  oFileIni.WriteBool('REPORTS', 'oAll_Ctes', self.oAll_Ctes.Checked);
  oFileIni.WriteInteger('REPORTS', 'oLst_Ctes', self.oLst_Ctes.Value);
  oFileIni.WriteBool('REPORTS', 'oAll_Modelos', self.oAll_Modelos.Checked);
  oFileIni.WriteInteger('REPORTS', 'oLst_Rutas', self.oLst_Rutas.Value);
  oFileIni.WriteBool('REPORTS', 'oAll_Routes', self.oAll_Routes.Checked);
  oFileIni.WriteInteger('REPORTS', 'oLst_Modelos', self.oLst_Rutas.Value);
  oFileIni.Free;
end;

procedure TFRepJCJ_1.Lee_ini;
var
  oFileIni: Tinifile;
  cUser, cComp: string;
begin
  oFileIni := Tinifile.Create(ExtractFilePath(application.ExeName) + 'Data\Config.ini');

  iOption := oFileIni.ReadInteger('REPORTS', 'ioption', 1);
  self.oFecha1.Value := oFileIni.ReadDate('REPORTS', 'oFecha1', Now());
  self.oFecha2.Value := oFileIni.ReadDate('REPORTS', 'oFecha2', Now());

  case iOption of
    1:
      begin
        self.oOpt1.SetFocus;
        self.oOpt1.Checked := true;
        self.oOpt1Click(self);
      end;
    2:
      begin
        self.oOpt2.SetFocus;
        self.oOpt2.Checked := true;
        self.oOpt2Click(self);
      end;
    3:
      begin
        self.oOpt3.SetFocus;
        self.oOpt3.Checked := true;
        self.oOpt3Click(self);
      end;
    4:
      begin
        self.oOpt7.SetFocus;
        self.oOpt7.Checked := true;
        self.oOpt7Click(self);
      end;
    5:
      begin
        self.oOpt9.SetFocus;
        self.oOpt9.Checked := true;
        self.oOpt9Click(self);
      end;
    6:
      begin
        self.oOpt10.SetFocus;
        self.oOpt10.Checked := true;
        self.oOpt10Click(self);
      end;
    7:
      begin
        self.oOpt4.SetFocus;
        self.oOpt4.Checked := true;
        self.oOpt4Click(self);
      end;
    8:
      begin
        self.oOpt5.SetFocus;
        self.oOpt5.Checked := true;
        self.oOpt5Click(self);
      end;
    9:
      begin
        self.oOpt6.SetFocus;
        self.oOpt6.Checked := true;
        self.oOpt6Click(self);
      end;
    10:
      begin
        self.oOpt11.SetFocus;
        self.oOpt11.Checked := true;
        self.oOpt11Click(self);
      end;
    11:
      begin
        self.oOpt12.SetFocus;
        self.oOpt12.Checked := true;
        self.oOpt12Click(self);
      end;
    12:
      begin
        self.oOpt13.SetFocus;
        self.oOpt13.Checked := true;
        self.oOpt13Click(self);
      end;
  end;

  self.oAll_Chapas.Checked := oFileIni.ReadBool('REPORTS', 'oAll_Chapas', false);
  self.oChapa.Text := oFileIni.ReadString('REPORTS', 'oChapa', '');
  self.oAll_Ctes.Checked := oFileIni.ReadBool('REPORTS', 'oAll_Ctes', false);
  self.oLst_Ctes.Value := oFileIni.ReadInteger('REPORTS', 'oLst_Ctes', 1);
  self.oAll_Modelos.Checked := oFileIni.ReadBool('REPORTS', 'oAll_Modelos', false);
  self.oLst_Rutas.Value := oFileIni.ReadInteger('REPORTS', 'oLst_Rutas', 1);
  self.oAll_Routes.Checked := oFileIni.ReadBool('REPORTS', 'oAll_Routes', false);
  self.oLst_Rutas.Value := oFileIni.ReadInteger('REPORTS', 'oLst_Rutas', 1);
  oFileIni.Free;
end;

end.
