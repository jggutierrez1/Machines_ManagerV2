unit Prov_Maq;

interface

uses
  Windows, Messages, SysUtils, FileCtrl,
  Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, DBCtrls,
  Mask, ExtCtrls, ComCtrls, Buttons, DB,
  PngBitBtn, PngSpeedButton, WideStrings,
  SqlExpr,
  DBGridEhGrouping, ToolCtrlsEh, GridsEh, DBGridEh, DBCtrlsEh, DBLookupEh, DynVarsEh, DBAxisGridsEh, DBGridEhToolCtrls,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait;

type
  TfProv_Maq = class(TForm)
    oDBNav: TDBNavigator;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    oDS_Maq_Prov: TDataSource;
    StatusBar1: TStatusBar;
    oProv_inactivo: TDBCheckBox;
    Label5: TLabel;
    Label3: TLabel;
    oProv_nombre: TDBEdit;
    TabSheet2: TTabSheet;
    oProv_telefono1: TDBEdit;
    oProv_telefono2: TDBEdit;
    oProv_Fax: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    oProv_direccion: TDBMemo;
    oProv_email: TDBEdit;
    Label12: TLabel;
    oBtnExit: TPngBitBtn;
    oBtnAbort: TPngBitBtn;
    oBtnSave: TPngBitBtn;
    oBtnFind: TPngBitBtn;
    oBtnDelete: TPngBitBtn;
    oBtnEdit: TPngBitBtn;
    oBtnNew: TPngBitBtn;
    oBtnPrint: TPngBitBtn;
    oProv_cod: TDBEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    oProv_contacto_movil: TDBEdit;
    oProv_contacto_email: TDBEdit;
    Label6: TLabel;
    oProv_webpage: TDBEdit;
    Label14: TLabel;
    oProv_notas: TDBMemo;
    Label15: TLabel;
    oConection: TFDConnection;
    otMaq_Prov: TFDTable;
    oProv_contacto_nom: TDBEdit;
    oProv_porc: TDBNumberEditEh;
    Label4: TLabel;
    oBtn_Actualzia: TBitBtn;
    TabSheet3: TTabSheet;
    DBEdit6: TDBEdit;
    Label33: TLabel;
    oFecha_Mof: TDBDateTimeEditEh;
    Label22: TLabel;
    DBEdit5: TDBEdit;
    Label32: TLabel;
    oFecha_Alta: TDBDateTimeEditEh;
    Label21: TLabel;
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
    procedure oProv_nombreKeyPress(Sender: TObject; var Key: Char);
    procedure oNombreLocKeyPress(Sender: TObject; var Key: Char);
    procedure oProv_emailKeyPress(Sender: TObject; var Key: Char);
    procedure oProv_webpageKeyPress(Sender: TObject; var Key: Char);
    procedure oProv_telefono1KeyPress(Sender: TObject; var Key: Char);
    procedure oProv_telefono2KeyPress(Sender: TObject; var Key: Char);
    procedure oProv_FaxKeyPress(Sender: TObject; var Key: Char);
    procedure oProv_codKeyPress(Sender: TObject; var Key: Char);
    procedure oProv_contacto_movilKeyPress(Sender: TObject; var Key: Char);
    procedure oProv_contacto_emailKeyPress(Sender: TObject; var Key: Char);
    procedure Activa_Objetos(bPar: boolean);
    procedure otMaq_ProvAfterInsert(DataSet: TDataSet);
    procedure otMaq_ProvBeforePost(DataSet: TDataSet);
    procedure oProv_porcKeyPress(Sender: TObject; var Key: Char);
    procedure oProv_contacto_nomKeyPress(Sender: TObject; var Key: Char);
    procedure oBtn_ActualziaClick(Sender: TObject);
  private
    { Private declarations }
    iOption: integer;
  public
    { Public declarations }
  end;

var
  fProv_Maq: TfProv_Maq;

implementation

USES UtilesV20, BuscarGenM2;
{$R *.dfm}

procedure TfProv_Maq.oProv_contacto_movilKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfProv_Maq.oProv_contacto_nomKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfProv_Maq.oProv_contacto_emailKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfProv_Maq.oProv_porcKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfProv_Maq.oProv_webpageKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfProv_Maq.FormCreate(Sender: TObject);
begin
  self.iOption := 0;
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  freeandnil(oConection);
  self.PageControl1.ActivePageIndex := 0;
  self.otMaq_Prov.Connection := fUtilesV20.oPublicCnn;
  self.oDS_Maq_Prov.DataSet := otMaq_Prov;
  self.oDS_Maq_Prov.Enabled := true;
  self.otMaq_Prov.Active := true;
end;

procedure TfProv_Maq.FormShow(Sender: TObject);
begin
  self.PageControl1.ActivePageIndex := 0;
  self.Action_Control(6);
  self.Activa_Objetos(false);
end;

procedure TfProv_Maq.oBtnAbortClick(Sender: TObject);
begin
  self.otMaq_Prov.Cancel;
  self.Action_Control(7);
  self.Activa_Objetos(false);
  self.PageControl1.ActivePageIndex := 0;
  self.iOption := 0;
