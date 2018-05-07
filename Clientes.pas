unit Clientes;

interface

uses
  Windows, Messages, SysUtils, FileCtrl,
  Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, DBCtrls,
  Mask, ExtCtrls, ComCtrls, Buttons,
  GridsEh, DBGridEh, DB, DBCtrlsEh,
  PngBitBtn, PngSpeedButton, WideStrings,
  SqlExpr, DBLookupEh,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait;

type
  TfClientes = class(TForm)
    oDBNav: TDBNavigator;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    oDS_Clientes: TDataSource;
    StatusBar1: TStatusBar;
    oActivo: TDBCheckBox;
    Label5: TLabel;
    Label3: TLabel;
    oNombreCom: TDBEdit;
    Label4: TLabel;
    TabSheet2: TTabSheet;
    oNombreLoc: TDBEdit;
    oTel1: TDBEdit;
    oTel2: TDBEdit;
    oFax: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    oDireccion: TDBMemo;
    oEmail: TDBEdit;
    Label12: TLabel;
    oBtnExit: TPngBitBtn;
    oBtnAbort: TPngBitBtn;
    oBtnSave: TPngBitBtn;
    oBtnFind: TPngBitBtn;
    oBtnDelete: TPngBitBtn;
    oBtnEdit: TPngBitBtn;
    oBtnNew: TPngBitBtn;
    oBtnPrint: TPngBitBtn;
    oID: TDBEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    Label13: TLabel;
    oWebPage: TDBEdit;
    Label14: TLabel;
    DBMemo1: TDBMemo;
    Label15: TLabel;
    Label16: TLabel;
    oFecha_Crea: TDBDateTimeEditEh;
    Label17: TLabel;
    oFecha_Mod: TDBDateTimeEditEh;
    GroupBox2: TGroupBox;
    Label18: TLabel;
    oPorc_Ret: TDBNumberEditEh;
    oDS_Municipios: TDataSource;
    Label19: TLabel;
    Label20: TLabel;
    oDS_Rutas: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    oCk_CteUnico: TDBCheckBox;
    oConection: TFDConnection;
    otClientes: TFDTable;
    otMunicipios: TFDTable;
    otRutas: TFDTable;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    oLst_Rutas: TDBLookupComboBox;
    oLst_Minucipio: TDBLookupComboBox;
    procedure Action_Control(pOption: integer);
    procedure oBtnNewClick(Sender: TObject);
    procedure oBtnEditClick(Sender: TObject);
    procedure oBtnDeleteClick(Sender: TObject);
    procedure oBtnFindClick(Sender: TObject);
    procedure oBtnPrintClick(Sender: TObject);
    procedure oBtnSaveClick(Sender: TObject);
    procedure oBtnAbortClick(Sender: TObject);
    procedure oBtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ZTable1AfterPost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure oNombreComKeyPress(Sender: TObject; var Key: Char);
    procedure oNombreLocKeyPress(Sender: TObject; var Key: Char);
    procedure oEmailKeyPress(Sender: TObject; var Key: Char);
    procedure oWebPageKeyPress(Sender: TObject; var Key: Char);
    procedure oTel1KeyPress(Sender: TObject; var Key: Char);
    procedure oTel2KeyPress(Sender: TObject; var Key: Char);
    procedure oFaxKeyPress(Sender: TObject; var Key: Char);
    procedure oIDKeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure oPorc_RetKeyPress(Sender: TObject; var Key: Char);
    procedure Activa_Objetos(bPar: boolean);
    procedure oNombreComExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure otClientesAfterInsert(DataSet: TDataSet);
    procedure otClientesBeforePost(DataSet: TDataSet);
    procedure oLst_RutasKeyPress(Sender: TObject; var Key: Char);
    procedure oLst_MinucipioKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fClientes: TfClientes;

implementation

USES UtilesV20, BuscarGenM2, Municipios, Rutas;
{$R *.dfm}

procedure TfClientes.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.DBEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.DBEdit3KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.DBEdit4KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.oWebPageKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.oPorc_RetKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.FormCreate(Sender: TObject);
begin
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  freeandnil(oConection);
  self.PageControl1.ActivePageIndex := 0;
  self.otClientes.Connection := fUtilesV20.oPublicCnn;
  self.otMunicipios.Connection := fUtilesV20.oPublicCnn;
  self.otRutas.Connection := fUtilesV20.oPublicCnn;
  self.oDS_Municipios.DataSet := otMunicipios;
  self.otMunicipios.Active := true;
  self.oDS_Clientes.DataSet := otClientes;
  self.oDS_Clientes.Enabled := true;
  self.otClientes.Active := true;

  self.oDS_Rutas.DataSet := otRutas;
  self.oDS_Rutas.Enabled := true;
  self.otRutas.Active := true;

  self.otMunicipios.Active := true;
  self.oCk_CteUnico.Caption := 'Cliente Único de: ' + fUtilesV20.query_selectgen_result
    ('SELECT emp_descripcion FROM empresas WHERE emp_id="' + IntToStr(UtilesV20.iId_Empresa) + '"');
  { self.otClientes.Filter := 'cte_emp_id="' + IntToStr(utiles.iId_Empresa) + '" ';
    self.otClientes.Filtered := true;
  }
