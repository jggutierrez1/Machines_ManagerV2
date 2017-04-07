unit MaquinasTC;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask,
  ExtCtrls, ComCtrls, Buttons, GridsEh,
  DBGridEh, DB, DBCtrlsEh, PngBitBtn,
  PngSpeedButton, WideStrings, DBLookupEh, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, DBAxisGridsEh,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfMaquinasTC = class(TForm)
    oDBNav: TDBNavigator;
    PageControl1: TPageControl;
    oDS_Maquinas: TDataSource;
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
    Label16: TLabel;
    Label17: TLabel;
    oActivo: TDBCheckBox;
    oCodigo: TDBEdit;
    oChapa: TDBEdit;
    oID: TDBEdit;
    oFecha_Alta: TDBDateTimeEditEh;
    oFecha_Mof: TDBDateTimeEditEh;
    oDS_Denom: TDataSource;
    oDenom_E: TDBLookupComboboxEh;
    oDenom_S: TDBLookupComboboxEh;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    oModelo: TDBEdit;
    Label7: TLabel;
    DBGridEh1: TDBGridEh;
    oBtn_Denom: TPngSpeedButton;
    oMetros: TDBComboBox;
    oConection: TFDConnection;
    oMaquinaTC: TFDTable;
    oDenom: TFDTable;
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
    procedure oBtn_DenomClick(Sender: TObject);
    procedure oChapaKeyPress(Sender: TObject; var Key: Char);
    procedure oCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure oModeloKeyPress(Sender: TObject; var Key: Char);
    procedure oDenom_EKeyPress(Sender: TObject; var Key: Char);
    procedure oDenom_SKeyPress(Sender: TObject; var Key: Char);
    procedure oMetrosKeyPress(Sender: TObject; var Key: Char);
    procedure Activa_Objetos(bPar: boolean);
    procedure FormShow(Sender: TObject);
    procedure oCodigoExit(Sender: TObject);
    procedure ResizeKit1ExitResize(Sender: TObject; XScale, YScale: Double);
    procedure oMaquinaTCAfterPost(DataSet: TDataSet);
    procedure oMaquinaTCBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    // oObjRez: TReziseCntl;
  public
    { Public declarations }
  end;

var
  fMaquinasTC: TfMaquinasTC;

implementation

USES utilesV20, buscargen, Denominaciones;
{$R *.dfm}

procedure TfMaquinasTC.oMaquinaTCAfterPost(DataSet: TDataSet);
begin
  if futilesV20.isEmpty(DataSet.FieldByName('maqtc_modelo').AsString) then
  begin
    ShowMessage('Para crear un Máquina es necesario por lo menos el Modelo de la máquina');
    abort;
  end;
end;

procedure TfMaquinasTC.oMaquinaTCBeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('emp_id').Value := utilesV20.iId_Empresa;
  DataSet.FieldByName('maqtc_tipomaq').Value := 1;
  if DataSet.State = dsEdit then
  begin
    DataSet.FieldByName('u_usuario_modif').AsString := utilesV20.sUserName;
    DataSet.FieldByName('maqtc_fecha_modif').Value := now();
  end
  else if DataSet.State = dsInsert then
  begin
    DataSet.FieldByName('u_usuario_alta').AsString := utilesV20.sUserName;
    DataSet.FieldByName('maqtc_fecha_alta').Value := now();
  end;
end;

procedure TfMaquinasTC.FormCreate(Sender: TObject);
begin
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  // utiles.ResizeKit_DBGridEh_Prepare(self.DBGridEh1, oObjRez);
  freeandnil(oConection);
  self.PageControl1.ActivePageIndex := 0;
  self.oMaquinaTC.Connection := futilesV20.oPublicCnn;
  self.oDenom.Connection := futilesV20.oPublicCnn;

  self.oMaquinaTC.Filter := 'maqtc_tipomaq=1 and emp_id=' + IntToStr(utilesV20.iId_Empresa) + ' ';
  self.oMaquinaTC.Filtered := true;

  self.oDS_Denom.DataSet := oDenom;
  self.oDS_Denom.Enabled := true;
  self.oDenom.Active := true;

  self.oDS_Maquinas.DataSet := oMaquinaTC;
  self.oDS_Maquinas.Enabled := true;
  self.oMaquinaTC.Active := true;
end;

procedure TfMaquinasTC.FormShow(Sender: TObject);
begin
  self.Activa_Objetos(false);
end;

procedure TfMaquinasTC.oBtnAbortClick(Sender: TObject);
begin
  self.oMaquinaTC.Cancel;
  self.Action_Control(7);
  self.Activa_Objetos(false);
  self.oDenom.Filtered := false;
end;

procedure TfMaquinasTC.oBtnDeleteClick(Sender: TObject);
var
  nResp: integer;
begin
  if self.oMaquinaTC.isEmpty then
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

