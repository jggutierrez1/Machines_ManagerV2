unit usuarios;

interface

uses
  Windows, Messages, SysUtils, FileCtrl,
  Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, DBCtrls,
  Mask, ExtCtrls, ComCtrls, Buttons,
  GridsEh, DBGridEh, DB, DBCtrlsEh,
  PngBitBtn, DBLookupEh,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TFusuarios = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    oDS_Users: TDataSource;
    StatusBar1: TStatusBar;
    oBtnNew: TPngBitBtn;
    oBtnEdit: TPngBitBtn;
    oBtnDelete: TPngBitBtn;
    oBtnFind: TPngBitBtn;
    oBtnSave: TPngBitBtn;
    oBtnAbort: TPngBitBtn;
    oBtnExit: TPngBitBtn;
    oDBNav: TDBNavigator;
    Label5: TLabel;
    oCodigo: TDBEdit;
    Label3: TLabel;
    oDescripcion: TDBEdit;
    Label2: TLabel;
    oUsuario: TDBEditEh;
    Label4: TLabel;
    oClave_Nor: TEdit;
    oActivo: TDBCheckBox;
    oIsAdmin: TDBCheckBox;
    oClave_Enc: TDBEditEh;
    Label1: TLabel;
    oLst_emp: TDBLookupComboboxEh;
    oDs_Emp: TDataSource;
    oConection: TFDConnection;
    oEmpresa: TFDQuery;
    oTable_Users: TFDTable;
    procedure FormCreate(Sender: TObject);
    procedure Validarcodigo;
    procedure Enabled_objects(bApply: boolean = false);
    procedure Action_Control(pOption: integer);
    procedure oBtnNewClick(Sender: TObject);
    procedure oBtnEditClick(Sender: TObject);
    procedure oBtnDeleteClick(Sender: TObject);
    procedure oBtnFindClick(Sender: TObject);
    procedure oBtnExitClick(Sender: TObject);
    procedure oBtnSaveClick(Sender: TObject);
    procedure oBtnAbortClick(Sender: TObject);
    procedure oDS_UsersDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure oTable_UsersBeforePost(DataSet: TDataSet);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fusuarios: TFusuarios;
  VALCOD: string;

implementation

USES utilesV20, buscargen;
{$R *.dfm}

procedure TFusuarios.oTable_UsersBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsedit, dsinsert] then
  begin
    oTable_Users.FieldByName('u_clave').value :=
      futilesV20.Encrypt(trim(self.oClave_Nor.text));

    // oTable_Users.FieldByName('emp_id').value := utiles.iId_Empresa;
    if DataSet.State = dsedit then
    begin
      DataSet.FieldByName('u_usuario_modif').AsString := utilesV20.sUserName;
      DataSet.FieldByName('u_fecha_modif').value := now();
    end
    else if DataSet.State = dsinsert then
    begin
      DataSet.FieldByName('u_usuario_modif').AsString := utilesV20.sUserName;
      DataSet.FieldByName('u_usuario_alta').AsString := utilesV20.sUserName;
      DataSet.FieldByName('u_fecha_modif').value := now();
      DataSet.FieldByName('u_fecha_alta').value := now();
    end;
  end;
end;

procedure TFusuarios.FormActivate(Sender: TObject);
begin
  self.oClave_Enc.top := 160;
  self.oClave_Nor.top := 160;
end;

procedure TFusuarios.FormCreate(Sender: TObject);
begin
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  self.oTable_Users.Connection := futilesV20.oPublicCnn;
  self.oEmpresa.Connection := futilesV20.oPublicCnn;
  self.oTable_Users.open;
  self.oEmpresa.close;
  self.oEmpresa.open;
  // oDS_Users.DataSet:=self.oTable_Users;
  self.oDS_Users.Enabled := true;
  self.oDs_Emp.Enabled := true;

  self.oClave_Enc.top := 160;
  self.oClave_Nor.top := 160;
  self.oClave_Enc.Visible := true;
  self.oClave_Nor.Visible := false;

end;

procedure TFusuarios.oBtnAbortClick(Sender: TObject);
begin
  self.oTable_Users.Cancel;
  self.Action_Control(7);
  self.oClave_Enc.Visible := true;
  self.oClave_Nor.Visible := false;
  self.Enabled_objects(false);
end;

procedure TFusuarios.oBtnDeleteClick(Sender: TObject);
var
  nResp: integer;
begin
  self.Action_Control(3);
  if futilesV20.isEmpty(oCodigo.text) = false then
  begin
    if (oTable_Users.FieldByName('u_Id').AsInteger = 1) then
      Application.MessageBox
        ('No es posible borra el usuario de sistema.', '', 0)
    else
    begin
      nResp := Application.MessageBox('Seguro desea borrar el usuario?', '',
        MB_YESNO);
      If (nResp = ID_YES) Then
      begin
        self.oTable_Users.Delete;
        self.oTable_Users.Refresh;
      end;
    end;
  end;
end;

procedure TFusuarios.oBtnEditClick(Sender: TObject);
var
  sClave: string;
begin
  self.oClave_Enc.top := 160;
  self.oClave_Nor.top := 160;
  self.oClave_Enc.Visible := false;
  self.oClave_Nor.Visible := true;

  self.PageControl1.ActivePageIndex := 0;
  self.oTable_Users.Edit;
  self.Action_Control(2);
  self.Enabled_objects(true);
  sClave := futilesV20.Decrypt(trim(oTable_Users.FieldByName('u_clave')
    .AsString));
  self.oClave_Nor.text := sClave;
  self.oDescripcion.SetFocus;
