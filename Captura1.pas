unit Captura1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, DateUtils,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Buttons,
  XPMan, PngBitBtn, DB,
  DBGridEh, DBLookupEh, Mask, DBCtrlsEh, DBCtrls, ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  System.inifiles,
  FireDAC.VCLUI.Wait;

type
  TfCaptura1 = class(TForm)
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
    GroupBox2: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    otOp_sa_metroac: TDBNumberEditEh;
    otOp_sa_metroan: TDBNumberEditEh;
    otOp_sb_metroac: TDBNumberEditEh;
    otOp_sb_metroan: TDBNumberEditEh;
    otOp_s_pantalla: TDBNumberEditEh;
    otOp_observ: TDBMemo;
    Label23: TLabel;
    Label24: TLabel;
    GroupBox3: TGroupBox;
    olTot_Colectado: TLabel;
    otOp_tot_colect: TDBNumberEditEh;
    olOp_tot_timbres: TLabel;
    otOp_tot_timbres: TDBNumberEditEh;
    olOp_tot_impmunic: TLabel;
    otOp_tot_impmunic: TDBNumberEditEh;
    olOp_tot_impjcj: TLabel;
    otOp_tot_impjcj: TDBNumberEditEh;
    olOp_tot_tec: TLabel;
    otOp_tot_tec: TDBNumberEditEh;
    olOp_tot_dev: TLabel;
    otOp_tot_dev: TDBNumberEditEh;
    olOp_tot_otros: TLabel;
    otOp_tot_otros: TDBNumberEditEh;
    olTot_Credito: TLabel;
    otOp_tot_cred: TDBNumberEditEh;
    olOp_tot_sub: TLabel;
    otOp_tot_sub: TDBNumberEditEh;
    olOp_tot_itbm: TLabel;
    otOp_tot_itbm: TDBNumberEditEh;
    olOp_tot_tot: TLabel;
    otOp_tot_tot: TDBNumberEditEh;
    olOp_tot_brutoemp: TLabel;
    otOp_tot_brutoemp: TDBNumberEditEh;
    olBruto_Cte: TLabel;
    otOp_tot_brutoloc: TDBNumberEditEh;
    otOp_tot_netoloc: TDBNumberEditEh;
    olNeto_Cte: TLabel;
    olOp_tot_netoemp: TLabel;
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
    Shape3: TShape;
    Shape4: TShape;
    oDoc_Fnd: TEdit;
    oDocumento: TDBEdit;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    oConection: TFDConnection;
    otEmpresa: TFDTable;
    otClientes: TFDTable;
    otMunicipios: TFDTable;
    otOperaciones: TFDTable;
    otRutas: TFDTable;
    oQry_Fnd: TFDQuery;
    oCk_Baja_Prod: TDBCheckBox;
    cbb1: TDBComboBoxEh;
    oQuery_Gen: TFDQuery;
    otOp_tot_colect2: TDBNumberEditEh;
    otOp_tot_cred2: TDBNumberEditEh;
    oCk_MetrosDl_S: TCheckBox;
    oCk_MetrosDl_E: TCheckBox;
    otop_tot_porc_cons: TDBNumberEditEh;
    Label26: TLabel;
    olTot_Conses: TLabel;
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
    procedure otOp_tot_impjcjExit(Sender: TObject);
    procedure otOp_tot_tecExit(Sender: TObject);
    procedure otOp_tot_devExit(Sender: TObject);
    procedure otOp_tot_otrosExit(Sender: TObject);
    procedure otOp_tot_credExit(Sender: TObject);
    procedure otOp_tot_timbresExit(Sender: TObject);
    procedure otOp_sa_metroacExit(Sender: TObject);
    procedure otOp_sb_metroacExit(Sender: TObject);
    procedure otOp_sa_metroanExit(Sender: TObject);
    procedure otOp_sb_metroanExit(Sender: TObject);
    procedure Tot_Cred(iForce: integer);
    procedure Clear_Screen;
    procedure Enabled_Screen(bFlag: boolean);
    procedure FormShow(Sender: TObject);
    procedure otOp_s_pantallaExit(Sender: TObject);
    procedure otop_e_pantallaExit(Sender: TObject);
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
    procedure Calc_Dif_Sal(A: boolean);
    procedure Calc_Dif_Ent(A: boolean);
    procedure otOp_ea_metroacExit(Sender: TObject);
    procedure AssgnTabs;
    procedure Label10Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure oDoc_FndKeyPress(Sender: TObject; var Key: Char);
    function Find_In_Op(Nodoc: string): boolean;
    procedure otOp_ea_metroacClick(Sender: TObject);
    procedure otOp_eb_metroacClick(Sender: TObject);
    procedure otOp_ea_metroanClick(Sender: TObject);
    procedure otOp_eb_metroanClick(Sender: TObject);
    procedure otop_e_pantallaClick(Sender: TObject);
    procedure otOp_sa_metroacClick(Sender: TObject);
    procedure otOp_sb_metroacClick(Sender: TObject);
    procedure otOp_sa_metroanClick(Sender: TObject);
    procedure otOp_sb_metroanClick(Sender: TObject);
    procedure otOp_s_pantallaClick(Sender: TObject);
    procedure otOp_tot_colectClick(Sender: TObject);
    procedure otOp_tot_timbresClick(Sender: TObject);
    procedure otOp_tot_impmunicClick(Sender: TObject);
    procedure otOp_tot_impjcjClick(Sender: TObject);
    procedure otOp_tot_tecClick(Sender: TObject);
    procedure otOp_tot_devClick(Sender: TObject);
    procedure otOp_tot_otrosClick(Sender: TObject);
    procedure otOp_tot_credClick(Sender: TObject);
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
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure otOperacionesBeforePost(DataSet: TDataSet);
    procedure oCk_Baja_ProdClick(Sender: TObject);
    procedure Mostrar_Baja_Prod;
    procedure mask_fields(bEsEntrada: boolean = false; bDecimals: boolean = false);
    procedure oCk_MetrosDl_SClick(Sender: TObject);
    procedure oCk_MetrosDl_EClick(Sender: TObject);
    procedure Calc_Conses(iSkip: integer);
  private
    iOption: integer;
    bOk_Chg_Mts: boolean;
    bSkip_Conse: boolean;
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
  fCaptura1: TfCaptura1;
  bFoundMach: boolean;
  bChangeMeters: boolean;
  MyOp: Op;

implementation

uses UtilesV20, Denominaciones, Clientes, Empresa, MaquinasTC, Municipios,
  rutas,
  UTEval, acceso1;
{$R *.dfm}

procedure TfCaptura1.FormCreate(Sender: TObject);
begin
  self.bSkip_Conse := true;
  iOption := 0;
  self.bOk_Chg_Mts := false;
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  bFoundMach := false;
  bChangeMeters := true;
  MyOp.iItbms := 0;

  freeandnil(oConection);

  otEmpresa.close;
  otClientes.close;
  otMunicipios.close;
  otOperaciones.close;
  otRutas.close;

  otEmpresa.Connection := fUtilesV20.oPublicCnn;
  otClientes.Connection := fUtilesV20.oPublicCnn;
  otMunicipios.Connection := fUtilesV20.oPublicCnn;
  otOperaciones.Connection := fUtilesV20.oPublicCnn;
  otRutas.Connection := fUtilesV20.oPublicCnn;

  otEmpresa.Open;
  otClientes.Open;
  otMunicipios.Open;
  otRutas.Open;
  otOperaciones.Filter := 'maqtc_tipomaq=1 and op_emp_id =' + QuotedStr(IntToStr(UtilesV20.iId_Empresa));
  otOperaciones.Filtered := true;
  otOperaciones.Open;

  oDC_Empresa.DataSet := otEmpresa;
  oDC_Cliente.DataSet := otClientes;
  oDC_Municipio.DataSet := otMunicipios;
  oDC_Operacion.DataSet := otOperaciones;
  oDC_Ruta.DataSet := otRutas;

  oDC_Empresa.Enabled := true;
  oDC_Cliente.Enabled := true;
  oDC_Municipio.Enabled := true;
  oDC_Operacion.Enabled := true;
  oDC_Ruta.Enabled := true;
  self.AssgnTabs;
end;

procedure TfCaptura1.FormShow(Sender: TObject);
begin
  iOption := 0;
  self.bOk_Chg_Mts := false;
  self.otOperaciones.Last;
  self.Mostrar_Baja_Prod;
  Enabled_Screen(false);
  self.oMaquinaExit(self);
  self.StatusBar1.Panels[0].Text := 'Servidor: ' + fUtilesV20.oPublicCnn.Params.Values['Server'] + '/' + fUtilesV20.oPublicCnn.Params.Values
    ['Database'];
end;