end;

procedure TfProv_Maq.oBtnDeleteClick(Sender: TObject);
var
  nResp: integer;
begin
  if self.otMaq_Prov.isEmpty then
  begin
    self.Action_Control(6);
    exit;
  end;
  self.iOption := 3;
  self.Action_Control(3);
  nResp := MessageDlg('Seguro que desea borrar eliminar el registro alctual?', mtConfirmation, [mbYes, mbNo], 0);
  If (nResp = mrYes) Then
  begin
    self.oDBNav.DataSource.DataSet.Delete;
    self.oDBNav.DataSource.DataSet.Refresh;
  end;
  self.iOption := 0;
end;

procedure TfProv_Maq.oBtnEditClick(Sender: TObject);
begin
  if self.otMaq_Prov.isEmpty then
  begin
    self.Action_Control(6);
    exit;
  end;
  self.iOption := 2;
  self.PageControl1.ActivePageIndex := 0;
  self.otMaq_Prov.Edit;
  self.Action_Control(2);
  self.Activa_Objetos(true);
  self.oProv_nombre.SetFocus;
end;

procedure TfProv_Maq.oBtnExitClick(Sender: TObject);
begin
  self.close;
end;

procedure TfProv_Maq.oBtnFindClick(Sender: TObject);
begin
  self.Action_Control(4);

  Application.CreateForm(TfBuscarGenM2, fBuscarGenM2);
  fBuscarGenM2.Hide;
  fBuscarGenM2.oLst_campos.Clear;

  BuscarGenM2.oListData[1].Texto := 'C�digo';
  BuscarGenM2.oListData[1].Campo := 'prov_cod';
  BuscarGenM2.oListData[1].LLave := true;

  BuscarGenM2.oListData[2].Texto := 'Nombre';
  BuscarGenM2.oListData[2].Campo := 'prov_nombre';
  BuscarGenM2.oListData[2].LLave := false;

  fBuscarGenM2.oSql1.Clear;
  fBuscarGenM2.oSql1.Lines.Add('SELECT prov_cod,UCASE(prov_nombre) as prov_nombre FROM maquinas_prov WHERE 1=1 ');
  fBuscarGenM2.ShowModal;
  if BuscarGenM2.vFindResult <> '' then
    self.oDBNav.DataSource.DataSet.Locate('prov_cod', BuscarGenM2.vFindResult, []);
  freeandnil(fBuscarGenM2);
end;

procedure TfProv_Maq.oBtnNewClick(Sender: TObject);
VAR
  cNext: STRING;
begin
  self.iOption := 1;
  self.PageControl1.ActivePageIndex := 0;
  self.otMaq_Prov.Insert;
  self.oProv_inactivo.Checked := true;
  self.Action_Control(1);
  self.Activa_Objetos(true);
  self.otMaq_Prov.FieldByName('prov_inactivo').Value := 0;
  cNext := fUtilesV20.query_selectgen_result('SELECT IFNULL(corre_cli,0)+1 AS corre_cli FROM global LIMIT 1');
  self.otMaq_Prov.FieldByName('prov_cod').AsString := cNext;

  self.oProv_nombre.SetFocus;
end;

procedure TfProv_Maq.oBtnPrintClick(Sender: TObject);
begin
  self.Action_Control(5);
  ShowMessage('Opci�n a�n no programada.');
end;

procedure TfProv_Maq.oBtnSaveClick(Sender: TObject);
var
  cNext: string;
begin
  if (self.iOption = 1) then
  begin
    cNext := fUtilesV20.query_selectgen_result('SELECT IFNULL(corre_prov_maq,0)+1 AS corre_prov_maq FROM global LIMIT 1');
    self.otMaq_Prov.FieldByName('prov_cod').AsString := cNext;
    UtilesV20.Execute_SQL_Command('UPDATE global SET corre_prov_maq=IFNULL(corre_prov_maq,0)+1 WHERE 1=1');
  end;

  self.otMaq_Prov.post;
  self.Action_Control(6);
  self.Activa_Objetos(false);
  self.PageControl1.ActivePageIndex := 0;
  self.iOption := 0;
end;

procedure TfProv_Maq.oBtn_ActualziaClick(Sender: TObject);
Var
  cSql_Ln: string;