end;

procedure TfClientes.FormShow(Sender: TObject);
begin
  self.PageControl1.ActivePageIndex := 0;
  self.Action_Control(6);
  self.Activa_Objetos(false);
end;

procedure TfClientes.oBtnAbortClick(Sender: TObject);
begin
  self.otClientes.Cancel;
  self.Action_Control(7);
  self.Activa_Objetos(false);
  self.PageControl1.ActivePageIndex := 0;
end;

procedure TfClientes.oBtnDeleteClick(Sender: TObject);
var
  nResp: integer;
begin
  if self.otClientes.isEmpty then
  begin
    self.Action_Control(6);
    exit;
  end;
  self.Action_Control(3);
  nResp := MessageDlg('Seguro que desea borrar eliminar el registro alctual?', mtConfirmation, [mbYes, mbNo], 0);
  If (nResp = mrYes) Then
  begin
    self.oDBNav.DataSource.DataSet.Delete;
    self.oDBNav.DataSource.DataSet.Refresh;
  end;

end;

procedure TfClientes.oBtnEditClick(Sender: TObject);
begin
  if self.otClientes.isEmpty then
  begin
    self.Action_Control(6);
    exit;
  end;
  self.PageControl1.ActivePageIndex := 0;
  self.otClientes.Edit;
  self.Action_Control(2);
  self.Activa_Objetos(true);
  self.oNombreCom.SetFocus;
end;

procedure TfClientes.oBtnExitClick(Sender: TObject);
begin
  self.close;
end;

procedure TfClientes.oBtnFindClick(Sender: TObject);
begin
  self.Action_Control(4);

  Application.CreateForm(TfBuscarGenM2, fBuscarGenM2);
  fBuscarGenM2.Hide;
  fBuscarGenM2.oLst_campos.Clear;

  BuscarGenM2.oListData[1].Texto := 'Código';
  BuscarGenM2.oListData[1].Campo := 'cte_id';
  BuscarGenM2.oListData[1].LLave := true;

  BuscarGenM2.oListData[2].Texto := 'Nombre Comercial';
  BuscarGenM2.oListData[2].Campo := 'cte_nombre_com';
  BuscarGenM2.oListData[2].LLave := false;

  BuscarGenM2.oListData[3].Texto := 'Nombre Fiscal';
  BuscarGenM2.oListData[3].Campo := 'cte_nombre_loc';
  BuscarGenM2.oListData[3].LLave := false;

  fBuscarGenM2.oSql1.Clear;
  fBuscarGenM2.oSql1.Lines.Add
    ('SELECT cte_id,UCASE(cte_nombre_com) as cte_nombre_com,UCASE(cte_nombre_loc) as cte_nombre_loc FROM clientes WHERE 1=1 ');
  fBuscarGenM2.ShowModal;
  if BuscarGenM2.vFindResult <> '' then
    self.oDBNav.DataSource.DataSet.Locate('cte_id', BuscarGenM2.vFindResult, []);
  freeandnil(fBuscarGenM2);
end;

procedure TfClientes.oBtnNewClick(Sender: TObject);
begin
  self.PageControl1.ActivePageIndex := 0;
  self.otClientes.Insert;
  self.oActivo.Checked := true;
  self.Action_Control(1);
  self.Activa_Objetos(true);
  self.otClientes.FieldByName('cte_inactivo').Value := 0;
  self.otClientes.FieldByName('cte_emp_id').AsInteger := UtilesV20.iId_Empresa;
  self.oLst_Minucipio.KeyValue := 1;
  self.oLst_Rutas.KeyValue := 1;
  self.oNombreCom.SetFocus;
end;

procedure TfClientes.oBtnPrintClick(Sender: TObject);
begin
  self.Action_Control(5);
  ShowMessage('Opción aún no programada.');
end;

procedure TfClientes.oBtnSaveClick(Sender: TObject);
begin
  self.otClientes.post;
  self.Action_Control(6);
  self.Activa_Objetos(false);
  self.PageControl1.ActivePageIndex := 0;
end;

procedure TfClientes.oEmailKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.oFaxKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.oIDKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.oLst_MinucipioKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.oLst_RutasKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.oNombreComExit(Sender: TObject);
begin
  if ((fUtilesV20.isEmpty(self.oNombreLoc.text) = true) or (self.oNombreLoc.text = null)) then
    self.otClientes.FieldByName('cte_nombre_loc').AsString := self.oNombreCom.text;
end;

procedure TfClientes.oNombreComKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.oNombreLocKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.otClientesAfterInsert(DataSet: TDataSet);
begin
  if (DataSet.State in [dsInsert]) then
  begin
    DataSet.FieldByName('cte_notas').Value := '';
    DataSet.FieldByName('cte_direccion').Value := '';
    DataSet.FieldByName('cte_inactivo').Value := 0;
    DataSet.FieldByName('cte_poc_ret').AsFloat := 50.00;
    DataSet.FieldByName('cte_pag_impm').Value := 0;
    DataSet.FieldByName('cte_pag_spac').Value := 0;
    DataSet.FieldByName('cte_pag_jcj').Value := 0;
    DataSet.FieldByName('cte_unico_emp').Value := 0;
  end;