procedure TfCaptura1.Label10Click(Sender: TObject);
begin

  if ((iOption = 1) or (iOption = 2)) then
  begin
    if (UtilesV20.Is_Super_User() = true) then
      self.bOk_Chg_Mts := true
    else
    begin
      if (self.bOk_Chg_Mts = false) then
      begin
        Application.CreateForm(Tfacceso1, facceso1);
        facceso1.ShowModal;
        if (facceso1.bPass_Ok = true) then
          self.bOk_Chg_Mts := true
        else
          self.bOk_Chg_Mts := false;
        freeandnil(facceso1);
      end;
    end;

    if (self.bOk_Chg_Mts = true) then
    begin
      self.otOp_ea_metroan.Enabled := true;
      self.otOp_ea_metroan.SetFocus;
    end
    else
      self.otOp_ea_metroan.Enabled := false;
  end;
end;

procedure TfCaptura1.Label12Click(Sender: TObject);
begin
  if ((iOption = 1) or (iOption = 2)) then
  begin
    if (UtilesV20.Is_Super_User() = true) then
      self.bOk_Chg_Mts := true
    else
    begin
      if (self.bOk_Chg_Mts = false) then
      begin
        Application.CreateForm(Tfacceso1, facceso1);
        facceso1.ShowModal;
        if (facceso1.bPass_Ok = true) then
          self.bOk_Chg_Mts := true
        else
          self.bOk_Chg_Mts := false;
        freeandnil(facceso1);
      end;
    end;

    if (self.bOk_Chg_Mts = true) then
    begin
      self.otOp_eb_metroan.Enabled := true;
      self.otOp_eb_metroan.SetFocus;
    end
    else
      self.otOp_eb_metroan.Enabled := false;
  end;
end;

procedure TfCaptura1.Label14DblClick(Sender: TObject);
begin
  if ((otOperaciones.State = dsInsert) or (otOperaciones.State = dsEdit)) then
  begin
    Application.CreateForm(TfDenom, fDenom);
    fDenom.ShowModal;
    fDenom.free;
    if oQry_Fnd.State <> dsInactive then
    begin
      oQry_Fnd.Refresh;
      otOperaciones.FieldByName('den_fact_e').AsInteger := oQry_Fnd.FieldByName('den_fact_e').AsInteger;
      otOperaciones.FieldByName('den_fact_s').AsInteger := oQry_Fnd.FieldByName('den_fact_s').AsInteger;
      otOperaciones.FieldByName('den_valore').AsSingle := oQry_Fnd.FieldByName('den_valore').AsSingle;
      otOperaciones.FieldByName('den_valors').AsSingle := oQry_Fnd.FieldByName('den_valors').AsSingle;
    end;
  end;
end;

procedure TfCaptura1.Label15DblClick(Sender: TObject);
begin
  if ((otOperaciones.State = dsInsert) or (otOperaciones.State = dsEdit)) then
  begin
    Application.CreateForm(TfDenom, fDenom);
    fDenom.ShowModal;
    fDenom.free;
    if oQry_Fnd.State <> dsInactive then
    begin
      oQry_Fnd.Refresh;
      otOperaciones.FieldByName('den_fact_e').AsInteger := oQry_Fnd.FieldByName('den_fact_e').AsInteger;
      otOperaciones.FieldByName('den_fact_s').AsInteger := oQry_Fnd.FieldByName('den_fact_s').AsInteger;
      otOperaciones.FieldByName('den_valore').AsSingle := oQry_Fnd.FieldByName('den_valore').AsSingle;
      otOperaciones.FieldByName('den_valors').AsSingle := oQry_Fnd.FieldByName('den_valors').AsSingle;
    end;
  end;
end;

procedure TfCaptura1.Label17Click(Sender: TObject);
begin
  if ((iOption = 1) or (iOption = 2)) then
  begin
    if (UtilesV20.Is_Super_User() = true) then
      self.bOk_Chg_Mts := true
    else
    begin
      if (self.bOk_Chg_Mts = false) then
      begin
        Application.CreateForm(Tfacceso1, facceso1);
        facceso1.ShowModal;
        if (facceso1.bPass_Ok = true) then
          self.bOk_Chg_Mts := true
        else
          self.bOk_Chg_Mts := false;
        freeandnil(facceso1);
      end;
    end;

    if (self.bOk_Chg_Mts = true) then
    begin
      self.otOp_sa_metroan.Enabled := true;
      self.otOp_sa_metroan.SetFocus;
    end
    else
      self.otOp_sa_metroan.Enabled := false;
  end;
end;

procedure TfCaptura1.Label19Click(Sender: TObject);
begin
  if ((iOption = 1) or (iOption = 2)) then
  begin
    if (UtilesV20.Is_Super_User() = true) then
      self.bOk_Chg_Mts := true
    else
    begin
      if (self.bOk_Chg_Mts = false) then
      begin
        Application.CreateForm(Tfacceso1, facceso1);
        facceso1.ShowModal;
        if (facceso1.bPass_Ok = true) then
          self.bOk_Chg_Mts := true
        else
          self.bOk_Chg_Mts := false;
        freeandnil(facceso1);
      end;
    end;

    if (self.bOk_Chg_Mts = true) then
    begin
      self.otOp_sb_metroan.Enabled := true;
      self.otOp_sb_metroan.SetFocus;
    end
    else
      self.otOp_sb_metroan.Enabled := false;
  end;
end;

procedure TfCaptura1.Label1DblClick(Sender: TObject);
var
  bTmp: boolean;
begin
  bTmp := bChangeMeters;
  Application.CreateForm(TfEmpresa, fEmpresa);
  fEmpresa.ShowModal;
  fEmpresa.free;
  otEmpresa.Refresh;
  bChangeMeters := false;
  self.oMaquinaExit(self);
  bChangeMeters := bTmp;
end;

procedure TfCaptura1.Label21DblClick(Sender: TObject);
begin
  if ((otOperaciones.State = dsInsert) or (otOperaciones.State = dsEdit)) then
  begin
    Application.CreateForm(TfDenom, fDenom);
    fDenom.ShowModal;
    fDenom.free;
    if oQry_Fnd.State <> dsInactive then
    begin
      oQry_Fnd.Refresh;
      otOperaciones.FieldByName('den_fact_e').AsInteger := oQry_Fnd.FieldByName('den_fact_e').AsInteger;
      otOperaciones.FieldByName('den_fact_s').AsInteger := oQry_Fnd.FieldByName('den_fact_s').AsInteger;
      otOperaciones.FieldByName('den_valore').AsSingle := oQry_Fnd.FieldByName('den_valore').AsSingle;
      otOperaciones.FieldByName('den_valors').AsSingle := oQry_Fnd.FieldByName('den_valors').AsSingle;
    end;
  end;
end;

procedure TfCaptura1.Label22DblClick(Sender: TObject);
begin
  if ((otOperaciones.State = dsInsert) or (otOperaciones.State = dsEdit)) then
  begin
    Application.CreateForm(TfDenom, fDenom);
    fDenom.ShowModal;
    fDenom.free;
    if oQry_Fnd.State <> dsInactive then
    begin
      oQry_Fnd.Refresh;
      otOperaciones.FieldByName('den_fact_e').AsInteger := oQry_Fnd.FieldByName('den_fact_e').AsInteger;
      otOperaciones.FieldByName('den_fact_s').AsInteger := oQry_Fnd.FieldByName('den_fact_s').AsInteger;
      otOperaciones.FieldByName('den_valore').AsSingle := oQry_Fnd.FieldByName('den_valore').AsSingle;
      otOperaciones.FieldByName('den_valors').AsSingle := oQry_Fnd.FieldByName('den_valors').AsSingle;
    end;
  end;
end;

procedure TfCaptura1.Label2DblClick(Sender: TObject);
var
  bTmp: boolean;
begin
  bTmp := bChangeMeters;
  Application.CreateForm(TfClientes, fClientes);
  fClientes.ShowModal;
  fClientes.free;
  otClientes.Refresh;
  bChangeMeters := false;
  self.oMaquinaExit(self);
  bChangeMeters := bTmp;
end;

procedure TfCaptura1.Label3DblClick(Sender: TObject);
var
  bTmp: boolean;
begin
  bTmp := bChangeMeters;
  Application.CreateForm(TfMunicipios, fMunicipios);
  fMunicipios.ShowModal;
  fMunicipios.free;
  otMunicipios.Refresh;
  bChangeMeters := false;
  self.oMaquinaExit(self);
  bChangeMeters := bTmp;
end;

procedure TfCaptura1.Label51DblClick(Sender: TObject);
var
  bTmp: boolean;
begin
  bTmp := bChangeMeters;
  Application.CreateForm(TfRutas, fRutas);
  fRutas.ShowModal;
  fRutas.free;
  otRutas.Refresh;
  bChangeMeters := false;
  self.oMaquinaExit(self);
  bChangeMeters := bTmp;
end;

procedure TfCaptura1.Label5DblClick(Sender: TObject);
var
  bTmp: boolean;
begin
  bTmp := bChangeMeters;
  Application.CreateForm(TfMaquinasTC, fMaquinasTC);
  fMaquinasTC.ShowModal;
  fMaquinasTC.free;
  bChangeMeters := false;
  self.oMaquinaExit(self);
  bChangeMeters := bTmp;
end;