begin
  self.oBtn_Actualzia.Enabled := false;
  if (MessageDlg('DESEA REEMPLAZAR EL PORCENTAJE DE CONSESION EN TODAS LAS MAQUINA DE ESTE PROVEEDOR?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes) then
  begin
    cSql_Ln := '';
    cSql_Ln := cSql_Ln + 'UPDATE maquinastc ';
    cSql_Ln := cSql_Ln + '	SET maqtc_porc_conc=' + fUtilesV20.FloatToStr3(self.oProv_porc.Value, 2) + ' ';
    cSql_Ln := cSql_Ln + 'WHERE prov_cod="' + trim(self.oProv_cod.Text) + '"';
    UtilesV20.Execute_SQL_Command(cSql_Ln);
  end;
  self.oBtn_Actualzia.Enabled := true;
end;

procedure TfProv_Maq.oProv_emailKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfProv_Maq.oProv_FaxKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfProv_Maq.oProv_codKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfProv_Maq.oProv_nombreKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfProv_Maq.oNombreLocKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfProv_Maq.otMaq_ProvAfterInsert(DataSet: TDataSet);
begin
  if (DataSet.State in [dsInsert]) then
  begin
    DataSet.FieldByName('prov_notas').Value := '';
    DataSet.FieldByName('prov_direccion').Value := '';
    DataSet.FieldByName('prov_inactivo').Value := 0;

    DataSet.FieldByName('prov_contacto_nom').Value := '';
    DataSet.FieldByName('prov_contacto_nom').Value := '';
    DataSet.FieldByName('prov_contacto_email').Value := '';

    DataSet.FieldByName('prov_porc').AsFloat := 0.00;
  end;
end;

procedure TfProv_Maq.otMaq_ProvBeforePost(DataSet: TDataSet);
begin
  if (DataSet.State in [dsEdit, dsInsert]) then
  begin
    if fUtilesV20.isEmpty(DataSet.FieldByName('prov_nombre').AsString) then
    begin
      ShowMessage('Para crear el proveedor de m�quinas, es necesario por lo menos el nombre.');
      self.PageControl1.TabIndex := 0;
      self.oProv_nombre.SetFocus;
      abort;
    end;

    if (DataSet.State = dsEdit) then
    begin
      DataSet.FieldByName('prov_fecha_modif').Value := now();
      DataSet.FieldByName('prov_usuario_modif').Value := UtilesV20.sUserName;
    end
    else if (DataSet.State = dsInsert) then
    begin
      DataSet.FieldByName('prov_fecha_alta').Value := now();
      DataSet.FieldByName('prov_usuario_alta').Value := UtilesV20.sUserName;
      DataSet.FieldByName('prov_fecha_modif').AsDateTime := now();
      DataSet.FieldByName('prov_usuario_modif').Value := UtilesV20.sUserName;
    end;
  end;
end;

procedure TfProv_Maq.oProv_telefono1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfProv_Maq.oProv_telefono2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfProv_Maq.ZTable1AfterPost(DataSet: TDataSet);
begin
  if fUtilesV20.isEmpty(DataSet.FieldByName('oProv_nombre').AsString) then
  begin
    ShowMessage('Para crear un cliente es necesario por lo menos el nombre del proveedor.');
    abort;
  end;
end;

procedure TfProv_Maq.Action_Control(pOption: integer);
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

procedure TfProv_Maq.Activa_Objetos(bPar: boolean);
var
  i: Word;
  oComponents: TControl;
begin
  for i := 0 to self.ComponentCount - 1 do
  begin
    if (self.Components[i] is TDBEdit) then
    begin
      oComponents := TDBEdit(self.Components[i]);
      oComponents.Enabled := fUtilesV20.iif(oComponents.Tag = 3, false, fUtilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBMemo) then
    begin
      oComponents := TDBMemo(self.Components[i]);
      oComponents.Enabled := fUtilesV20.iif(oComponents.Tag = 3, false, fUtilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBNumberEditEh) then
    begin
      oComponents := TDBNumberEditEh(self.Components[i]);
      oComponents.Enabled := fUtilesV20.iif(oComponents.Tag = 3, false, fUtilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBLookupComboBox) then
    begin
      oComponents := TDBLookupComboBox(self.Components[i]);
      oComponents.Enabled := fUtilesV20.iif(oComponents.Tag = 3, false, fUtilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBCheckBox) then
    begin
      oComponents := TDBCheckBox(self.Components[i]);
      oComponents.Enabled := fUtilesV20.iif(oComponents.Tag = 3, false, fUtilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TPngSpeedButton) then
    begin
      oComponents := TPngSpeedButton(self.Components[i]);
      oComponents.Enabled := fUtilesV20.iif(oComponents.Tag = 3, false, fUtilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBComboBox) then
    begin
      oComponents := TDBComboBox(self.Components[i]);
      oComponents.Enabled := fUtilesV20.iif(oComponents.Tag = 3, false, fUtilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBComboBoxEh) then
    begin
      oComponents := TDBComboBoxEh(self.Components[i]);
      oComponents.Enabled := fUtilesV20.iif(oComponents.Tag = 3, false, fUtilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBDateTimeEditEh) then
    begin
      oComponents := TDBDateTimeEditEh(self.Components[i]);
      oComponents.Enabled := fUtilesV20.iif(oComponents.Tag = 3, false, fUtilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBLookupComboboxEh) then
    begin
      oComponents := TDBLookupComboboxEh(self.Components[i]);
      oComponents.Enabled := fUtilesV20.iif(oComponents.Tag = 3, false, fUtilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;

    if (self.Components[i] is TBitBtn) then
    begin
      oComponents := TBitBtn(self.Components[i]);
      if oComponents.Tag = 20 then
        oComponents.Enabled := bPar;
    end;
  end;
  self.oProv_cod.Enabled := false;
end;

end.