procedure TfMaquinasTC.oBtnEditClick(Sender: TObject);
begin
  if self.oMaquinaTC.isEmpty then
  begin
    self.Action_Control(6);
    exit;
  end;
  self.PageControl1.ActivePageIndex := 0;
  self.oMaquinaTC.Edit;
  self.Action_Control(2);
  self.Activa_Objetos(true);
  self.oCodigo.SetFocus;
end;

procedure TfMaquinasTC.oBtnExitClick(Sender: TObject);
begin
  self.close;
end;

procedure TfMaquinasTC.oBtnFindClick(Sender: TObject);
begin
  if self.oMaquinaTC.isEmpty then
  begin
    self.Action_Control(6);
    exit;
  end;
  self.Action_Control(4);
  Application.CreateForm(TFbuscargen, Fbuscargen);
  Fbuscargen.Hide;
  Fbuscargen.oSql1.Clear;
  Fbuscargen.oSql1.Lines.Add('SELECT maqtc_chapa,maqtc_modelo FROM maquinastc');
  Fbuscargen.oFieldName1.text := 'maqtc_chapa';
  Fbuscargen.oFieldName2.text := 'maqtc_modelo';
  Fbuscargen.oFieldCaption1.Caption := 'Código';
  Fbuscargen.oFieldCaption2.Caption := 'Nombre de la máquina';
  Fbuscargen.ShowModal;
  self.oDBNav.DataSource.DataSet.Locate('maqtc_chapa', buscargen.VAR01, []);
  Fbuscargen.free;
end;

procedure TfMaquinasTC.oBtnNewClick(Sender: TObject);
begin
  self.oDenom.Filtered := true;
  self.PageControl1.ActivePageIndex := 0;
  self.oMaquinaTC.Insert;
  self.Action_Control(1);
  self.Activa_Objetos(true);
  self.oMaquinaTC.FieldByName('maqtc_inactivo').AsInteger := 0;
  self.oMaquinaTC.FieldByName('maqtc_tipomaq').AsInteger := 1;
  self.oCodigo.SetFocus;
  self.oActivo.Checked := true;
end;

procedure TfMaquinasTC.oBtnPrintClick(Sender: TObject);
begin
  if self.oMaquinaTC.isEmpty then
  begin
    self.Action_Control(6);
    exit;
  end;
  self.Action_Control(5);
  ShowMessage('Opción aún no programada.');
end;

procedure TfMaquinasTC.oBtnSaveClick(Sender: TObject);
begin
  self.oMaquinaTC.post;
  self.Action_Control(6);
  self.Activa_Objetos(false);
  self.oDenom.Filtered := false;
end;

procedure TfMaquinasTC.oBtn_DenomClick(Sender: TObject);
begin
  Application.CreateForm(TfDenom, fDenom);
  fDenom.ShowModal;
  fDenom.free;
  self.oDenom.Refresh;
end;

procedure TfMaquinasTC.oChapaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfMaquinasTC.oCodigoExit(Sender: TObject);
var
  cChapa: string;
begin
  cChapa := self.oMaquinaTC.FieldByName('maqtc_chapa').AsString;
  if (futilesV20.isEmpty(cChapa) = true or (cChapa = '0')) then
    self.oMaquinaTC.FieldByName('maqtc_chapa').AsString := self.oCodigo.text;
end;

procedure TfMaquinasTC.oCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfMaquinasTC.oDenom_EKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfMaquinasTC.oDenom_SKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfMaquinasTC.oMetrosKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfMaquinasTC.oModeloKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfMaquinasTC.ResizeKit1ExitResize(Sender: TObject; XScale, YScale: Double);
begin
  // utiles.ResizeKit_DBGridEh(self.DBGridEh1, XScale, YScale, oObjRez);
end;

procedure TfMaquinasTC.Action_Control(pOption: integer);
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

    oMetros.Enabled := true;
    oDenom_E.Enabled := true;
    oDenom_S.Enabled := true;
    oBtn_Denom.Enabled := true;
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

    oMetros.Enabled := false;
    oDenom_E.Enabled := false;
    oDenom_S.Enabled := false;
    oBtn_Denom.Enabled := false;
  end;
end;

procedure TfMaquinasTC.Activa_Objetos(bPar: boolean);
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
    if (self.Components[i] is TDBLookupComboboxEh) then
      TDBLookupComboboxEh(self.Components[i]).Enabled := bPar;
    if (self.Components[i] is TDBCheckBoxEh) then
      TDBCheckBoxEh(self.Components[i]).Enabled := bPar;
    if (self.Components[i] is TDBCheckBox) then
      TDBCheckBox(self.Components[i]).Enabled := bPar;
    if (self.Components[i] is TPngSpeedButton) then
      TPngSpeedButton(self.Components[i]).Enabled := bPar;
  end;
  self.oID.Enabled := false;
end;

end.