procedure TfCaptura1.oBtnAbortClick(Sender: TObject);
begin
  if (otOperaciones.State = dsBrowse) then
  begin
    self.oDoc_Fnd.Text := '';
    self.oDoc_Fnd.visible := false;
    self.oDocumento.visible := true;
  end
  else
    self.otOperaciones.Cancel;

  self.DBNavigator1.visible := true;
  self.Enabled_Screen(false);
  self.Action_Control(7);
  self.StatusBar1.Panels[0].Text := 'Servidor: ' + fUtilesV20.oPublicCnn.Params.Values['Server'] + '/' + fUtilesV20.oPublicCnn.Params.Values
    ['Database'];
  iOption := 0;
  self.bSkip_Conse := true;
  self.Mostrar_Baja_Prod;
end;

procedure TfCaptura1.oBtnDeleteClick(Sender: TObject);
var
  nResp: integer;
  dIni, dEnd: Tdatetime;
begin
  dIni := self.otOperaciones.FieldByName('op_fecha_alta').AsDateTime;
  dEnd := fUtilesV20.DateTimeAdd(self.otOperaciones.FieldByName('op_fecha_alta').AsDateTime, dtpDay, 7);

  if (DateUtils.DateInRange(now(), dIni, dEnd) = false) then
  begin
    Application.CreateForm(Tfacceso1, facceso1);
    facceso1.ShowModal;
    if (facceso1.bPass_Ok = false) then
    begin
      Application.MessageBox('No cuenta con permisos para relalizar esta operaci�n?', '', MB_OK);
      exit;
    end;
    freeandnil(facceso1);
  end;

  iOption := 3;
  self.DBNavigator1.visible := false;
  self.Action_Control(3);
  nResp := Application.MessageBox('Seguro desea borrar?', '', MB_YESNO);
  If (nResp = ID_YES) Then
  begin
    self.otOperaciones.Delete;
    self.otOperaciones.Refresh;
  end;
  self.DBNavigator1.visible := true;
  iOption := 0;
  self.Mostrar_Baja_Prod;
end;

procedure TfCaptura1.oBtnEditClick(Sender: TObject);
var
  dIni, dEnd: Tdatetime;
begin
  self.bSkip_Conse := true;
  dIni := self.otOperaciones.FieldByName('op_fecha_alta').AsDateTime;
  dEnd := fUtilesV20.DateTimeAdd(self.otOperaciones.FieldByName('op_fecha_alta').AsDateTime, dtpDay, 7);

  if (UtilesV20.Is_Super_User() = true) then
  begin
    self.bOk_Chg_Mts := true;
  end
  ELSE
  begin
    if (self.bOk_Chg_Mts = false) then
    begin

      if (DateUtils.DateInRange(now(), dIni, dEnd) = false) then
      begin
        Application.CreateForm(Tfacceso1, facceso1);
        facceso1.ShowModal;
        if (facceso1.bPass_Ok = false) then
        begin
          Application.MessageBox('No cuenta con permisos para relalizar esta operaci�n?', '', MB_OK);
          self.bOk_Chg_Mts := false;
          exit;
        end
        ELSE
          self.bOk_Chg_Mts := true;

        freeandnil(facceso1);
      end;
    end;
  end;

  iOption := 2;
  self.otOperaciones.Edit;
  bChangeMeters := false;
  self.oMaquinaExit(self);
  self.DBNavigator1.visible := false;
  self.Enabled_Screen(true);
  self.Action_Control(2);
  self.oMaquina.Enabled := false;
  self.oDocumento.Enabled := false;

  if self.otOp_ea_metroan.visible = true then
    self.otOp_ea_metroan.Enabled := false;

  if self.otOp_sa_metroan.visible = true then
    self.otOp_sa_metroan.Enabled := false;

  if self.otOp_eb_metroan.visible = true then
    self.otOp_eb_metroan.Enabled := false;

  if self.otOp_sb_metroan.visible = true then
    self.otOp_sb_metroan.Enabled := false;

  self.oFecha.SetFocus;
end;

procedure TfCaptura1.oBtnExitClick(Sender: TObject);
begin
  self.close;
end;

procedure TfCaptura1.oBtnFindClick(Sender: TObject);
begin
  self.DBNavigator1.visible := false;
  self.Action_Control(4);
  self.oDoc_Fnd.Text := '';
  self.oDoc_Fnd.top := oDocumento.top;
  self.oDoc_Fnd.left := oDocumento.left;
  self.oDoc_Fnd.visible := true;
  self.oDocumento.visible := false;
  self.oDoc_Fnd.SetFocus;
end;

procedure TfCaptura1.oBtnNewClick(Sender: TObject);
var
  oFileIni: Tinifile;
  dLastDate: TDate;
begin
  self.bSkip_Conse := false;
  iOption := 1;
  oFileIni := Tinifile.Create(ExtractFilePath(Application.ExeName) + 'Data\Config.ini');
  dLastDate := oFileIni.ReadDate('GENERAL', 'lastdate', now());
  oFileIni.free;

  self.otOperaciones.Insert;
  bChangeMeters := true;
  self.oMaquinaExit(self);
  self.DBNavigator1.visible := false;
  self.Enabled_Screen(true);
  self.Clear_Screen();
  self.Action_Control(1);
  self.cbb1.ItemIndex := 0;
  self.oFecha.SetFocus;

  self.oLst_Empresa.KeyValue := 0;
  self.oLst_Clientes.KeyValue := 0;
  self.oLst_Municipios.KeyValue := 0;
  self.oLst_Rutas.KeyValue := 0;
  self.oCk_Baja_Prod.Checked := false;
  self.Mostrar_Baja_Prod;
  self.oFecha.Value := dLastDate;
end;

procedure TfCaptura1.oBtnSaveClick(Sender: TObject);
var
  oFileIni: Tinifile;
  cSql_Ln: string;
begin
  if fUtilesV20.isEmpty(oMaquina.Text) then
  begin
    if ((otOperaciones.State = dsInsert) or (otOperaciones.State = dsInsert)) then
    begin
      Application.MessageBox('El n�mero de m�quina no puede estar vac�o', 'B�squeda de Documento', 0);
      if oMaquina.Enabled = true then
        self.oMaquina.SetFocus;
      exit;
    end;
  end;

  self.otOperaciones.post;

  oFileIni := Tinifile.Create(ExtractFilePath(Application.ExeName) + 'Data\Config.ini');
  oFileIni.WriteDate('GENERAL', 'lastdate', self.oFecha.Value);
  oFileIni.free;

  self.DBNavigator1.visible := true;
  self.Enabled_Screen(false);
  self.Action_Control(6);
  self.StatusBar1.Panels[0].Text := 'Servidor: ' + fUtilesV20.oPublicCnn.Params.Values['Server'] + '/' + fUtilesV20.oPublicCnn.Params.Values
    ['Database'];
  iOption := 0;
  self.bSkip_Conse := true;
end;

function TfCaptura1.Find_In_Op(Nodoc: string): boolean;
var
  oSqlLine: TstringList;
  // oQryFind: TFDQuery;
begin
  oSqlLine := TstringList.Create;
  oSqlLine.Clear;
  oSqlLine.Add('SELECT id_op,op_nodoc,op_chapa,op_fecha,maqlnk_id,op_modelo,cte_nombre_loc ');
  oSqlLine.Add('FROM operacion ');
  oSqlLine.Add('WHERE op_nodoc=' + QuotedStr(Nodoc));
  self.oQuery_Gen.close;
  result := UtilesV20.Exec_Select_SQL(self.oQuery_Gen, oSqlLine.Text, true, false);
  freeandnil(oSqlLine);
  // oQryFind.Close;
end;

procedure TfCaptura1.oDocumentoClick(Sender: TObject);
begin
  self.oDocumento.SelectAll;
end;

procedure TfCaptura1.oDocumentoExit(Sender: TObject);
var
  cCadena: string;
