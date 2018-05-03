unit Captura2;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, XPMan, StdCtrls,
  Buttons, PngBitBtn, DB, DBGridEh,
  DBLookupEh, Mask, DBCtrlsEh, DBCtrls, ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait;

type
  TfCaptura2 = class(TForm)
    XPManifest1: TXPManifest;
    StatusBar1: TStatusBar;
    oDC_Operacion: TDataSource;
    oFecha: TDBDateTimeEditEh;
    oLst_Empresa: TDBLookupComboboxEh;
    oLst_Clientes: TDBLookupComboboxEh;
    oLst_Municipios: TDBLookupComboboxEh;
    oDC_Empresa: TDataSource;
    oDC_Cliente: TDataSource;
    oDC_Municipio: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    oModelo: TDBEdit;
    Label4: TLabel;
    oMaquina: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    oSemana: TDBNumberEditEh;
    Shape1: TShape;
    Label8: TLabel;
    Shape2: TShape;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    otOp_ea_metroac: TDBNumberEditEh;
    Label10: TLabel;
    otOp_ea_metroan: TDBNumberEditEh;
    Label11: TLabel;
    otOp_eb_metroac: TDBNumberEditEh;
    Label12: TLabel;
    otOp_eb_metroan: TDBNumberEditEh;
    Label13: TLabel;
    otop_e_pantalla: TDBNumberEditEh;
    Label14: TLabel;
    Label15: TLabel;
    otOp_observ: TDBMemo;
    Label23: TLabel;
    Label24: TLabel;
    GroupBox3: TGroupBox;
    olTot_Colectado: TLabel;
    otOp_tot_colect: TDBNumberEditEh;
    Label26: TLabel;
    otOp_tot_fono: TDBNumberEditEh;
    otOp_tot_impmunic: TDBNumberEditEh;
    Label28: TLabel;
    otOp_tot_Audic: TDBNumberEditEh;
    Label29: TLabel;
    otOp_tot_tec: TDBNumberEditEh;
    Label30: TLabel;
    otOp_tot_dev: TDBNumberEditEh;
    Label31: TLabel;
    otOp_tot_otros: TDBNumberEditEh;
    Label33: TLabel;
    otOp_tot_sub: TDBNumberEditEh;
    Label34: TLabel;
    otOp_tot_itbm: TDBNumberEditEh;
    Label35: TLabel;
    otOp_tot_tot: TDBNumberEditEh;
    Label36: TLabel;
    otOp_tot_brutoemp: TDBNumberEditEh;
    olBruto_Cte: TLabel;
    otOp_tot_brutoloc: TDBNumberEditEh;
    otOp_tot_netoloc: TDBNumberEditEh;
    olNeto_Cte: TLabel;
    Label39: TLabel;
    otOp_tot_netoemp: TDBNumberEditEh;
    Label44: TLabel;
    Label45: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    oBtnNew: TPngBitBtn;
    oBtnEdit: TPngBitBtn;
    oBtnDelete: TPngBitBtn;
    oBtnFind: TPngBitBtn;
    oBtnExit: TPngBitBtn;
    oBtnSave: TPngBitBtn;
    oBtnAbort: TPngBitBtn;
    oSql_Text: TMemo;
    oDC_Ruta: TDataSource;
    Label51: TLabel;
    oLst_Rutas: TDBLookupComboboxEh;
    DBNavigator1: TDBNavigator;
    CheckBox1: TCheckBox;
    Shape3: TShape;
    Shape4: TShape;
    oDoc_Fnd: TEdit;
    oDocumento: TDBEdit;
    cbb1: TDBComboBoxEh;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Label16: TLabel;
    otOp_tot_spac: TDBNumberEditEh;
    Label27: TLabel;
    Label56: TLabel;
    otEmpresa: TFDTable;
    otClientes: TFDTable;
    oQry_Fnd: TFDQuery;
    otMunicipios: TFDTable;
    otOperacion: TFDTable;
    otRutas: TFDTable;
    oConection: TFDConnection;
    procedure oBtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure oBtnNewClick(Sender: TObject);
    procedure Action_Control(pOption: integer);
    procedure oBtnEditClick(Sender: TObject);
    procedure oBtnDeleteClick(Sender: TObject);
    procedure oBtnFindClick(Sender: TObject);
    procedure oBtnAbortClick(Sender: TObject);
    procedure oBtnSaveClick(Sender: TObject);
    function Buscar_Maquina(var oQry_Fnd: TFDQuery; pNum_Maq: string): boolean;
    procedure oMaquinaExit(Sender: TObject);
    procedure Calc_Tot(iForce: integer);
    procedure Calc_Sub_Tot;
    procedure otOp_tot_colectExit(Sender: TObject);
    procedure otOp_tot_impmunicExit(Sender: TObject);
    procedure otOp_tot_AudicExit(Sender: TObject);
    procedure otOp_tot_tecExit(Sender: TObject);
    procedure otOp_tot_devExit(Sender: TObject);
    procedure otOp_tot_otrosExit(Sender: TObject);
    procedure otOp_tot_credExit(Sender: TObject);
    procedure otOp_tot_fonoExit(Sender: TObject);
    procedure Clear_Screen;
    procedure Enabled_Screen(bFlag: boolean);
    procedure FormShow(Sender: TObject);
    procedure otop_e_pantallaExit(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Label15DblClick(Sender: TObject);
    procedure Label22DblClick(Sender: TObject);
    procedure Label14DblClick(Sender: TObject);
    procedure Label21DblClick(Sender: TObject);
    procedure oDoc_FndExit(Sender: TObject);
    procedure oDocumentoExit(Sender: TObject);
    procedure Label2DblClick(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure Label3DblClick(Sender: TObject);
    procedure Label51DblClick(Sender: TObject);
    procedure Label5DblClick(Sender: TObject);
    procedure otOp_eb_metroacExit(Sender: TObject);
    procedure otOp_ea_metroanExit(Sender: TObject);
    procedure otOp_eb_metroanExit(Sender: TObject);
    procedure EnterAsTab(Sender: TObject; var Key: Char);
    procedure Calc_Dif_Ent(A: boolean);
    procedure otOp_ea_metroacExit(Sender: TObject);
    procedure AssgnTabs;
    procedure Label10Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure oDoc_FndKeyPress(Sender: TObject; var Key: Char);
    function Find_In_Op(Nodoc: string): boolean;
    procedure otOp_ea_metroacClick(Sender: TObject);
    procedure otOp_eb_metroacClick(Sender: TObject);
    procedure otOp_ea_metroanClick(Sender: TObject);
    procedure otOp_eb_metroanClick(Sender: TObject);
    procedure otop_e_pantallaClick(Sender: TObject);
    procedure otOp_tot_colectClick(Sender: TObject);
    procedure otOp_tot_fonoClick(Sender: TObject);
    procedure otOp_tot_impmunicClick(Sender: TObject);
    procedure otOp_tot_AudicClick(Sender: TObject);
    procedure otOp_tot_tecClick(Sender: TObject);
    procedure otOp_tot_devClick(Sender: TObject);
    procedure otOp_tot_otrosClick(Sender: TObject);
    procedure otOp_tot_subClick(Sender: TObject);
    procedure otOp_tot_itbmClick(Sender: TObject);
    procedure otOp_tot_totClick(Sender: TObject);
    procedure otOp_tot_brutolocClick(Sender: TObject);
    procedure otOp_tot_brutoempClick(Sender: TObject);
    procedure otOp_tot_netolocClick(Sender: TObject);
    procedure otOp_tot_netoempClick(Sender: TObject);
    procedure oSemanaClick(Sender: TObject);
    procedure oDocumentoClick(Sender: TObject);
    procedure oMaquinaClick(Sender: TObject);
    procedure otOp_tot_spacClick(Sender: TObject);
    procedure otOp_tot_spacExit(Sender: TObject);
    procedure otOperacionBeforePost(DataSet: TDataSet);
    procedure oMoneyADblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  Op = object
    id_Maquina: integer;
    Porc_Loc: single;
    iItbms: single;
    Suma_Efec: single;
    Suma_Cred: single;
    Denom_Ent_Fac: integer;
    Denom_Sal_Fac: integer;
    Denom_Ent_Val: single;
    Denom_Sal_Val: single;
    MetroA_EntDif: integer;
    MetroA_SalDif: integer;
    MetroB_EntDif: integer;
    MetroB_SalDif: integer;
  end;

var
  fCaptura2: TfCaptura2;
  bFoundMach: boolean;
  bChangeMeters: boolean;
  MyOp: Op;

implementation

uses utilesV20, Denominaciones, Clientes, Empresa, MaquinasTC, Municipios,
  rutas,
  UTEval;
{$R *.dfm}

procedure TfCaptura2.FormCreate(Sender: TObject);
begin
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  bFoundMach := false;
  bChangeMeters := true;
  MyOp.iItbms := 0;

  oConection.Connected := false;

  otEmpresa.close;
  otClientes.close;
  otMunicipios.close;
  otOperacion.close;
  otRutas.close;

  otEmpresa.Connection := fUtilesV20.oPublicCnn;
  otClientes.Connection := fUtilesV20.oPublicCnn;
  otMunicipios.Connection := fUtilesV20.oPublicCnn;
  otOperacion.Connection := fUtilesV20.oPublicCnn;
  otRutas.Connection := fUtilesV20.oPublicCnn;

  otEmpresa.Active := true;
  otClientes.Active := true;
  otMunicipios.Active := true;
  otOperacion.Active := true;
  otRutas.Active := true;

  oDC_Empresa.DataSet := otEmpresa;
  oDC_Cliente.DataSet := otClientes;
  oDC_Municipio.DataSet := otMunicipios;
  oDC_Operacion.DataSet := otOperacion;
  oDC_Ruta.DataSet := otRutas;

  oDC_Empresa.Enabled := true;
  oDC_Cliente.Enabled := true;
  oDC_Municipio.Enabled := true;
  oDC_Operacion.Enabled := true;
  oDC_Ruta.Enabled := true;
  self.AssgnTabs;
end;

procedure TfCaptura2.FormShow(Sender: TObject);
begin
  self.otOperacion.Last;
  Enabled_Screen(false);
end;

procedure TfCaptura2.Label10Click(Sender: TObject);
begin
  self.otOp_ea_metroan.Enabled := true;
end;

procedure TfCaptura2.Label12Click(Sender: TObject);
begin
  self.otOp_eb_metroan.Enabled := true;
end;

procedure TfCaptura2.Label14DblClick(Sender: TObject);
begin
  if ((otOperacion.State = dsInsert) or (otOperacion.State = dsEdit)) then
  begin
    Application.CreateForm(TfDenom, fDenom);
    fDenom.showmodal;
    fDenom.free;
    if oQry_Fnd.State <> dsInactive then
    begin
      oQry_Fnd.Refresh;
      otOperacion.FieldByName('den_fact_e').AsInteger :=
        oQry_Fnd.FieldByName('den_fact_e').AsInteger;
      otOperacion.FieldByName('den_fact_s').AsInteger :=
        oQry_Fnd.FieldByName('den_fact_s').AsInteger;
      otOperacion.FieldByName('den_valore').AsSingle :=
        oQry_Fnd.FieldByName('den_valore').AsSingle;
      otOperacion.FieldByName('den_valors').AsSingle :=
        oQry_Fnd.FieldByName('den_valors').AsSingle;
    end;
  end;
end;

procedure TfCaptura2.Label15DblClick(Sender: TObject);
begin
  if ((otOperacion.State = dsInsert) or (otOperacion.State = dsEdit)) then
  begin
    Application.CreateForm(TfDenom, fDenom);
    fDenom.showmodal;
    fDenom.free;
    if oQry_Fnd.State <> dsInactive then
    begin
      oQry_Fnd.Refresh;
      otOperacion.FieldByName('den_fact_e').AsInteger :=
        oQry_Fnd.FieldByName('den_fact_e').AsInteger;
      otOperacion.FieldByName('den_fact_s').AsInteger :=
        oQry_Fnd.FieldByName('den_fact_s').AsInteger;
      otOperacion.FieldByName('den_valore').AsSingle :=
        oQry_Fnd.FieldByName('den_valore').AsSingle;
      otOperacion.FieldByName('den_valors').AsSingle :=
        oQry_Fnd.FieldByName('den_valors').AsSingle;
    end;
  end;
end;

procedure TfCaptura2.Label1DblClick(Sender: TObject);
var
  bTmp: boolean;
begin
  bTmp := bChangeMeters;
  Application.CreateForm(TfEmpresa, fEmpresa);
  fEmpresa.showmodal;
  fEmpresa.free;
  otEmpresa.Refresh;
  bChangeMeters := false;
  self.oMaquinaExit(self);
  bChangeMeters := bTmp;
end;

procedure TfCaptura2.Label21DblClick(Sender: TObject);
begin
  if ((otOperacion.State = dsInsert) or (otOperacion.State = dsEdit)) then
  begin
    Application.CreateForm(TfDenom, fDenom);
    fDenom.showmodal;
    fDenom.free;
    if oQry_Fnd.State <> dsInactive then
    begin
      oQry_Fnd.Refresh;
      otOperacion.FieldByName('den_fact_e').AsInteger :=
        oQry_Fnd.FieldByName('den_fact_e').AsInteger;
      otOperacion.FieldByName('den_fact_s').AsInteger :=
        oQry_Fnd.FieldByName('den_fact_s').AsInteger;
      otOperacion.FieldByName('den_valore').AsSingle :=
        oQry_Fnd.FieldByName('den_valore').AsSingle;
      otOperacion.FieldByName('den_valors').AsSingle :=
        oQry_Fnd.FieldByName('den_valors').AsSingle;
    end;
  end;
end;

procedure TfCaptura2.Label22DblClick(Sender: TObject);
begin
  if ((otOperacion.State = dsInsert) or (otOperacion.State = dsEdit)) then
  begin
    Application.CreateForm(TfDenom, fDenom);
    fDenom.showmodal;
    fDenom.free;
    if oQry_Fnd.State <> dsInactive then
    begin
      oQry_Fnd.Refresh;
      otOperacion.FieldByName('den_fact_e').AsInteger :=
        oQry_Fnd.FieldByName('den_fact_e').AsInteger;
      otOperacion.FieldByName('den_fact_s').AsInteger :=
        oQry_Fnd.FieldByName('den_fact_s').AsInteger;
      otOperacion.FieldByName('den_valore').AsSingle :=
        oQry_Fnd.FieldByName('den_valore').AsSingle;
      otOperacion.FieldByName('den_valors').AsSingle :=
        oQry_Fnd.FieldByName('den_valors').AsSingle;
    end;
  end;
end;

procedure TfCaptura2.Label2DblClick(Sender: TObject);
var
  bTmp: boolean;
begin
  bTmp := bChangeMeters;
  Application.CreateForm(TfClientes, fClientes);
  fClientes.showmodal;
  fClientes.free;
  otClientes.Refresh;
  bChangeMeters := false;
  self.oMaquinaExit(self);
  bChangeMeters := bTmp;
end;

procedure TfCaptura2.Label3DblClick(Sender: TObject);
var
  bTmp: boolean;
begin
  bTmp := bChangeMeters;
  Application.CreateForm(TfMunicipios, fMunicipios);
  fMunicipios.showmodal;
  fMunicipios.free;
  otMunicipios.Refresh;
  bChangeMeters := false;
  self.oMaquinaExit(self);
  bChangeMeters := bTmp;
end;

procedure TfCaptura2.Label51DblClick(Sender: TObject);
var
  bTmp: boolean;
begin
  bTmp := bChangeMeters;
  Application.CreateForm(TfRutas, fRutas);
  fRutas.showmodal;
  fRutas.free;
  otRutas.Refresh;
  bChangeMeters := false;
  self.oMaquinaExit(self);
  bChangeMeters := bTmp;
end;

procedure TfCaptura2.Label5DblClick(Sender: TObject);
var
  bTmp: boolean;
begin
  bTmp := bChangeMeters;
  Application.CreateForm(TfMaquinasTC, fMaquinasTC);
  fMaquinasTC.showmodal;
  fMaquinasTC.free;
  bChangeMeters := false;
  self.oMaquinaExit(self);
  bChangeMeters := bTmp;
end;

procedure TfCaptura2.oBtnAbortClick(Sender: TObject);
begin
  if (otOperacion.State = dsBrowse) then
  begin
    self.oDoc_Fnd.Text := '';
    self.oDoc_Fnd.visible := false;
    self.oDocumento.visible := true;
  end
  else
    self.otOperacion.Cancel;

  self.DBNavigator1.visible := true;
  self.Enabled_Screen(false);
  self.Action_Control(7);
end;

procedure TfCaptura2.oBtnDeleteClick(Sender: TObject);
var
  nResp: integer;
begin
  self.DBNavigator1.visible := false;
  self.Action_Control(3);
  nResp := Application.MessageBox('Seguro desea borrar?', '', MB_YESNO);
  If (nResp = ID_YES) Then
  begin
    self.otOperacion.Delete;
    self.otOperacion.Refresh;
  end;
  self.DBNavigator1.visible := true;
end;

procedure TfCaptura2.oBtnEditClick(Sender: TObject);
begin
  self.otOperacion.Edit;
  bChangeMeters := false;
  self.oMaquinaExit(self);
  self.DBNavigator1.visible := false;
  self.Enabled_Screen(true);
  self.Action_Control(2);
  self.oMaquina.Enabled := false;
  self.oDocumento.Enabled := false;
  self.oFecha.SetFocus;
end;

procedure TfCaptura2.oBtnExitClick(Sender: TObject);
begin
  self.close;
end;

procedure TfCaptura2.oBtnFindClick(Sender: TObject);
begin
  self.DBNavigator1.visible := false;
  self.Action_Control(4);
  oDoc_Fnd.top := oDocumento.top;
  oDoc_Fnd.left := oDocumento.left;
  oDoc_Fnd.visible := true;
  self.oDocumento.visible := false;
  self.oDoc_Fnd.SetFocus;
end;

procedure TfCaptura2.oBtnNewClick(Sender: TObject);
begin
  self.otOperacion.Insert;
  bChangeMeters := true;
  self.oMaquinaExit(self);
  self.DBNavigator1.visible := false;
  self.Enabled_Screen(true);
  self.oFecha.Value := now();
  self.Clear_Screen();
  self.Action_Control(1);
  self.cbb1.ItemIndex := 0;
  self.oFecha.SetFocus;
end;

procedure TfCaptura2.oBtnSaveClick(Sender: TObject);
begin
  if fUtilesV20.isEmpty(oMaquina.Text) then
  begin
    if ((otOperacion.State = dsInsert) or (otOperacion.State = dsInsert)) then
    begin
      Application.MessageBox('El número de máquina no puede estar vacío',
        'Búsqueda de Documento', 0);
      if oMaquina.Enabled = true then
        self.oMaquina.SetFocus;
      exit;
    end;
  end;
  self.otOperacion.post;
  self.DBNavigator1.visible := true;
  self.Enabled_Screen(false);
  self.Action_Control(6);
end;

procedure TfCaptura2.otOperacionBeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('MaqLnk_Id').Value := oQry_Fnd.FieldByName('MaqLnk_Id')
    .AsInteger;
  // DataSet.FieldByName('cte_id').Value := oQry_Fnd.FieldByName('cte_id').AsInteger;
  if DataSet.State = dsEdit then
  begin
    DataSet.FieldByName('u_usuario_modif').AsString := utilesV20.sUserName;
    DataSet.FieldByName('op_fecha_modif').Value := now();
  end
  else if DataSet.State = dsInsert then
  begin
    DataSet.FieldByName('u_usuario_alta').AsString := utilesV20.sUserName;
    DataSet.FieldByName('op_fecha_alta').Value := now();
  end;
end;

function TfCaptura2.Find_In_Op(Nodoc: string): boolean;
var
  oSqlLine: TstringList;
begin
  oSqlLine := TstringList.Create;
  oSqlLine.Clear;
  oSqlLine.Add('SELECT id_op ');
  oSqlLine.Add('FROM operacion ');
  oSqlLine.Add('WHERE op_nodoc=' + QuotedStr(Nodoc));
  self.oQry_Fnd.close;
  result := utilesV20.Exec_Select_SQL(self.oQry_Fnd, oSqlLine.Text, true, true);
  freeandnil(oSqlLine);
  self.oQry_Fnd.close;
end;

procedure TfCaptura2.oDocumentoClick(Sender: TObject);
begin
  self.oDocumento.SelectAll;
end;

procedure TfCaptura2.oDocumentoExit(Sender: TObject);
begin
  if fUtilesV20.isEmpty(self.oDocumento.Text) then
    exit;
  self.oDocumento.Text := fUtilesV20.PadL(trim(self.oDocumento.Text), 8, '0');
  if StrToInt(self.oDocumento.Text) = 0 then
  begin
    self.otOperacion.FieldByName('op_nodoc').AsString := '';
    self.oDocumento.Text := '';
    exit;
  end;
  if (otOperacion.State = dsInsert) then
  begin
    if Find_In_Op(self.oDocumento.Text) = true then
    begin
      Application.MessageBox('Número de documento ya existe',
        'Búsqueda de Documento', 0);
      self.otOperacion.FieldByName('op_nodoc').AsString := '';
      self.oDocumento.Text := '';
      self.oDocumento.SetFocus;
      exit;
    end
    else
      self.oMaquinaExit(self);
  end;

end;

procedure TfCaptura2.oDoc_FndExit(Sender: TObject);
begin
  if (otOperacion.State = dsBrowse) then
  begin
    if fUtilesV20.isEmpty(self.oDoc_Fnd.Text) then
      exit;
    self.oDoc_Fnd.Text := fUtilesV20.PadL(trim(self.oDoc_Fnd.Text), 8, '0');
    if otOperacion.Locate('op_nodoc', trim(oDoc_Fnd.Text),
      [loPartialKey, loCaseInsensitive]) = false then
      Application.MessageBox('Número de documento no existe',
        'Búsqueda de Documento', 0)
    else
      self.oMaquinaExit(self);
    self.oDoc_Fnd.Text := '';
    self.oDoc_Fnd.visible := false;
    self.oDocumento.visible := true;
  end;
end;

procedure TfCaptura2.oDoc_FndKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
  Begin
    If HiWord(GetKeyState(VK_SHIFT)) <> 0 then
      SelectNext(Sender as TWinControl, false, true)
    else
      SelectNext(Sender as TWinControl, true, true);
    Key := #0;
  end;
end;

procedure TfCaptura2.oMaquinaClick(Sender: TObject);
begin
  self.oMaquina.SelectAll;
end;

procedure TfCaptura2.oMaquinaExit(Sender: TObject);
begin
  if fUtilesV20.isEmpty(oMaquina.Text) then
    exit;
  bFoundMach := self.Buscar_Maquina(oQry_Fnd, trim(oMaquina.Text));
  if (bFoundMach = false) then
  begin
    self.otOperacion.FieldByName('op_chapa').AsString := '';
    self.oMaquina.Text := '';
    if oMaquina.Enabled = true then
      self.oMaquina.SetFocus;
    exit;
  end;

  self.oLst_Empresa.KeyValue := oQry_Fnd.FieldByName('emp_id').AsInteger;
  self.oLst_Clientes.KeyValue := oQry_Fnd.FieldByName('cte_id').AsInteger;
  self.oLst_Municipios.KeyValue := oQry_Fnd.FieldByName('mun_id').AsInteger;
  self.oLst_Rutas.KeyValue := oQry_Fnd.FieldByName('rut_id').AsInteger;

  if ((otOperacion.State = dsInsert) or (otOperacion.State = dsEdit)) then
  begin

    if bFoundMach = false then
      exit;
    MyOp.Denom_Ent_Fac := oQry_Fnd.FieldByName('den_fact_e').AsInteger;
    MyOp.Denom_Sal_Fac := oQry_Fnd.FieldByName('den_fact_s').AsInteger;
    MyOp.Denom_Ent_Val := oQry_Fnd.FieldByName('den_valore').AsSingle;
    MyOp.Denom_Sal_Val := oQry_Fnd.FieldByName('den_valors').AsSingle;
    MyOp.Porc_Loc := fUtilesV20.iif(oQry_Fnd.FieldByName('cte_poc_ret')
      .AsSingle = 0, 1, oQry_Fnd.FieldByName('cte_poc_ret').AsSingle);

    self.olBruto_Cte.Hint := 'Porcentaje Cliente [' + FormatFloat('##,##0.00',
      oQry_Fnd.FieldByName('cte_poc_ret').AsSingle) + '%]';
    self.olBruto_Cte.ShowHint := true;
    self.olNeto_Cte.Hint := 'Porcentaje Cliente [' + FormatFloat('##,##0.00',
      oQry_Fnd.FieldByName('cte_poc_ret').AsSingle) + '%]';
    self.olNeto_Cte.ShowHint := true;
    self.olTot_Colectado.Hint := 'Factor de Conversión [' +
      IntToStr(MyOp.Denom_Ent_Fac) + '/ $' + FormatFloat('##,##0.00',
      MyOp.Denom_Ent_Val) + ']';
    self.olTot_Colectado.ShowHint := true;

    otOperacion.FieldByName('op_modelo').AsString :=
      oQry_Fnd.FieldByName('maqtc_modelo').AsString;
    otOperacion.FieldByName('cte_nombre_loc').AsString :=
      oQry_Fnd.FieldByName('cte_nombre_loc').AsString;
    otOperacion.FieldByName('cte_nombre_com').AsString :=
      oQry_Fnd.FieldByName('cte_nombre_com').AsString;
    otOperacion.FieldByName('cte_pag_jcj').AsInteger :=
      oQry_Fnd.FieldByName('cte_pag_jcj').AsInteger;
    otOperacion.FieldByName('cte_pag_spac').AsInteger :=
      oQry_Fnd.FieldByName('cte_pag_spac').AsInteger;
    otOperacion.FieldByName('cte_pag_impm').AsInteger :=
      oQry_Fnd.FieldByName('cte_pag_impm').AsInteger;
    otOperacion.FieldByName('op_cporc_Loc').AsInteger :=
      oQry_Fnd.FieldByName('cte_poc_ret').AsInteger;
    otOperacion.FieldByName('maqtc_denom_e').AsInteger :=
      oQry_Fnd.FieldByName('maqtc_denom_e').AsInteger;
    otOperacion.FieldByName('maqtc_denom_s').AsInteger :=
      oQry_Fnd.FieldByName('maqtc_denom_s').AsInteger;
    otOperacion.FieldByName('maqtc_tipomaq').AsInteger :=
      oQry_Fnd.FieldByName('maqtc_tipomaq').AsInteger;
    otOperacion.FieldByName('den_fact_e').AsInteger :=
      oQry_Fnd.FieldByName('den_fact_e').AsInteger;
    otOperacion.FieldByName('den_fact_s').AsInteger :=
      oQry_Fnd.FieldByName('den_fact_s').AsInteger;
    otOperacion.FieldByName('den_valore').AsSingle :=
      oQry_Fnd.FieldByName('den_valore').AsSingle;
    otOperacion.FieldByName('den_valors').AsSingle :=
      oQry_Fnd.FieldByName('den_valors').AsSingle;
    if (self.otOperacion.State = dsInsert) then
    begin
      if oQry_Fnd.FieldByName('cte_pag_jcj').AsInteger = 0 then
        otOperacion.FieldByName('Op_tot_impjcj').AsSingle :=
          (oQry_Fnd.FieldByName('emp_cargo_jcj').AsSingle / 4);

      if oQry_Fnd.FieldByName('cte_pag_impm').AsInteger = 0 then
        otOperacion.FieldByName('Op_tot_impmunic').AsSingle :=
          oQry_Fnd.FieldByName('mun_impuesto').AsSingle;
    end;
  end;
  if bChangeMeters = false then
    exit;

  Case oQry_Fnd.FieldByName('maqtc_metros').AsInteger of
    1:
      begin
        if self.otOperacion.State = dsInsert then
        begin
          // Entradas A
          self.otOp_ea_metroac.visible := true; { Actual }
          self.otOp_ea_metroan.visible := true; { Anterior }
          otOperacion.FieldByName('Op_ea_metroac').AsInteger := 0;
          otOperacion.FieldByName('Op_ea_metroan').AsInteger :=
            oQry_Fnd.FieldByName('maqtc_m1e_act').AsInteger;
          // Salidas A
          otOperacion.FieldByName('Op_sa_metroac').AsInteger := 0;
          otOperacion.FieldByName('Op_sa_metroan').AsInteger := 0;

          if oQry_Fnd.FieldByName('maqtc_m1e_aNT').AsInteger = 0 then
            self.otOp_ea_metroan.Enabled := true
          else
            self.otOp_ea_metroan.Enabled := false;
        end
        else
        begin
          // Entradas A
          self.otOp_ea_metroac.visible := true; { Actual }
          self.otOp_ea_metroan.visible := true; { Anterior }
          self.otOperacion.FieldByName('Op_ea_metroac').AsInteger :=
            oQry_Fnd.FieldByName('maqtc_m1e_act').AsInteger;
          otOperacion.FieldByName('Op_ea_metroan').AsInteger :=
            oQry_Fnd.FieldByName('maqtc_m1e_ant').AsInteger;
          // Salidas A
          otOperacion.FieldByName('Op_sa_metroac').AsInteger := 0;
          otOperacion.FieldByName('Op_sa_metroan').AsInteger := 0;
        end;
        // Entradas B
        self.otOp_eb_metroac.visible := false; { Actual }
        self.otOp_eb_metroan.visible := false; { Anterior }
        otOperacion.FieldByName('Op_eb_metroac').AsInteger := 0;
        otOperacion.FieldByName('Op_eb_metroan').AsInteger := 0;
        // Salidas B
        otOperacion.FieldByName('Op_sb_metroac').AsInteger := 0;
        otOperacion.FieldByName('Op_sb_metroan').AsInteger := 0;
      end;
    2:
      begin
        if self.otOperacion.State = dsInsert then
        begin
          // Entradas A
          self.otOp_ea_metroac.visible := true; { Actual }
          self.otOp_ea_metroan.visible := true; { Anterior }
          self.otOperacion.FieldByName('Op_ea_metroac').AsInteger := 0
          { &&maquinas.m1e_act };
          self.otOperacion.FieldByName('Op_ea_metroan').AsInteger :=
            oQry_Fnd.FieldByName('maqtc_m1e_act').AsInteger;
          // Salidas A
          self.otOperacion.FieldByName('Op_sa_metroac').AsInteger := 0;
          { maquinas.m1s_act }
          self.otOperacion.FieldByName('Op_sa_metroan').AsInteger :=
            oQry_Fnd.FieldByName('maqtc_m1s_act').AsInteger;
          if oQry_Fnd.FieldByName('maqtc_m1e_ant').AsInteger = 0 then
            self.otOp_ea_metroan.Enabled := true
          else
            self.otOp_ea_metroan.Enabled := false;
          // --------------------------------------------------------
          // Entradas B
          self.otOp_eb_metroac.visible := true; { Actual }
          self.otOp_eb_metroan.visible := true; { Anterior }
          otOperacion.FieldByName('Op_eb_metroac').AsInteger := 0;
          otOperacion.FieldByName('Op_eb_metroan').AsInteger :=
            oQry_Fnd.FieldByName('maqtc_m2e_act').AsInteger;
          // Salidas B

          otOperacion.FieldByName('Op_sb_metroac').AsInteger := 0;
          otOperacion.FieldByName('Op_sb_metroan').AsInteger := 0;
          if oQry_Fnd.FieldByName('maqtc_m2e_ant').AsInteger = 0 then
            self.otOp_eb_metroan.Enabled := true
          else
            self.otOp_eb_metroan.Enabled := false;
        end
        else
        begin
          // Entradas A
          self.otOp_ea_metroac.visible := true; { Actual }
          self.otOp_ea_metroan.visible := true; { Anterior }
          // Salidas A
          // --------------------------------------------------------
          // Entradas B
          self.otOp_eb_metroac.visible := false; { Actual }
          self.otOp_eb_metroan.visible := false; { Anterior }
          // Salidas B
        end;
      end;
  else
    ShowMessage
      ('A las máquinas no se le han sido asiganado la información de metros, favor asignar la información de metros');
    // Entradas A
    self.otOp_ea_metroac.visible := true; { Actual }
    self.otOp_ea_metroan.visible := true; { Anterior }
    // Salidas A
    // --------------------------------------------------------
    // Entradas B
    self.otOp_eb_metroac.visible := false; { Actual }
    self.otOp_eb_metroan.visible := false; { Anterior }
    // Salidas B
  End;
end;

procedure TfCaptura2.oMoneyADblClick(Sender: TObject);
begin
  if (trim(otOperacion.FieldByName('maqtc_denom_e').AsString) <> '1') then
  begin
    //self.otOp_ea_metroac.
  end;
end;

procedure TfCaptura2.oSemanaClick(Sender: TObject);
begin
  self.oSemana.SelectAll;
end;

procedure TfCaptura2.otOp_ea_metroanClick(Sender: TObject);
begin
  self.otOp_ea_metroan.SelectAll;
end;

procedure TfCaptura2.otOp_ea_metroanExit(Sender: TObject);
begin
  self.Calc_Dif_Ent(true);
  self.Calc_Tot(1);
end;

procedure TfCaptura2.otOp_eb_metroacClick(Sender: TObject);
begin
  self.otOp_eb_metroac.SelectAll;
end;

procedure TfCaptura2.otOp_eb_metroacExit(Sender: TObject);
begin
  self.Calc_Dif_Ent(false);
  self.Calc_Tot(1);
end;

procedure TfCaptura2.otOp_eb_metroanClick(Sender: TObject);
begin
  self.otOp_eb_metroan.SelectAll;
end;

procedure TfCaptura2.otOp_eb_metroanExit(Sender: TObject);
begin
  self.Calc_Dif_Ent(false);
  self.Calc_Tot(1);
end;

procedure TfCaptura2.otop_e_pantallaClick(Sender: TObject);
begin
  self.otop_e_pantalla.SelectAll;
end;

procedure TfCaptura2.otop_e_pantallaExit(Sender: TObject);
begin
  self.Calc_Dif_Ent(false);
  self.Calc_Tot(1);
end;

procedure TfCaptura2.otOp_tot_brutoempClick(Sender: TObject);
begin
  self.otOp_tot_brutoemp.SelectAll;
end;

procedure TfCaptura2.otOp_tot_brutolocClick(Sender: TObject);
begin
  self.otOp_tot_brutoloc.SelectAll;
end;

procedure TfCaptura2.otOp_tot_colectClick(Sender: TObject);
begin
  self.otOp_tot_colect.SelectAll;
end;

procedure TfCaptura2.otOp_tot_colectExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura2.otOp_tot_credExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura2.otOp_tot_devClick(Sender: TObject);
begin
  self.otOp_tot_dev.SelectAll;
end;

procedure TfCaptura2.otOp_tot_devExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura2.otOp_tot_AudicClick(Sender: TObject);
begin
  self.otOp_tot_Audic.SelectAll;
end;

procedure TfCaptura2.otOp_tot_AudicExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura2.otOp_tot_impmunicClick(Sender: TObject);
begin
  self.otOp_tot_impmunic.SelectAll;
end;

procedure TfCaptura2.otOp_tot_impmunicExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura2.otOp_tot_itbmClick(Sender: TObject);
begin
  self.otOp_tot_itbm.SelectAll;
end;

procedure TfCaptura2.otOp_tot_netoempClick(Sender: TObject);
begin
  self.otOp_tot_netoemp.SelectAll;
end;

procedure TfCaptura2.otOp_tot_netolocClick(Sender: TObject);
begin
  self.otOp_tot_netoloc.SelectAll;
end;

procedure TfCaptura2.otOp_tot_otrosClick(Sender: TObject);
begin
  self.otOp_tot_otros.SelectAll;
end;

procedure TfCaptura2.otOp_tot_otrosExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura2.otOp_tot_spacClick(Sender: TObject);
begin
  self.otOp_tot_spac.SelectAll;
end;

procedure TfCaptura2.otOp_tot_spacExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura2.otOp_tot_subClick(Sender: TObject);
begin
  self.otOp_tot_sub.SelectAll;
end;

procedure TfCaptura2.Action_Control(pOption: integer);
begin
  if ((pOption = 1) or (pOption = 2)) then
  begin
    oBtnNew.visible := false;
    oBtnEdit.visible := false;
    oBtnDelete.visible := false;
    oBtnFind.visible := false;
    oBtnExit.Enabled := false;
    // --------------------------------------------------
    oBtnSave.top := oBtnNew.top;
    oBtnSave.left := oBtnNew.left;
    // --------------------------------------------------
    oBtnAbort.top := oBtnEdit.top;
    oBtnAbort.left := oBtnEdit.left;
    // --------------------------------------------------
    oBtnAbort.visible := true;
    oBtnSave.visible := true;
    oBtnExit.visible := false;
  end;
  if (pOption = 4) then
  begin
    oBtnNew.visible := false;
    oBtnEdit.visible := false;
    oBtnDelete.visible := false;
    oBtnFind.visible := false;
    oBtnExit.Enabled := false;
    // --------------------------------------------------
    oBtnSave.top := oBtnNew.top;
    oBtnSave.left := oBtnNew.left;
    // --------------------------------------------------
    oBtnAbort.top := oBtnEdit.top;
    oBtnAbort.left := oBtnEdit.left;
    // --------------------------------------------------
    oBtnAbort.visible := true;
    oBtnSave.visible := true;
    oBtnSave.Enabled := false;
    oBtnExit.visible := false;
  end;

  if ((pOption = 6) or (pOption = 7)) then
  begin
    oBtnNew.visible := true;
    oBtnEdit.visible := true;
    oBtnDelete.visible := true;
    oBtnFind.visible := true;
    oBtnExit.Enabled := true;
    oBtnSave.top := oBtnNew.top;
    oBtnSave.left := oBtnNew.left;
    // --------------------------------------------------
    oBtnAbort.top := oBtnEdit.top;
    oBtnAbort.left := oBtnEdit.left;
    // --------------------------------------------------
    oBtnAbort.visible := false;
    oBtnSave.visible := false;
    oBtnExit.visible := true;
  end;
end;

function TfCaptura2.Buscar_Maquina(var oQry_Fnd: TFDQuery;
  pNum_Maq: string): boolean;
var
  sSql: string;
begin

  self.oSql_Text.Clear;
  sSql := '';
  sSql := sSql + 'SELECT ';
  sSql := sSql + '  maquinastc.maqtc_id, ';
  sSql := sSql + '  maquinastc.maqtc_cod, ';
  sSql := sSql + '  maquinastc.maqtc_modelo, ';
  sSql := sSql + '  maquinastc.maqtc_chapa, ';
  sSql := sSql + '  maquinastc.maqtc_activo, ';
  sSql := sSql + '  maquinastc.maqtc_metros, ';
  sSql := sSql + '  maquinastc.maqtc_denom_e, ';
  sSql := sSql + '  maquinastc.maqtc_tipomaq, ';
  sSql := sSql + '  maquinastc.maqtc_denom_s, ';
  sSql := sSql + '  maquinastc.maqtc_m1e_act, ';
  sSql := sSql + '  maquinastc.maqtc_m1e_ant, ';
  sSql := sSql + '  maquinastc.maqtc_m1s_ant, ';
  sSql := sSql + '  maquinastc.maqtc_m2e_act, ';
  sSql := sSql + '  maquinastc.maqtc_m2e_ant, ';
  sSql := sSql + '  maquinastc.maqtc_m2s_act, ';
  sSql := sSql + '  maquinastc.maqtc_m2s_ant, ';
  sSql := sSql + '  maquinastc.maqtc_m1s_act, ';
  sSql := sSql + '  maquinas_lnk.MaqLnk_Id, ';
  sSql := sSql + '  clientes.cte_id, ';
  sSql := sSql + '  clientes.cte_nombre_loc, ';
  sSql := sSql + '  clientes.cte_nombre_com, ';
  sSql := sSql + '  clientes.cte_activo, ';
  sSql := sSql + '  clientes.cte_pag_jcj, ';
  sSql := sSql + '  clientes.cte_pag_impm, ';
  sSql := sSql + '  clientes.cte_pag_spac, ';
  sSql := sSql + '  clientes.cte_poc_ret, ';
  sSql := sSql + '  clientes.mun_id, ';
  sSql := sSql + '  clientes.rut_id, ';
  sSql := sSql + '  rutas.rut_nombre, ';
  sSql := sSql + '  empresas.emp_id, ';
  sSql := sSql + '  empresas.emp_descripcion, ';
  sSql := sSql + '  empresas.emp_activo, ';
  sSql := sSql + '  empresas.emp_cargo_jcj, ';
  sSql := sSql + '  empresas.emp_cargo_spac, ';
  sSql := sSql + '  municipios.mun_nombre, ';
  sSql := sSql + '  municipios.mun_impuesto, ';
  sSql := sSql + '  a.den_valor AS den_valore , ';
  sSql := sSql + '  b.den_valor AS den_valors , ';
  sSql := sSql + '  a.den_fact_e , ';
  sSql := sSql + '  b.den_fact_s  ';
  sSql := sSql + 'FROM maquinastc ';
  sSql := sSql +
    '  INNER JOIN maquinas_lnk ON (maquinastc.maqtc_id = maquinas_lnk.maqtc_id) ';
  sSql := sSql +
    '  LEFT JOIN clientes  ON (maquinas_lnk.cte_id = clientes.cte_id) ';
  sSql := sSql +
    '  LEFT JOIN empresas   ON (maquinas_lnk.emp_id = empresas.emp_id) ';
  sSql := sSql +
    '  LEFT JOIN municipios ON (clientes.mun_id = municipios.mun_id) ';
  sSql := sSql + '  LEFT JOIN rutas      ON (clientes.rut_id = rutas.rut_id) ';
  sSql := sSql +
    '  LEFT JOIN denominaciones a ON (maquinastc.maqtc_denom_e = a.den_id) ';
  sSql := sSql +
    '  LEFT JOIN denominaciones b ON (maquinastc.maqtc_denom_s = b.den_id) ';
  sSql := sSql + 'WHERE  maqtc_tipomaq = 2 ';
  sSql := sSql + '  AND TRIM(maquinastc.maqtc_chapa) = ' +
    QuotedStr(trim(pNum_Maq)) + ' ';
  sSql := sSql + '  AND empresas.emp_id = ' +
    QuotedStr(IntToStr(utilesV20.iId_Empresa));
  oQry_Fnd.close;
  result := utilesV20.Exec_Select_SQL(oQry_Fnd, sSql, true, true);
  if result = false then
  begin
    Application.MessageBox
      ('el código de máquina no existe o no tiene un cliente asignado',
      'Precausión');
    exit;
  end;
end;

procedure TfCaptura2.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
  begin
    with otOperacion do
    begin
      FieldByName('op_observ').AsString := 'Baja Producción';
      FieldByName('op_EA_MetroAn').AsSingle := 0;
      FieldByName('op_eA_MetroAc').AsSingle := 0;
      FieldByName('op_EB_MetroAc').AsSingle := 0;
      FieldByName('op_EB_MetroAn').AsSingle := 0;
      FieldByName('op_SA_MetroAc').AsSingle := 0;
      FieldByName('op_SA_MetroAn').AsSingle := 0;
      FieldByName('op_SB_MetroAc').AsSingle := 0;
      FieldByName('op_SB_MetroAn').AsSingle := 0;
      FieldByName('op_tot_impjcj').AsSingle := 0;
      FieldByName('op_tot_impmunic').AsSingle := 0;
      self.Calc_Tot(0);
      self.Calc_Sub_Tot;
    end;
  end;
end;

procedure TfCaptura2.Calc_Tot(iForce: integer);
var
  iTot: single;
  ipFac_e: single;
begin
  ipFac_e := fUtilesV20.iif(MyOp.Denom_Ent_Fac = 0, 1, MyOp.Denom_Ent_Fac);
  iTot := (MyOp.MetroA_EntDif + MyOp.MetroB_EntDif) / ipFac_e;
  MyOp.Suma_Efec := iTot;
  if (iForce = 1) then
  begin
    self.otOp_tot_colect.Value := iTot;
    self.Calc_Sub_Tot;
  end
  else
  begin
    if self.otOp_tot_colect.Value <= 0 then
    begin
      self.otOp_tot_colect.Value := iTot;
      self.Calc_Sub_Tot;
    end;
  end;
  self.otOperacion.FieldByName('op_cal_colect').AsFloat := iTot;
end;

procedure TfCaptura2.Calc_Sub_Tot;
var
  ipK_porc: single;
  iTot1: single;
  iTot2: single;
begin
  ipK_porc := fUtilesV20.iif(MyOp.Porc_Loc = 0, 1, MyOp.Porc_Loc);
  iTot1 := (self.otOp_tot_Audic.Value + self.otOp_tot_impmunic.Value +
    self.otOp_tot_spac.Value + self.otOp_tot_fono.Value +
    self.otOp_tot_tec.Value);
  iTot2 := (self.otOp_tot_dev.Value - self.otOp_tot_otros.Value);
  self.otOp_tot_sub.Value := (self.otOp_tot_colect.Value - iTot1 - iTot2);

  self.otOp_tot_itbm.Value := (self.otOp_tot_sub.Value * (MyOp.iItbms / 100));
  self.otOp_tot_tot.Value :=
    (self.otOp_tot_sub.Value - self.otOp_tot_itbm.Value);
  if ipK_porc = 100 then
  begin
    self.otOp_tot_brutoloc.Value := 0;
    self.otOp_tot_brutoemp.Value := self.otOp_tot_tot.Value;
  end
  else
  begin
    self.otOp_tot_brutoloc.Value :=
      (self.otOp_tot_tot.Value * (ipK_porc / 100));
    self.otOp_tot_brutoemp.Value :=
      (self.otOp_tot_tot.Value - self.otOp_tot_brutoloc.Value);
  end;
  self.otOp_tot_netoloc.Value :=
    (self.otOp_tot_dev.Value - self.otOp_tot_otros.Value +
    self.otOp_tot_brutoloc.Value);
  self.otOp_tot_netoemp.Value :=
    (self.otOp_tot_Audic.Value + self.otOp_tot_impmunic.Value +
    +self.otOp_tot_spac.Value + self.otOp_tot_fono.Value -
    self.otOp_tot_tec.Value + self.otOp_tot_brutoemp.Value);
  self.Refresh;
end;

procedure TfCaptura2.otOp_tot_tecClick(Sender: TObject);
begin
  self.otOp_tot_tec.SelectAll;
end;

procedure TfCaptura2.otOp_tot_tecExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura2.otOp_tot_fonoClick(Sender: TObject);
begin
  self.otOp_tot_fono.SelectAll;
end;

procedure TfCaptura2.otOp_tot_fonoExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura2.otOp_tot_totClick(Sender: TObject);
begin
  self.otOp_tot_tot.SelectAll;
end;

procedure TfCaptura2.Clear_Screen;
var
  j: integer;
begin
  for j := 0 to ComponentCount - 1 do
  begin
    if (Components[j] is TDBNumberEditEh) then
    begin
      (Components[j] as TDBNumberEditEh).Value := 0;
    end;
    if (Components[j] is TDBMemo) then
    begin
      (Components[j] as TDBMemo).Text := '';
    end;
    if (Components[j] is TDBEdit) then
    begin
      (Components[j] as TDBEdit).Text := '';
    end;
    if (Components[j] is TDBDateTimeEditEh) then
    begin
      (Components[j] as TDBDateTimeEditEh).Value := now();
    end;
  end;
end;

procedure TfCaptura2.Enabled_Screen(bFlag: boolean);
var
  j: integer;
begin
  for j := 0 to ComponentCount - 1 do
  begin
    if (Components[j] is TCheckBox) then
    begin
      if (Components[j] as TCheckBox).TAG <> 1 then
        (Components[j] as TCheckBox).Enabled := bFlag;
    end;
    if (Components[j] is TDBCheckBox) then
    begin
      if (Components[j] as TDBCheckBox).TAG <> 1 then
        (Components[j] as TDBCheckBox).Enabled := bFlag;
    end;
    if (Components[j] is TDBMemo) then
    begin
      if (Components[j] as TDBMemo).TAG <> 1 then
        (Components[j] as TDBMemo).Enabled := bFlag;
    end;
    if (Components[j] is TDBEdit) then
    begin
      if (Components[j] as TDBEdit).TAG <> 1 then
        (Components[j] as TDBEdit).Enabled := bFlag;
    end;
    if (Components[j] is TDBDateTimeEditEh) then
    begin
      if (Components[j] as TDBDateTimeEditEh).TAG <> 1 then
        (Components[j] as TDBDateTimeEditEh).Enabled := bFlag;
    end;
    if (Components[j] is TDBNumberEditEh) then
    begin
      if (Components[j] as TDBNumberEditEh).TAG <> 1 then
        (Components[j] as TDBNumberEditEh).Enabled := bFlag;
    end;
    if (Components[j] is TDBLookupComboboxEh) then
    begin
      if (Components[j] as TDBLookupComboboxEh).TAG <> 1 then
        (Components[j] as TDBLookupComboboxEh).Enabled := bFlag;
    end;
    if (Components[j] is TDBComboBoxEh) then
    begin
      if (Components[j] as TDBComboBoxEh).TAG <> 1 then
        (Components[j] as TDBComboBoxEh).Enabled := bFlag;
    end;
  end;
  // self.DBNavigator1.visible := false;
end;

procedure TfCaptura2.AssgnTabs;
var
  j: integer;
begin
  for j := 0 to ComponentCount - 1 do
  begin
    if (Components[j] is TCheckBox) then
      (Components[j] as TCheckBox).OnKeyPress := self.EnterAsTab;
    if (Components[j] is TDBCheckBox) then
      (Components[j] as TDBCheckBox).OnKeyPress := self.EnterAsTab;
    if (Components[j] is TDBMemo) then
      (Components[j] as TDBMemo).OnKeyPress := self.EnterAsTab;
    if (Components[j] is TDBEdit) then
      (Components[j] as TDBEdit).OnKeyPress := self.EnterAsTab;
    if (Components[j] is TDBDateTimeEditEh) then
      (Components[j] as TDBDateTimeEditEh).OnKeyPress := self.EnterAsTab;
    if (Components[j] is TDBNumberEditEh) then
      (Components[j] as TDBNumberEditEh).OnKeyPress := self.EnterAsTab;
    if (Components[j] is TDBLookupComboboxEh) then
      (Components[j] as TDBLookupComboboxEh).OnKeyPress := self.EnterAsTab;
    if (Components[j] is TDBComboBoxEh) then
      (Components[j] as TDBComboBoxEh).OnKeyPress := self.EnterAsTab;
  end;
end;

procedure TfCaptura2.EnterAsTab(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
  Begin
    If HiWord(GetKeyState(VK_SHIFT)) <> 0 then
      SelectNext(Sender as TWinControl, false, true)
    else
      SelectNext(Sender as TWinControl, true, true);
    Key := #0;
  end;
end;

procedure TfCaptura2.Calc_Dif_Ent(A: boolean);
begin
  if A = true then
    MyOp.MetroA_EntDif :=
      (self.otOp_ea_metroac.Value - self.otOp_ea_metroan.Value)
  else
    MyOp.MetroB_EntDif :=
      (self.otOp_eb_metroac.Value - self.otOp_eb_metroan.Value);
end;

procedure TfCaptura2.otOp_ea_metroacClick(Sender: TObject);
begin
  self.otOp_ea_metroac.SelectAll;
end;

procedure TfCaptura2.otOp_ea_metroacExit(Sender: TObject);
begin
  self.Calc_Dif_Ent(true);
  self.Calc_Tot(1);
end;

end.
