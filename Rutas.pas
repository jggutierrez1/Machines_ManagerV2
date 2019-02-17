unit Rutas;

interface

uses
  Windows, Messages, SysUtils, FileCtrl,
  Variants, Classes, Graphics, Controls,
  Forms, DBCtrls, Dialogs,
  StdCtrls, Mask, ExtCtrls, ComCtrls,
  Buttons, DB,
  ADODB, pngimage, PngBitBtn, PngSpeedButton,
  WideStrings,
  DBGridEhGrouping, ToolCtrlsEh, GridsEh, DBGridEh, DBCtrlsEh, DBLookupEh, DynVarsEh, DBAxisGridsEh, DBGridEhToolCtrls,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait;

type
  TfRutas = class(TForm)
    oDBNav: TDBNavigator;
    PageControl1: TPageControl;
    oDS_Rutas: TDataSource;
    StatusBar1: TStatusBar;
    oBtnExit: TPngBitBtn;
    oBtnAbort: TPngBitBtn;
    oBtnSave: TPngBitBtn;
    oBtnFind: TPngBitBtn;
    oBtnDelete: TPngBitBtn;
    oBtnEdit: TPngBitBtn;
    oBtnNew: TPngBitBtn;
    oBtnPrint: TPngBitBtn;
    TabSheet1: TTabSheet;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    oActivo: TDBCheckBox;
    oNombre: TDBEdit;
    oID: TDBEdit;
    oNotas: TDBMemo;
    oConection: TFDConnection;
    otRutas: TFDTable;
    TabSheet2: TTabSheet;
    Label17: TLabel;
    oFecha_Alta: TDBDateTimeEditEh;
    Label32: TLabel;
    DBEdit1: TDBEdit;
    Label19: TLabel;
    oFecha_Mof: TDBDateTimeEditEh;
    Label33: TLabel;
    DBEdit2: TDBEdit;
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
    procedure Activa_Objetos(bPar: boolean);
    procedure FormShow(Sender: TObject);
    procedure oNombreKeyPress(Sender: TObject; var Key: Char);
    procedure otRutasAfterInsert(DataSet: TDataSet);
    procedure otRutasBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fRutas: TfRutas;

implementation

USES utilesV20, BuscarGenM2;
{$R *.dfm}

procedure TfRutas.FormCreate(Sender: TObject);
begin
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  freeandnil(oConection);
  self.PageControl1.ActivePageIndex := 0;
  self.otRutas.Connection := futilesV20.oPublicCnn;
  self.otRutas.Active := true;
  self.oDS_Rutas.Enabled := true;
end;

procedure TfRutas.FormShow(Sender: TObject);
begin
  self.Activa_Objetos(false);
end;

procedure TfRutas.oBtnAbortClick(Sender: TObject);
begin
  self.otRutas.Cancel;
  self.Action_Control(7);
  self.Activa_Objetos(false);
end;

procedure TfRutas.oBtnDeleteClick(Sender: TObject);
var
  nResp: integer;
begin
  if self.otRutas.isEmpty then
  begin
    self.Action_Control(6);
    exit;
  end;
  self.Action_Control(3);
  nResp := Application.MessageBox('Seguro desea borrar?', '', MB_YESNO);
  If (nResp = ID_YES) Then
  begin
    self.oDBNav.DataSource.DataSet.Delete;
    self.oDBNav.DataSource.DataSet.Refresh;
  end;

end;

procedure TfRutas.oBtnEditClick(Sender: TObject);
begin
  if self.otRutas.isEmpty then
  begin
    self.Action_Control(6);
    exit;
  end;
  self.otRutas.Edit;
  self.Action_Control(2);
  self.Activa_Objetos(true);
end;

procedure TfRutas.oBtnExitClick(Sender: TObject);
begin
  self.close;
end;

procedure TfRutas.oBtnFindClick(Sender: TObject);
begin
  self.Action_Control(4);
  Application.CreateForm(TfBuscarGenM2, fBuscarGenM2);
  fBuscarGenM2.Hide;
  fBuscarGenM2.oLst_campos.Clear;

  BuscarGenM2.oListData[1].Texto := 'C�digo';
  BuscarGenM2.oListData[1].Campo := 'rut_id';
  BuscarGenM2.oListData[1].LLave := true;

  BuscarGenM2.oListData[2].Texto := 'Nombre de la Ruta';
  BuscarGenM2.oListData[2].Campo := 'rut_nombre';
  BuscarGenM2.oListData[2].LLave := false;

  fBuscarGenM2.oSql1.Clear;
  fBuscarGenM2.oSql1.Lines.Add('SELECT rut_id,UCASE(rut_nombre) as rut_nombre FROM rutas WHERE 1=1 ');
  fBuscarGenM2.ShowModal;
  if trim(BuscarGenM2.vFindResult) <> '' then
    self.oDBNav.DataSource.DataSet.Locate('rut_id', BuscarGenM2.vFindResult, []);
  freeandnil(fBuscarGenM2);