begin
  if fUtilesV20.isEmpty(self.oDocumento.Text) then
    exit;

  if (fUtilesV20.IsStrANumber(trim(self.oDocumento.Text)) = true) then
  begin
    if StrToInt(self.oDocumento.Text) = 0 then
    begin
      self.otOperaciones.FieldByName('op_nodoc').AsString := '';
      self.oDocumento.Text := '';
      exit;
    end;
  end;
  self.oDocumento.Text := fUtilesV20.PadL(trim(self.oDocumento.Text), 8, '0');

  if (otOperaciones.State = dsInsert) then
  begin
    if self.Find_In_Op(self.oDocumento.Text) = true then
    begin
      cCadena := '';
      cCadena := cCadena + 'MAQUINA   :[' + trim(self.oQuery_Gen.FieldByName('op_chapa').AsString) + ']' + #13;
      cCadena := cCadena + 'FECHA     :[' + formatdatetime('dd/mm/yyyy', self.oQuery_Gen.FieldByName('op_fecha').AsDateTime) + ']' + #13;
      cCadena := cCadena + 'MODELO    :[' + trim(self.oQuery_Gen.FieldByName('op_modelo').AsString) + ']' + #13;
      cCadena := cCadena + 'LOCAL     :[' + trim(self.oQuery_Gen.FieldByName('cte_nombre_loc').AsString) + ']' + #13;
      cCadena := cCadena + 'DOCUMENTO :[' + trim(self.oQuery_Gen.FieldByName('op_nodoc').AsString) + ']' + #13;
      messagedlg('El numero de documento ya existe!!!' + #13 + cCadena, mtError, [mbOK], 0);

      self.otOperaciones.FieldByName('op_nodoc').AsString := '';
      self.oDocumento.Text := '';
      self.oDocumento.SetFocus;
      exit;
    end;
  end;

end;

procedure TfCaptura1.oDoc_FndExit(Sender: TObject);
begin
  if (otOperaciones.State = dsBrowse) then
  begin

    if fUtilesV20.isEmpty(self.oDoc_Fnd.Text) then
      exit;
    self.oDoc_Fnd.Text := fUtilesV20.PadL(trim(self.oDoc_Fnd.Text), 8, '0');
    if otOperaciones.Locate('op_nodoc', trim(oDoc_Fnd.Text), []) = false then
      Application.MessageBox('N�mero de documento no existe', 'B�squeda de Documento', 0)
    else
      self.oMaquinaExit(self);

    self.oDoc_Fnd.Text := '';
    self.oDoc_Fnd.visible := false;
    self.oDocumento.visible := true;
    self.oBtnAbortClick(self);
    self.Mostrar_Baja_Prod;
  end;
end;

procedure TfCaptura1.oDoc_FndKeyPress(Sender: TObject; var Key: Char);
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

procedure TfCaptura1.oMaquinaClick(Sender: TObject);
begin
  self.oMaquina.SelectAll;
end;

procedure TfCaptura1.oMaquinaExit(Sender: TObject);
begin
  if (fUtilesV20.isEmpty(oMaquina.Text) or (Uppercase(self.oMaquina.Text) = 'NULL')) then
    exit;
  bFoundMach := self.Buscar_Maquina(self.oQry_Fnd, trim(oMaquina.Text));
  if (bFoundMach = false) then
  begin
    self.otOperaciones.FieldByName('op_chapa').AsString := '';
    self.oMaquina.Text := '';
    if oMaquina.Enabled = true then
      self.oMaquina.SetFocus;
    exit;
  end;

  self.oLst_Empresa.KeyValue := oQry_Fnd.FieldByName('emp_id').AsInteger;
  self.oLst_Clientes.KeyValue := oQry_Fnd.FieldByName('cte_id').AsInteger;
  self.oLst_Municipios.KeyValue := oQry_Fnd.FieldByName('mun_id').AsInteger;
  self.oLst_Rutas.KeyValue := oQry_Fnd.FieldByName('rut_id').AsInteger;

  if ((otOperaciones.State = dsInsert) or (otOperaciones.State = dsEdit)) then
  begin

    if bFoundMach = false then
      exit;
    MyOp.Denom_Ent_Fac := oQry_Fnd.FieldByName('den_fact_e').AsInteger;
    MyOp.Denom_Sal_Fac := oQry_Fnd.FieldByName('den_fact_s').AsInteger;
    MyOp.Denom_Ent_Val := oQry_Fnd.FieldByName('den_valore').AsSingle;
    MyOp.Denom_Sal_Val := oQry_Fnd.FieldByName('den_valors').AsSingle;

    if (MyOp.Denom_Ent_Fac = 0) then
    begin
      self.mask_fields(true, true);
      MyOp.Denom_Ent_Val := 1;
    end
    else
      self.mask_fields(true, false);

    if (MyOp.Denom_Sal_Fac = 0) then
    begin
      self.mask_fields(false, true);
      MyOp.Denom_Sal_Val := 1;
    end
    else
      self.mask_fields(false, false);

    MyOp.Porc_Loc := fUtilesV20.iif(oQry_Fnd.FieldByName('cte_poc_ret').AsSingle = 0, 1, oQry_Fnd.FieldByName('cte_poc_ret').AsSingle);

    MyOp.Porc_Loc := oQry_Fnd.FieldByName('cte_poc_ret').AsSingle;

    self.olBruto_Cte.Hint := 'Porcentaje Cliente [' + FormatFloat('##,##0.00', oQry_Fnd.FieldByName('cte_poc_ret').AsSingle) + '%]';
    self.olBruto_Cte.ShowHint := true;
    self.olNeto_Cte.Hint := 'Porcentaje Cliente [' + FormatFloat('##,##0.00', oQry_Fnd.FieldByName('cte_poc_ret').AsSingle) + '%]';
    self.olNeto_Cte.ShowHint := true;
    self.olTot_Colectado.Hint := 'Factor de Conversi�n [' + IntToStr(MyOp.Denom_Ent_Fac) + '/ $' +
      FormatFloat('##,##0.00', MyOp.Denom_Ent_Val) + ']';
    self.olTot_Colectado.ShowHint := true;
    self.olTot_Credito.Hint := 'Factor de Conversi�n [' + IntToStr(MyOp.Denom_Sal_Fac) + '/ $' +
      FormatFloat('##,##0.00', MyOp.Denom_Sal_Val) + ']';
    self.olTot_Credito.ShowHint := true;

    otOperaciones.FieldByName('op_modelo').AsString := oQry_Fnd.FieldByName('maqtc_modelo').AsString;
    otOperaciones.FieldByName('cte_nombre_loc').AsString := oQry_Fnd.FieldByName('cte_nombre_loc').AsString;
    otOperaciones.FieldByName('cte_nombre_com').AsString := oQry_Fnd.FieldByName('cte_nombre_com').AsString;
    otOperaciones.FieldByName('cte_pag_jcj').AsInteger := oQry_Fnd.FieldByName('cte_pag_jcj').AsInteger;
    otOperaciones.FieldByName('cte_pag_spac').AsInteger := oQry_Fnd.FieldByName('cte_pag_spac').AsInteger;
    otOperaciones.FieldByName('cte_pag_impm').AsInteger := oQry_Fnd.FieldByName('cte_pag_impm').AsInteger;
    otOperaciones.FieldByName('op_cporc_Loc').AsInteger := oQry_Fnd.FieldByName('cte_poc_ret').AsInteger;
    otOperaciones.FieldByName('maqtc_denom_e').AsInteger := oQry_Fnd.FieldByName('maqtc_denom_e').AsInteger;
    otOperaciones.FieldByName('maqtc_denom_s').AsInteger := oQry_Fnd.FieldByName('maqtc_denom_s').AsInteger;
    otOperaciones.FieldByName('maqtc_tipomaq').AsInteger := oQry_Fnd.FieldByName('maqtc_tipomaq').AsInteger;
    otOperaciones.FieldByName('den_fact_e').AsInteger := oQry_Fnd.FieldByName('den_fact_e').AsInteger;
    otOperaciones.FieldByName('den_fact_s').AsInteger := oQry_Fnd.FieldByName('den_fact_s').AsInteger;
    otOperaciones.FieldByName('den_valore').AsSingle := oQry_Fnd.FieldByName('den_valore').AsSingle;
    otOperaciones.FieldByName('den_valors').AsSingle := oQry_Fnd.FieldByName('den_valors').AsSingle;
    otOperaciones.FieldByName('maqtc_id').AsInteger := oQry_Fnd.FieldByName('maqtc_id').AsInteger;
    otOperaciones.FieldByName('jueg_cod').AsInteger := oQry_Fnd.FieldByName('jueg_cod').AsInteger;
    otOperaciones.FieldByName('prov_cod').AsInteger := oQry_Fnd.FieldByName('prov_cod').AsInteger;
    otOperaciones.FieldByName('op_maq_proc_cons').AsSingle := oQry_Fnd.FieldByName('maqtc_porc_conc').AsSingle;
    self.olTot_Conses.Hint := 'Porcentaje en consesi�n [' + FormatFloat('##,##0.00', oQry_Fnd.FieldByName('maqtc_porc_conc')
      .AsSingle) + '%]';
    if (otOperaciones.State = dsInsert) THEN
      otOperaciones.FieldByName('op_tot_porc_cons').AsSingle := 0.00;

    if (self.otOperaciones.State = dsInsert) then
    begin
      if oQry_Fnd.FieldByName('cte_pag_jcj').Value = 0 then
        otOperaciones.FieldByName('Op_tot_impjcj').AsSingle := (oQry_Fnd.FieldByName('emp_cargo_jcj').AsSingle / 4);

      if oQry_Fnd.FieldByName('cte_pag_impm').Value = 0 then
        otOperaciones.FieldByName('Op_tot_impmunic').AsSingle := oQry_Fnd.FieldByName('mun_impuesto').AsSingle;
    end;
    if bChangeMeters = false then
      exit;

    Case oQry_Fnd.FieldByName('maqtc_metros').AsInteger of
      1:
        begin
          if self.otOperaciones.State = dsInsert then
          begin
            // Entradas A
            self.otOp_ea_metroac.visible := true; { Actual }
            self.otOp_ea_metroan.visible := true; { Anterior }
            otOperaciones.FieldByName('Op_ea_metroac').AsInteger := 0;
            otOperaciones.FieldByName('Op_ea_metroan').AsInteger := oQry_Fnd.FieldByName('maqtc_m1e_act').AsInteger;
            // Salidas A
            self.otOp_sa_metroac.visible := true; { Actual }
            self.otOp_sa_metroan.visible := true; { Anterior }
            otOperaciones.FieldByName('Op_sa_metroac').AsInteger := 0;
            otOperaciones.FieldByName('Op_sa_metroan').AsInteger := oQry_Fnd.FieldByName('maqtc_m1s_act').AsInteger;

            if oQry_Fnd.FieldByName('maqtc_m1e_aNT').AsInteger = 0 then
              self.otOp_ea_metroan.Enabled := true
            else
              self.otOp_ea_metroan.Enabled := false;

            if oQry_Fnd.FieldByName('maqtc_m1s_aNT').AsInteger = 0 then
              self.otOp_sa_metroan.Enabled := true
            else
              self.otOp_sa_metroan.Enabled := false;

          end
          else
          begin
            // Entradas A
            self.otOp_ea_metroac.visible := true; { Actual }
            self.otOp_ea_metroan.visible := true; { Anterior }
            self.otOperaciones.FieldByName('Op_ea_metroac').AsInteger := oQry_Fnd.FieldByName('maqtc_m1e_act').AsInteger;
            otOperaciones.FieldByName('Op_ea_metroan').AsInteger := oQry_Fnd.FieldByName('maqtc_m1e_ant').AsInteger;
            // Salidas A
            self.otOp_sa_metroac.visible := true; { Actual }
            self.otOp_sa_metroan.visible := true; { Anterior }
            otOperaciones.FieldByName('Op_sa_metroac').AsInteger := oQry_Fnd.FieldByName('maqtc_m1s_act').AsInteger;
            otOperaciones.FieldByName('Op_sa_metroan').AsInteger := oQry_Fnd.FieldByName('maqtc_m1s_ant').AsInteger;
          end;
          // Entradas B
          self.otOp_eb_metroac.visible := false; { Actual }
          self.otOp_eb_metroan.visible := false; { Anterior }
          otOperaciones.FieldByName('Op_eb_metroac').AsInteger := 0;
          otOperaciones.FieldByName('Op_eb_metroan').AsInteger := 0;
          // Salidas B
          self.otOp_sb_metroac.visible := false; { Actual }
          self.otOp_sb_metroan.visible := false; { Anterior }
          otOperaciones.FieldByName('Op_sb_metroac').AsInteger := 0;
          otOperaciones.FieldByName('Op_sb_metroan').AsInteger := 0;
        end;
      2:
        begin
          if self.otOperaciones.State = dsInsert then
          begin
            // Entradas A
            self.otOp_ea_metroac.visible := true; { Actual }
            self.otOp_ea_metroan.visible := true; { Anterior }
            self.otOperaciones.FieldByName('Op_ea_metroac').AsInteger := 0
            { &&maquinas.m1e_act };
            self.otOperaciones.FieldByName('Op_ea_metroan').AsInteger := oQry_Fnd.FieldByName('maqtc_m1e_act').AsInteger;
            // Salidas A
            self.otOp_sa_metroac.visible := true; { Actual }
            self.otOp_sa_metroan.visible := true; { Anterior }
            self.otOperaciones.FieldByName('Op_sa_metroac').AsInteger := 0;
            { maquinas.m1s_act }
            self.otOperaciones.FieldByName('Op_sa_metroan').AsInteger := oQry_Fnd.FieldByName('maqtc_m1s_act').AsInteger;
            if oQry_Fnd.FieldByName('maqtc_m1e_ant').AsInteger = 0 then
              self.otOp_ea_metroan.Enabled := true
            else
              self.otOp_ea_metroan.Enabled := false;

            IF oQry_Fnd.FieldByName('maqtc_m1s_ant').AsInteger = 0 then
              self.otOp_sa_metroan.Enabled := true
            else
              self.otOp_sa_metroan.Enabled := false;
            // --------------------------------------------------------
            // Entradas B
            self.otOp_eb_metroac.visible := true; { Actual }
            self.otOp_eb_metroan.visible := true; { Anterior }
            otOperaciones.FieldByName('Op_eb_metroac').AsInteger := 0;
            otOperaciones.FieldByName('Op_eb_metroan').AsInteger := oQry_Fnd.FieldByName('maqtc_m2e_act').AsInteger;
            // Salidas B

            self.otOp_sb_metroac.visible := true; { Actual }
            self.otOp_sb_metroan.visible := true; { Anterior }
            otOperaciones.FieldByName('Op_sb_metroac').AsInteger := 0;
            otOperaciones.FieldByName('Op_sb_metroan').AsInteger := oQry_Fnd.FieldByName('maqtc_m2s_act').AsInteger;
            if oQry_Fnd.FieldByName('maqtc_m2e_ant').AsInteger = 0 then
              self.otOp_eb_metroan.Enabled := true
            else
              self.otOp_eb_metroan.Enabled := false;
            IF oQry_Fnd.FieldByName('maqtc_m2s_ant').AsInteger = 0 then
              self.otOp_sb_metroan.Enabled := true
            else
              self.otOp_sb_metroan.Enabled := false;
          end
          else
          begin
            // Entradas A
            self.otOp_ea_metroac.visible := true; { Actual }
            self.otOp_ea_metroan.visible := true; { Anterior }
            // Salidas A
            self.otOp_sa_metroac.visible := true; { Actual }
            self.otOp_sa_metroan.visible := true; { Anterior }
            // --------------------------------------------------------
            // Entradas B
            self.otOp_eb_metroac.visible := false; { Actual }
            self.otOp_eb_metroan.visible := false; { Anterior }
            // Salidas B
            self.otOp_sb_metroac.visible := false; { Actual }
            self.otOp_sb_metroan.visible := false; { Anterior }
          end;
        end;
    else
      ShowMessage('A las m�quinas no se le han sido asiganado la informaci�n de metros, favor asignar la informaci�n de metros');
      // Entradas A
      self.otOp_ea_metroac.visible := true; { Actual }
      self.otOp_ea_metroan.visible := true; { Anterior }
      // Salidas A
      self.otOp_sa_metroac.visible := true; { Actual }
      self.otOp_sa_metroan.visible := true; { Anterior }
      // --------------------------------------------------------
      // Entradas B
      self.otOp_eb_metroac.visible := false; { Actual }
      self.otOp_eb_metroan.visible := false; { Anterior }
      // Salidas B
      self.otOp_sb_metroac.visible := false; { Actual }
      self.otOp_sb_metroan.visible := false; { Anterior }
    End;
  end;
end;

procedure TfCaptura1.oSemanaClick(Sender: TObject);
begin
  self.oSemana.SelectAll;
end;

procedure TfCaptura1.otOp_ea_metroanClick(Sender: TObject);
begin
  self.otOp_ea_metroan.SelectAll;
end;

procedure TfCaptura1.otOp_ea_metroanExit(Sender: TObject);
begin
  self.Calc_Dif_Ent(true);
  self.Calc_Tot(1);
end;

procedure TfCaptura1.otOp_eb_metroacClick(Sender: TObject);
begin
  self.otOp_eb_metroac.SelectAll;
end;

procedure TfCaptura1.otOp_eb_metroacExit(Sender: TObject);
begin
  self.Calc_Dif_Ent(false);
  self.Calc_Tot(1);
end;

procedure TfCaptura1.otOp_eb_metroanClick(Sender: TObject);
begin
  self.otOp_eb_metroan.SelectAll;
end;

procedure TfCaptura1.otOp_eb_metroanExit(Sender: TObject);
begin
  self.Calc_Dif_Ent(false);
  self.Calc_Tot(1);
end;

procedure TfCaptura1.otop_e_pantallaClick(Sender: TObject);
begin
  self.otop_e_pantalla.SelectAll;
end;

procedure TfCaptura1.otop_e_pantallaExit(Sender: TObject);
begin
  self.Calc_Dif_Ent(false);
  self.Calc_Tot(1);
end;

procedure TfCaptura1.otOp_sa_metroacClick(Sender: TObject);
begin
  self.otOp_sa_metroac.SelectAll;
end;

procedure TfCaptura1.otOp_sa_metroacExit(Sender: TObject);
begin
  self.Calc_Dif_Sal(true);
  self.Tot_Cred(1);
end;

procedure TfCaptura1.otOp_sa_metroanClick(Sender: TObject);
begin
  self.otOp_sa_metroan.SelectAll;
end;

procedure TfCaptura1.otOp_sa_metroanExit(Sender: TObject);
begin
  self.Calc_Dif_Sal(true);
  self.Tot_Cred(1);
end;

procedure TfCaptura1.otOp_sb_metroacClick(Sender: TObject);
begin
  self.otOp_sb_metroac.SelectAll;
end;

procedure TfCaptura1.otOp_sb_metroacExit(Sender: TObject);
begin
  self.Calc_Dif_Sal(false);
  self.Tot_Cred(1);
end;

procedure TfCaptura1.otOp_sb_metroanClick(Sender: TObject);
begin
  self.otOp_sb_metroan.SelectAll;
end;

procedure TfCaptura1.otOp_sb_metroanExit(Sender: TObject);
begin
  self.Calc_Dif_Sal(false);
  self.Tot_Cred(1);
end;

procedure TfCaptura1.otOp_s_pantallaClick(Sender: TObject);
begin
  self.otOp_s_pantalla.SelectAll;
end;

procedure TfCaptura1.otOp_s_pantallaExit(Sender: TObject);
begin
  self.Calc_Dif_Sal(true);
  self.Tot_Cred(1);
end;

procedure TfCaptura1.otOp_tot_brutoempClick(Sender: TObject);
begin
  self.otOp_tot_brutoemp.SelectAll;
end;

procedure TfCaptura1.otOp_tot_brutolocClick(Sender: TObject);
begin
  self.otOp_tot_brutoloc.SelectAll;
end;

procedure TfCaptura1.otOp_tot_colectClick(Sender: TObject);
begin
  self.otOp_tot_colect.SelectAll;
end;

procedure TfCaptura1.otOp_tot_colectExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura1.otOp_tot_credClick(Sender: TObject);
begin
  self.otOp_tot_cred.SelectAll;
end;

procedure TfCaptura1.otOp_tot_credExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura1.otOp_tot_devClick(Sender: TObject);
begin
  self.otOp_tot_dev.SelectAll;
end;

procedure TfCaptura1.otOp_tot_devExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura1.otOp_tot_impjcjClick(Sender: TObject);
begin
  self.otOp_tot_impjcj.SelectAll;
end;

procedure TfCaptura1.otOp_tot_impjcjExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura1.otOp_tot_impmunicClick(Sender: TObject);
begin
  self.otOp_tot_impmunic.SelectAll;
end;

procedure TfCaptura1.otOp_tot_impmunicExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura1.otOp_tot_itbmClick(Sender: TObject);
begin
  self.otOp_tot_itbm.SelectAll;
end;

procedure TfCaptura1.otOp_tot_netoempClick(Sender: TObject);
begin
  self.otOp_tot_netoemp.SelectAll;
end;

procedure TfCaptura1.otOp_tot_netolocClick(Sender: TObject);
begin
  self.otOp_tot_netoloc.SelectAll;
end;

procedure TfCaptura1.otOp_tot_otrosClick(Sender: TObject);
begin
  self.otOp_tot_otros.SelectAll;
end;

procedure TfCaptura1.otOp_tot_otrosExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura1.otOp_tot_subClick(Sender: TObject);
begin
  self.otOp_tot_sub.SelectAll;
end;

procedure TfCaptura1.Action_Control(pOption: integer);
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
    oBtnSave.Enabled := true;
    oBtnExit.visible := true;
    // self.oCk_Baja_Prod.Checked := false;
  end;
end;

function TfCaptura1.Buscar_Maquina(var oQry_Fnd: TFDQuery; pNum_Maq: string): boolean;
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
  sSql := sSql + '  maquinastc.maqtc_inactivo, ';
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
  sSql := sSql + '  maquinastc.jueg_cod, ';
  sSql := sSql + '  maquinastc.prov_cod, ';
  sSql := sSql + '  maquinastc.maqtc_porc_conc, ';
  sSql := sSql + '  maquinas_lnk.MaqLnk_Id, ';
  sSql := sSql + '  clientes.cte_id, ';
  sSql := sSql + '  clientes.cte_nombre_loc, ';
  sSql := sSql + '  clientes.cte_nombre_com, ';
  sSql := sSql + '  clientes.cte_inactivo, ';
  sSql := sSql + '  clientes.cte_pag_jcj, ';
  sSql := sSql + '  clientes.cte_pag_impm, ';
  sSql := sSql + '  clientes.cte_pag_spac, ';
  sSql := sSql + '  clientes.cte_poc_ret, ';
  sSql := sSql + '  clientes.mun_id, ';
  sSql := sSql + '  clientes.rut_id, ';
  sSql := sSql + '  rutas.rut_nombre, ';
  sSql := sSql + '  empresas.emp_id, ';
  sSql := sSql + '  empresas.emp_descripcion, ';
  sSql := sSql + '  empresas.emp_inactivo, ';
  sSql := sSql + '  empresas.emp_cargo_jcj, ';
  sSql := sSql + '  empresas.emp_cargo_spac, ';
  sSql := sSql + '  municipios.mun_nombre, ';
  sSql := sSql + '  municipios.mun_impuesto, ';
  sSql := sSql + '  a.den_valor AS den_valore , ';
  sSql := sSql + '  b.den_valor AS den_valors , ';
  sSql := sSql + '  a.den_fact_e , ';
  sSql := sSql + '  b.den_fact_s  ';
  sSql := sSql + 'FROM maquinastc ';
  sSql := sSql + '  INNER JOIN maquinas_lnk ON (maquinastc.maqtc_id = maquinas_lnk.maqtc_id) ';
  sSql := sSql + '  LEFT JOIN clientes  ON (maquinas_lnk.cte_id = clientes.cte_id) ';
  sSql := sSql + '  LEFT JOIN empresas   ON (maquinas_lnk.emp_id = empresas.emp_id) ';
  sSql := sSql + '  LEFT JOIN municipios ON (clientes.mun_id = municipios.mun_id) ';
  sSql := sSql + '  LEFT JOIN rutas      ON (clientes.rut_id = rutas.rut_id) ';
  sSql := sSql + '  LEFT JOIN denominaciones a ON (maquinastc.maqtc_denom_e = a.den_id) ';
  sSql := sSql + '  LEFT JOIN denominaciones b ON (maquinastc.maqtc_denom_s = b.den_id) ';
  sSql := sSql + 'WHERE maqtc_tipomaq = 1 ';
  sSql := sSql + 'AND TRIM(maquinastc.maqtc_chapa) =' + QuotedStr(trim(pNum_Maq)) + ' ';
  sSql := sSql + 'AND empresas.emp_id =' + QuotedStr(IntToStr(UtilesV20.iId_Empresa)) + ' ';
  result := UtilesV20.Exec_Select_SQL(oQry_Fnd, sSql, true, true);
  self.bSkip_Conse := false;

  if (result = false) then
  begin
    Application.MessageBox('el c�digo de m�quina no existe o no tiene un cliente asignado', 'Precausi�n');
    exit;
  end;

end;

procedure TfCaptura1.Calc_Tot(iForce: integer);
var
  iTot: single;
  ipFac_e: single;
begin
  // ipFac_e := fUtilesV20.iif(MyOp.Denom_Ent_Fac = 0, 1, MyOp.Denom_Ent_Fac);
  ipFac_e := MyOp.Denom_Ent_Fac;
  if (ipFac_e = 0) then
    iTot := (MyOp.MetroA_EntDif + MyOp.MetroB_EntDif)
  else
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
  self.otOperaciones.FieldByName('op_cal_colect').AsFloat := iTot;
end;

procedure TfCaptura1.Tot_Cred(iForce: integer);
var
  iTot: single;
  ipFac_s: single;
begin
  // ipFac_s := fUtilesV20.iif(MyOp.Denom_Sal_Fac = 0, 1, MyOp.Denom_Sal_Fac);
  ipFac_s := MyOp.Denom_Sal_Fac;
  if (ipFac_s = 0) then
    iTot := (MyOp.MetroA_SalDif + MyOp.MetroB_SalDif)
  else
    iTot := ((MyOp.MetroA_SalDif + MyOp.MetroB_SalDif) / ipFac_s) * fUtilesV20.iif(MyOp.Denom_Sal_Val = 0, 1, MyOp.Denom_Sal_Val);
  MyOp.Suma_Cred := iTot;
  if (iForce = 1) then
  begin
    self.otOp_tot_cred.Value := iTot;
    self.Calc_Sub_Tot;
  end
  else
  begin
    if self.otOp_tot_cred.Value <= 0 THEN
    begin
      self.otOp_tot_cred.Value := iTot;
      self.Calc_Sub_Tot;
    end
  end;
  self.otOperaciones.FieldByName('op_cal_cred').AsFloat := iTot;
  self.otOp_tot_cred.Refresh;
end;

procedure TfCaptura1.Calc_Sub_Tot;
var
  ipK_porc: single;
  iTot1: single;
  iTot2: single;
  iTotImp: single;
begin
  self.Calc_Conses(0);
  ipK_porc := fUtilesV20.iif(MyOp.Porc_Loc = 0, 1, MyOp.Porc_Loc);
  ipK_porc := MyOp.Porc_Loc;
  iTotImp := (self.otOp_tot_timbres.Value + self.otOp_tot_impmunic.Value + self.otOp_tot_impjcj.Value + self.otop_tot_porc_cons.Value);

  iTot1 := (iTotImp + self.otOp_tot_tec.Value);
  iTot2 := (self.otOp_tot_dev.Value + self.otOp_tot_otros.Value + self.otOp_tot_cred.Value);

  self.otOp_tot_sub.Value := (self.otOp_tot_colect.Value - iTot1 - iTot2);

  self.otOp_tot_itbm.Value := (self.otOp_tot_sub.Value * (MyOp.iItbms / 100));
  self.otOp_tot_tot.Value := (self.otOp_tot_sub.Value - self.otOp_tot_itbm.Value);
  if ipK_porc = 100 then
  begin
    self.otOp_tot_brutoloc.Value := 0;
    self.otOp_tot_brutoemp.Value := self.otOp_tot_tot.Value;
  end
  else
  begin
    self.otOp_tot_brutoloc.Value := (self.otOp_tot_tot.Value * (ipK_porc / 100));
    self.otOp_tot_brutoemp.Value := (self.otOp_tot_tot.Value - self.otOp_tot_brutoloc.Value);
  end;
  self.otOp_tot_netoloc.Value := (self.otOp_tot_dev.Value + self.otOp_tot_otros.Value + self.otOp_tot_cred.Value +
    self.otOp_tot_brutoloc.Value);
  self.otOp_tot_netoemp.Value := (iTotImp + self.otOp_tot_tec.Value + self.otOp_tot_brutoemp.Value);
  self.Refresh;
end;

procedure TfCaptura1.otOp_tot_tecClick(Sender: TObject);
begin
  self.otOp_tot_tec.SelectAll;
end;

procedure TfCaptura1.otOp_tot_tecExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura1.otOp_tot_timbresClick(Sender: TObject);
begin
  self.otOp_tot_timbres.SelectAll;
end;

procedure TfCaptura1.otOp_tot_timbresExit(Sender: TObject);
begin
  self.Calc_Sub_Tot;
end;

procedure TfCaptura1.otOp_tot_totClick(Sender: TObject);
begin
  self.otOp_tot_tot.SelectAll;
end;

procedure TfCaptura1.Clear_Screen;
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

procedure TfCaptura1.oCk_Baja_ProdClick(Sender: TObject);
begin
  if self.otOperaciones.State in [dsInsert, dsEdit] then
  begin
    if (self.oCk_Baja_Prod.Checked = true) then
    begin

      otOperaciones.FieldByName('op_tot_colect').AsFloat := 0;
      otOperaciones.FieldByName('op_tot_timbres').AsFloat := 0;
      otOperaciones.FieldByName('op_tot_impmunic').AsFloat := 0;
      otOperaciones.FieldByName('op_tot_impjcj').AsFloat := 0;
      otOperaciones.FieldByName('op_tot_tec').AsFloat := 0;

      otOperaciones.FieldByName('op_tot_dev').AsFloat := 0;
      otOperaciones.FieldByName('op_tot_otros').AsFloat := 0;
      otOperaciones.FieldByName('op_tot_cred').AsFloat := 0;

      self.otOp_tot_colect.Value := 0;
      self.otOp_tot_timbres.Value := 0;
      self.otOp_tot_impmunic.Value := 0;
      self.otOp_tot_impjcj.Value := 0;
      self.otOp_tot_tec.Value := 0;

      self.otOp_tot_dev.Value := 0;
      self.otOp_tot_otros.Value := 0;
      self.otOp_tot_cred.Value := 0;

      self.Calc_Sub_Tot;

      self.otOp_observ.Text := 'BAJA PRODUCCION.';

      self.otOp_ea_metroac.Value := self.otOp_ea_metroan.Value;
      self.otOp_sa_metroac.Value := self.otOp_sa_metroan.Value;

      self.otOp_eb_metroac.Value := self.otOp_eb_metroan.Value;
      self.otOp_sb_metroac.Value := self.otOp_sb_metroan.Value;
      // ----------------------------------------------------------------------------------
      self.otOp_tot_colect2.Value := 0.00;
      self.otOp_tot_cred2.Value := 0.00;
      // ----------------------------------------------------------------------------------

      self.otOp_eb_metroac.Enabled := false;
      self.otOp_sb_metroac.Enabled := false;
      self.otOp_ea_metroac.Enabled := false;
      self.otOp_sa_metroac.Enabled := false;
    end
    else
    begin
      self.otOp_tot_colect2.Value := 0.00;
      self.otOp_tot_cred2.Value := 0.00;

      self.otOp_eb_metroac.Enabled := true;
      self.otOp_sb_metroac.Enabled := true;
      self.otOp_ea_metroac.Enabled := true;
      self.otOp_sa_metroac.Enabled := true;
    end;
    self.Mostrar_Baja_Prod;
  end;
end;

procedure TfCaptura1.oCk_MetrosDl_EClick(Sender: TObject);
begin
  if (self.oCk_MetrosDl_E.Checked = true) then
  begin
    self.mask_fields(true, true);
    MyOp.Denom_Ent_Fac := 0;
    MyOp.Denom_Ent_Val := 1;
  end
  else
  begin
    MyOp.Denom_Ent_Fac := oQry_Fnd.FieldByName('den_fact_e').AsInteger;
    MyOp.Denom_Ent_Val := oQry_Fnd.FieldByName('den_valore').AsSingle;
    self.mask_fields(true, false);
  end;
end;

procedure TfCaptura1.oCk_MetrosDl_SClick(Sender: TObject);
begin
  if (self.oCk_MetrosDl_S.Checked = true) then
  begin
    self.mask_fields(false, true);
    MyOp.Denom_Sal_Fac := 0;
    MyOp.Denom_Sal_Val := 1;
  end
  else
  begin
    MyOp.Denom_Sal_Fac := oQry_Fnd.FieldByName('den_fact_s').AsInteger;
    MyOp.Denom_Sal_Val := oQry_Fnd.FieldByName('den_valors').AsSingle;
    self.mask_fields(false, false);
  end;
end;

procedure TfCaptura1.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  self.oMaquinaExit(self);
  self.Mostrar_Baja_Prod;
end;

procedure TfCaptura1.Enabled_Screen(bFlag: boolean);
var
  j: integer;
  oComponents: TControl;
begin
  for j := 0 to ComponentCount - 1 do
  begin
    if (Components[j] is TCheckBox) then
    begin
      oComponents := TCheckBox(self.Components[j]);
      if (oComponents.TAG <> 1) then
        oComponents.Enabled := bFlag;
    end;
    if (Components[j] is TDBCheckBox) then
    begin
      oComponents := TDBCheckBox(self.Components[j]);
      if (oComponents.TAG <> 1) then
        oComponents.Enabled := bFlag;
    end;
    if (Components[j] is TDBMemo) then
    begin
      oComponents := TDBMemo(self.Components[j]);
      if (oComponents.TAG <> 1) then
        oComponents.Enabled := bFlag;
    end;
    if (Components[j] is TDBEdit) then
    begin
      oComponents := TDBEdit(self.Components[j]);
      if (oComponents.TAG <> 1) then
        oComponents.Enabled := bFlag;
    end;
    if (Components[j] is TDBDateTimeEditEh) then
    begin
      oComponents := TDBDateTimeEditEh(self.Components[j]);
      if (oComponents.TAG <> 1) then
        oComponents.Enabled := bFlag;
    end;
    if (Components[j] is TDBNumberEditEh) then
    begin
      oComponents := TDBNumberEditEh(self.Components[j]);
      if (oComponents.TAG <> 1) then
        oComponents.Enabled := bFlag;
    end;
    if (Components[j] is TDBLookupComboboxEh) then
    begin
      oComponents := TDBLookupComboboxEh(self.Components[j]);
      if (oComponents.TAG <> 1) then
        oComponents.Enabled := bFlag;
    end;
    if (Components[j] is TDBComboBoxEh) then
    begin
      oComponents := TDBComboBoxEh(self.Components[j]);
      if (oComponents.TAG <> 1) then
        oComponents.Enabled := bFlag;
    end;
  end;
  // self.DBNavigator1.visible := false;
end;

procedure TfCaptura1.AssgnTabs;
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

procedure TfCaptura1.EnterAsTab(Sender: TObject; var Key: Char);
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

procedure TfCaptura1.Calc_Dif_Ent(A: boolean);
begin
  if A = true then
    MyOp.MetroA_EntDif := (self.otOp_ea_metroac.Value - self.otOp_ea_metroan.Value)
  else
    MyOp.MetroB_EntDif := (self.otOp_eb_metroac.Value - self.otOp_eb_metroan.Value);
end;

procedure TfCaptura1.Calc_Dif_Sal(A: boolean);
begin
  if A = true then
    MyOp.MetroA_SalDif := (self.otOp_sa_metroac.Value - self.otOp_sa_metroan.Value)
  else
    MyOp.MetroB_SalDif := (self.otOp_sb_metroac.Value - self.otOp_sb_metroan.Value)
end;

procedure TfCaptura1.otOperacionesBeforePost(DataSet: TDataSet);
var
  cSql_Ln: string;
begin
  DataSet.FieldByName('op_emp_id').AsInteger := UtilesV20.iId_Empresa;
  DataSet.FieldByName('MaqLnk_Id').Value := oQry_Fnd.FieldByName('MaqLnk_Id').AsInteger;

  // DataSet.FieldByName('cte_id').Value := oQry_Fnd.FieldByName('cte_id').AsInteger;
  if DataSet.State = dsEdit then
  begin
    DataSet.FieldByName('u_usuario_modif').AsString := UtilesV20.sUserName;
    DataSet.FieldByName('op_fecha_modif').Value := now();
  end
  else if DataSet.State = dsInsert then
  begin
    DataSet.FieldByName('u_usuario_alta').AsString := UtilesV20.sUserName;
    DataSet.FieldByName('op_fecha_alta').Value := now();
    cSql_Ln := '';
    cSql_Ln := cSql_Ln + 'UPDATE maquinastc SET ';
    cSql_Ln := cSql_Ln + '  maqtc_m1e_act=' + DataSet.FieldByName('op_ea_metroac').AsString + ',';
    cSql_Ln := cSql_Ln + '  maqtc_m1e_ant=' + DataSet.FieldByName('op_ea_metroan').AsString + ',';
    cSql_Ln := cSql_Ln + '  maqtc_m2e_act=' + DataSet.FieldByName('op_eb_metroac').AsString + ',';
    cSql_Ln := cSql_Ln + '  maqtc_m2e_ant=' + DataSet.FieldByName('op_eb_metroan').AsString + ',';

    cSql_Ln := cSql_Ln + '  maqtc_m1s_act=' + DataSet.FieldByName('op_sa_metroac').AsString + ',';
    cSql_Ln := cSql_Ln + '  maqtc_m1s_ant=' + DataSet.FieldByName('op_sa_metroan').AsString + ',';
    cSql_Ln := cSql_Ln + '  maqtc_m2s_act=' + DataSet.FieldByName('op_sb_metroac').AsString + ',';
    cSql_Ln := cSql_Ln + '  maqtc_m2s_ant=' + DataSet.FieldByName('op_sb_metroan').AsString + ' ';
    cSql_Ln := cSql_Ln + 'WHERE   maqtc_chapa=' + QuotedStr(trim(DataSet.FieldByName('op_chapa').AsString));
    fUtilesV20.oPublicCnn.ExecSql(cSql_Ln);
  end;
end;

procedure TfCaptura1.otOp_ea_metroacClick(Sender: TObject);
begin
  self.otOp_ea_metroac.SelectAll;
end;

procedure TfCaptura1.otOp_ea_metroacExit(Sender: TObject);
begin
  self.Calc_Dif_Ent(true);
  self.Calc_Tot(1);
end;

procedure TfCaptura1.Mostrar_Baja_Prod;
begin
  if (self.oCk_Baja_Prod.Checked = true) then
  begin
    self.otOp_tot_colect.visible := false;

    self.otOp_tot_colect2.Width := self.otOp_tot_colect.Width;
    self.otOp_tot_colect2.Height := self.otOp_tot_colect.Height;
    self.otOp_tot_colect2.top := self.otOp_tot_colect.top;
    self.otOp_tot_colect2.left := self.otOp_tot_colect.left;
    self.otOp_tot_colect2.visible := true;

    self.otOp_tot_timbres.visible := false;
    self.olOp_tot_timbres.visible := false;

    self.otOp_tot_impmunic.visible := false;
    self.olOp_tot_impmunic.visible := false;

    self.otOp_tot_impjcj.visible := false;
    self.olOp_tot_impjcj.visible := false;

    self.otOp_tot_tec.visible := false;
    self.olOp_tot_tec.visible := false;

    self.otOp_tot_dev.visible := false;
    self.olOp_tot_dev.visible := false;

    self.otOp_tot_otros.visible := false;
    self.olOp_tot_otros.visible := false;

    self.otOp_tot_cred.visible := false;
    self.otOp_tot_cred2.Width := self.otOp_tot_cred.Width;
    self.otOp_tot_cred2.Height := self.otOp_tot_cred.Height;
    self.otOp_tot_cred2.top := self.otOp_tot_cred.top;
    self.otOp_tot_cred2.left := self.otOp_tot_cred.left;
    self.otOp_tot_cred2.visible := true;
  end
  else
  begin
    self.otOp_tot_colect2.visible := false;

    self.otOp_tot_colect.visible := true;
    self.olTot_Colectado.visible := true;

    self.otOp_tot_timbres.visible := true;
    self.olOp_tot_timbres.visible := true;

    self.otOp_tot_impmunic.visible := true;
    self.olOp_tot_impmunic.visible := true;

    self.otOp_tot_impjcj.visible := true;
    self.olOp_tot_impjcj.visible := true;

    self.otOp_tot_tec.visible := true;
    self.olOp_tot_tec.visible := true;

    self.otOp_tot_dev.visible := true;
    self.olOp_tot_dev.visible := true;

    self.otOp_tot_otros.visible := true;
    self.olOp_tot_otros.visible := true;

    self.otOp_tot_cred2.visible := false;

    self.otOp_tot_cred.visible := true;
    self.olTot_Credito.visible := true;
  end;
end;

procedure TfCaptura1.mask_fields(bEsEntrada: boolean = false; bDecimals: boolean = false);
begin
  if (bEsEntrada = true) then
  begin
    self.otOp_ea_metroac.DisplayFormat := fUtilesV20.iif(bDecimals = true, '#########0.00', '#########0');
    self.otOp_ea_metroac.DecimalPlaces := fUtilesV20.iif(bDecimals = true, 2, 0);
    self.otOp_ea_metroan.DisplayFormat := fUtilesV20.iif(bDecimals = true, '#########0.00', '#########0');
    self.otOp_ea_metroan.DecimalPlaces := fUtilesV20.iif(bDecimals = true, 2, 0);

    self.otOp_eb_metroac.DisplayFormat := fUtilesV20.iif(bDecimals = true, '#########0.00', '#########0');
    self.otOp_eb_metroac.DecimalPlaces := fUtilesV20.iif(bDecimals = true, 2, 0);
    self.otOp_eb_metroan.DisplayFormat := fUtilesV20.iif(bDecimals = true, '#########0.00', '#########0');
    self.otOp_eb_metroan.DecimalPlaces := fUtilesV20.iif(bDecimals = true, 2, 0);

    self.otop_e_pantalla.DisplayFormat := fUtilesV20.iif(bDecimals = true, '#########0.00', '#########0');
    self.otop_e_pantalla.DecimalPlaces := fUtilesV20.iif(bDecimals = true, 2, 0);

  end
  else
  begin
    self.otOp_sa_metroac.DisplayFormat := fUtilesV20.iif(bDecimals = true, '#########0.00', '#########0');
    self.otOp_sa_metroac.DecimalPlaces := fUtilesV20.iif(bDecimals = true, 2, 0);
    self.otOp_sa_metroan.DisplayFormat := fUtilesV20.iif(bDecimals = true, '#########0.00', '#########0');
    self.otOp_sa_metroan.DecimalPlaces := fUtilesV20.iif(bDecimals = true, 2, 0);

    self.otOp_sb_metroac.DisplayFormat := fUtilesV20.iif(bDecimals = true, '#########0.00', '#########0');
    self.otOp_sb_metroac.DecimalPlaces := fUtilesV20.iif(bDecimals = true, 2, 0);
    self.otOp_sb_metroan.DisplayFormat := fUtilesV20.iif(bDecimals = true, '#########0.00', '#########0');
    self.otOp_sb_metroan.DecimalPlaces := fUtilesV20.iif(bDecimals = true, 2, 0);

    self.otOp_s_pantalla.DisplayFormat := fUtilesV20.iif(bDecimals = true, '#########0.00', '#########0');
    self.otOp_s_pantalla.DecimalPlaces := fUtilesV20.iif(bDecimals = true, 2, 0);

  end;
end;

procedure TfCaptura1.Calc_Conses(iSkip: integer);
var
  fMonto_impu: extended;
  fMonto_Base: extended;
  fMonto_cons: extended;
begin
  if (self.bSkip_Conse = true) then
    exit;

  if ((self.otOperaciones.FieldByName('op_maq_proc_cons').AsSingle > 0) and (self.otOp_tot_colect.Value > 0)) then
  begin
    fMonto_impu := fUtilesV20.RoundD(self.otOp_tot_timbres.Value + self.otOp_tot_impmunic.Value + self.otOp_tot_impjcj.Value, 2);
    fMonto_Base := fUtilesV20.RoundD(self.otOp_tot_colect.Value - fMonto_impu, 2);
    fMonto_cons := fUtilesV20.RoundD(fMonto_Base * (otOperaciones.FieldByName('op_maq_proc_cons').AsSingle / 100), 2);

    otOperaciones.FieldByName('op_tot_porc_cons').AsSingle := fMonto_cons;
    self.bSkip_Conse := true
  end;
end;

end.