end;

procedure TfClientes.otClientesBeforePost(DataSet: TDataSet);
begin
  if (DataSet.State in [dsEdit, dsInsert]) then
  begin
    if fUtilesV20.isEmpty(DataSet.FieldByName('cte_nombre_com').AsString) then
    begin
      ShowMessage('Para crear el cliente, es necesario por lo menos el nombre.');
      self.PageControl1.TabIndex := 0;
      self.oNombreCom.SetFocus;
      abort;
    end;

    if (DataSet.State = dsEdit) then
    begin
      DataSet.FieldByName('cte_fecha_modif').Value := now();
      DataSet.FieldByName('u_usuario_modif').Value := UtilesV20.sUserName;
    end
    else if (DataSet.State = dsInsert) then
    begin
      DataSet.FieldByName('cte_fecha_alta').Value := now();
      DataSet.FieldByName('u_usuario_alta').Value := UtilesV20.sUserName;
      DataSet.FieldByName('cte_fecha_Modif').AsDateTime := now();
      DataSet.FieldByName('u_usuario_modif').Value := UtilesV20.sUserName;
    end;
    if DataSet.FieldByName('cte_unico_emp').Value = 1 then
      DataSet.FieldByName('cte_emp_id').AsInteger := UtilesV20.iId_Empresa
    else
      DataSet.FieldByName('cte_emp_id').AsInteger := 0;
  end;
end;

procedure TfClientes.oTel1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.oTel2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfClientes.ZTable1AfterPost(DataSet: TDataSet);
begin
  if fUtilesV20.isEmpty(DataSet.FieldByName('cte_nombre_com').AsString) then
  begin
    ShowMessage('Para crear un cliente es necesario por lo menos el nombre del cliente.');
    abort;
  end;
end;

procedure TfClientes.Action_Control(pOption: integer);
begin
  if ((pOption = 1) or (pOption = 2)) then
  begin
    oDBNav.Visible := false;
    oBtnNew.Visible := false;
    oBtnEdit.Visible := false;
    oBtnDelete.Visible := false;
    oBtnFind.Visible := false;
    oBtnPrint.Visible := false;
    oBtnExit.Enabled := false;

    oBtnSave.Top := oBtnNew.Top;
    oBtnSave.Left := oBtnNew.Left;

    oBtnAbort.Top := oBtnEdit.Top;
    oBtnAbort.Left := oBtnEdit.Left;

    oBtnAbort.Visible := true;
    oBtnSave.Visible := true;
    oBtnExit.Visible := false;

  end;

  if ((pOption = 6) or (pOption = 7)) then
  begin
    oDBNav.Visible := true;
    oBtnNew.Visible := true;
    oBtnEdit.Visible := true;
    oBtnDelete.Visible := true;
    oBtnFind.Visible := true;
    oBtnPrint.Visible := false;
    oBtnExit.Enabled := true;
    oBtnSave.Top := oBtnNew.Top;
    oBtnSave.Left := oBtnNew.Left;

    oBtnAbort.Top := oBtnEdit.Top;
    oBtnAbort.Left := oBtnEdit.Left;

    oBtnAbort.Visible := false;
    oBtnSave.Visible := false;
    oBtnExit.Visible := true;

  end;

end;

procedure TfClientes.Activa_Objetos(bPar: boolean);
var
  i: Word;
begin
  for i := 0 to self.ComponentCount - 1 do
  begin
    if (self.Components[i] is TDBEdit) then
      TDBEdit(self.Components[i]).Enabled := bPar;
    if (self.Components[i] is TDBMemo) then
      TDBMemo(self.Components[i]).Enabled := bPar;
    if (self.Components[i] is TDBNumberEditEh) then
      TDBNumberEditEh(self.Components[i]).Enabled := bPar;
    if (self.Components[i] is TDBCheckBox) then
      TDBCheckBox(self.Components[i]).Enabled := bPar;
    if (self.Components[i] is TDBLookupComboBox) then
      TDBLookupComboBox(self.Components[i]).Enabled := bPar;
    if (self.Components[i] is TBitBtn) then
    begin
      if TBitBtn(self.Components[i]).tag = 20 then
        TBitBtn(self.Components[i]).Enabled := bPar;
    end;
  end;
  self.oID.Enabled := false;
end;

procedure TfClientes.BitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TfMunicipios, fMunicipios);
  fMunicipios.ShowModal;
  fMunicipios.free;
  self.otMunicipios.Refresh;
end;

procedure TfClientes.BitBtn2Click(Sender: TObject);
begin
  Application.CreateForm(TfRutas, fRutas);
  fRutas.ShowModal;
  fRutas.free;
  self.otRutas.Refresh;
end;

end.