end;

procedure TfRutas.oBtnNewClick(Sender: TObject);
begin
  self.otRutas.Insert;
  self.Action_Control(1);
  self.Activa_Objetos(true);
  self.otRutas.FieldByName('rut_inactivo').Value := 0;
  self.oNombre.SetFocus;
end;

procedure TfRutas.oBtnPrintClick(Sender: TObject);
begin
  self.Action_Control(5);
  ShowMessage('Opci�n a�n no programada.');
end;

procedure TfRutas.oBtnSaveClick(Sender: TObject);
begin
  self.otRutas.Post;
  self.Action_Control(6);
  self.Activa_Objetos(false);
end;

procedure TfRutas.oNombreKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfRutas.otRutasAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('rut_inactivo').Value := 0;
  DataSet.FieldByName('rut_notas').AsString := ' ';
end;

procedure TfRutas.otRutasBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsEdit, dsInsert] then
  begin
    if futilesV20.isEmpty(DataSet.FieldByName('rut_nombre').AsString) then
    begin
      ShowMessage('Para crear una ruta es necesario por lo menos el nombre.');
      self.oNombre.SetFocus;
      abort;
    end;

    if DataSet.State = dsEdit then
    begin
      DataSet.FieldByName('u_usuario_modif').AsString := utilesV20.sUserName;
      DataSet.FieldByName('rut_fecha_modif').Value := now();
    end
    else if DataSet.State = dsInsert then
    begin
      DataSet.FieldByName('u_usuario_alta').AsString := utilesV20.sUserName;
      DataSet.FieldByName('rut_fecha_alta').Value := now();
    end;
  end;
end;

procedure TfRutas.Action_Control(pOption: integer);
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

procedure TfRutas.Activa_Objetos(bPar: boolean);
var
  i: Word;
  oComponents: TControl;
begin
  for i := 0 to self.ComponentCount - 1 do
  begin
    if (self.Components[i] is TDBEdit) then
    begin
      oComponents := TDBEdit(self.Components[i]);
      oComponents.Enabled := futilesV20.iif(oComponents.Tag = 3, false, futilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBMemo) then
    begin
      oComponents := TDBMemo(self.Components[i]);
      oComponents.Enabled := futilesV20.iif(oComponents.Tag = 3, false, futilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBNumberEditEh) then
    begin
      oComponents := TDBNumberEditEh(self.Components[i]);
      oComponents.Enabled := futilesV20.iif(oComponents.Tag = 3, false, futilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBLookupComboBox) then
    begin
      oComponents := TDBLookupComboBox(self.Components[i]);
      oComponents.Enabled := futilesV20.iif(oComponents.Tag = 3, false, futilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBCheckBox) then
    begin
      oComponents := TDBCheckBox(self.Components[i]);
      oComponents.Enabled := futilesV20.iif(oComponents.Tag = 3, false, futilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TPngSpeedButton) then
    begin
      oComponents := TPngSpeedButton(self.Components[i]);
      oComponents.Enabled := futilesV20.iif(oComponents.Tag = 3, false, futilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBComboBox) then
    begin
      oComponents := TDBComboBox(self.Components[i]);
      oComponents.Enabled := futilesV20.iif(oComponents.Tag = 3, false, futilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBComboBoxEh) then
    begin
      oComponents := TDBComboBoxEh(self.Components[i]);
      oComponents.Enabled := futilesV20.iif(oComponents.Tag = 3, false, futilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBDateTimeEditEh) then
    begin
      oComponents := TDBDateTimeEditEh(self.Components[i]);
      oComponents.Enabled := futilesV20.iif(oComponents.Tag = 3, false, futilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;
    if (self.Components[i] is TDBLookupComboboxEh) then
    begin
      oComponents := TDBLookupComboboxEh(self.Components[i]);
      oComponents.Enabled := futilesV20.iif(oComponents.Tag = 3, false, futilesV20.iif(oComponents.Tag = 1, not bPar, bPar));
    end;

    if (self.Components[i] is TBitBtn) then
    begin
      oComponents := TBitBtn(self.Components[i]);
      if oComponents.Tag = 20 then
        oComponents.Enabled := bPar;
    end;
  end;
  self.oID.Enabled := false;
end;

end.