end;

procedure TFusuarios.oBtnExitClick(Sender: TObject);
begin
  self.close;
end;

procedure TFusuarios.oBtnFindClick(Sender: TObject);
begin
  self.Action_Control(4);
  Application.CreateForm(TFbuscargen, Fbuscargen);
  Fbuscargen.Hide;
  Fbuscargen.oSql1.Clear;
  Fbuscargen.oSql1.Lines.Add('SELECT u_Id,u_descripcion FROM usuarios');
  Fbuscargen.oFieldName1.text := 'u_Id';
  Fbuscargen.oFieldName2.text := 'u_descripcion';
  Fbuscargen.oFieldCaption1.Caption := 'Código';
  Fbuscargen.oFieldCaption2.Caption := 'Nombre del usuario';
  Fbuscargen.ShowModal;
  self.oTable_Users.Locate('u_Id', buscargen.VAR01, []);
  Fbuscargen.Free;
end;

procedure TFusuarios.oBtnNewClick(Sender: TObject);
begin
  self.oClave_Enc.top := 160;
  self.oClave_Nor.top := 160;

  self.oClave_Nor.text := '';

  self.oClave_Enc.Visible := false;
  self.oClave_Nor.Visible := true;

  self.PageControl1.ActivePageIndex := 0;
  self.oTable_Users.Insert;
  self.Enabled_objects(true);
  self.oActivo.Checked := true;
  self.Action_Control(1);
  self.oDescripcion.SetFocus;
  oTable_Users.FieldByName('u_activo').value := 1;
  oTable_Users.FieldByName('u_acceso1').value := 0;
end;

procedure TFusuarios.oBtnSaveClick(Sender: TObject);
begin
  if oTable_Users.State = dsinsert THEN
  begin
    self.Validarcodigo;
  end;
  if oTable_Users.State = dsedit THEN
  begin
    VALCOD := '';
  end;

  if self.oLst_emp.value = null then
  begin
    MessageDlg('Debe seleccionar una empresa predeterminada para el usuario.',
      mtWarning, [mbOK], 0);
    self.oLst_emp.SetFocus;
    exit;
  end;
  if trim(self.oLst_emp.value) = '' then
  begin
    MessageDlg('Debe seleccionar una empresa predeterminada para el usuario.',
      mtWarning, [mbOK], 0);
    self.oLst_emp.SetFocus;
    exit;
  end;

  if self.oUsuario.text = '' THEN
  begin
    MessageDlg('DEBE LLENAR LOS DATOS DE EL USUARIO.', mtWarning, [mbOK], 0);
    self.oUsuario.SetFocus;
    exit;
  end;

  if VALCOD <> '' THEN
  begin
    MessageBox(0, pchar('ESTE USUARIO YA EXISTE:  ' + VALCOD),
      pchar('INFORMACION'), MB_OK + MB_SYSTEMMODAL);
    exit;
  end
  else
  begin
    // oTable_Users.FieldByName('emp_id').value := utiles.iId_Empresa;
    oTable_Users.FieldByName('u_clave').AsString :=
      futilesV20.Encrypt(oClave_Nor.text);
    // oTable_Users.FieldByName('u_clave').AsString := trim(oClave.text);
    self.Enabled_objects(false);
  end;

  self.oTable_Users.Post;
  self.Action_Control(6);

  self.oClave_Enc.Visible := true;
  self.oClave_Nor.Visible := false;
  self.Enabled_objects(false);
end;

procedure TFusuarios.oDS_UsersDataChange(Sender: TObject; Field: TField);
begin
  // self.oClave.text := oTable_Users.FieldByName('u_clave').AsString;
end;

procedure TFusuarios.Validarcodigo;
var
  oquery: TFDQuery;
  sSql: string;
begin
  sSql := 'SELECT * FROM usuarios WHERE u_usuario="' +
    trim(self.oUsuario.text) + '" ';
  utilesV20.Exec_Select_SQL(oquery, sSql, true, true, false);
  VALCOD := oquery.Fields[0].text;
end;

procedure TFusuarios.Enabled_objects(bApply: boolean = false);
begin
  self.oCodigo.Enabled := bApply;
  self.oDescripcion.Enabled := bApply;
  self.oUsuario.Enabled := bApply;
  self.oClave_Nor.Enabled := bApply;
  self.oClave_Enc.Enabled := bApply;
  self.oActivo.Enabled := bApply;
  self.oIsAdmin.Enabled := bApply;
  self.oLst_emp.Enabled := bApply;

end;

procedure TFusuarios.Action_Control(pOption: integer);
begin
  if ((pOption = 1) or (pOption = 2)) then
  begin
    oDBNav.Visible := false;
    oBtnNew.Visible := false;
    oBtnEdit.Visible := false;
    oBtnDelete.Visible := false;
    oBtnFind.Visible := false;
    oBtnExit.Enabled := false;

    oBtnSave.top := oBtnNew.top;
    oBtnSave.Left := oBtnNew.Left;

    oBtnAbort.top := oBtnEdit.top;
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
    oBtnExit.Enabled := true;
    oBtnSave.top := oBtnNew.top;
    oBtnSave.Left := oBtnNew.Left;

    oBtnAbort.top := oBtnEdit.top;
    oBtnAbort.Left := oBtnEdit.Left;

    oBtnAbort.Visible := false;
    oBtnSave.Visible := false;
    oBtnExit.Visible := true;
  end;

end;

end.
