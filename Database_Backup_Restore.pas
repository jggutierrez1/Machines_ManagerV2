{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W+,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
unit Database_Backup_Restore;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,
  ExtCtrls, inifiles, shellapi, strutils,
  DB, ExtDlgs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IBBase, FireDAC.Phys.IB, FireDAC.Comp.Client,
  FireDAC.Comp.ScriptCommands, FireDAC.Comp.Script, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TfDatabase_Backup_Restore = class(TForm)
    tab: TPageControl;
    tabEjecutar: TTabSheet;
    tabConfiguracion: TTabSheet;
    gComando: TGroupBox;
    be: TStatusBar;
    tabRecuperar: TTabSheet;
    gComandoRes: TGroupBox;
    oBtn_Restore: TBitBtn;
    tabConf: TPageControl;
    tabConfCop: TTabSheet;
    tabConfRestaurar: TTabSheet;
    GroupBox2: TGroupBox;
    opOPT: TCheckBox;
    opSoloDefinicion: TCheckBox;
    opHexadecimal: TCheckBox;
    opInsertExtendidos: TCheckBox;
    GroupBox4: TGroupBox;
    opProcedimientos: TCheckBox;
    dlAbrir: TOpenTextFileDialog;
    dlGuardar: TSaveTextFileDialog;
    GroupBox1: TGroupBox;
    lbBD: TLabel;
    oList_Databases: TComboBox;
    GroupBox3: TGroupBox;
    Label8: TLabel;
    txtDestino: TEdit;
    bSelDestino: TButton;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    txtUsuario: TEdit;
    txtContrasena: TEdit;
    txtPuerto: TEdit;
    txtHost: TEdit;
    GroupBox7: TGroupBox;
    Label9: TLabel;
    txtBDRes: TEdit;
    GroupBox9: TGroupBox;
    Label12: TLabel;
    txtOrigen: TEdit;
    bSelOrigen: TButton;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    txtUsuarioRes: TEdit;
    txtContrasenaRes: TEdit;
    txtPuertoRes: TEdit;
    txtHostRes: TEdit;
    BitBtn1: TBitBtn;
    oMy_Dump: TMyDump;
    ProgressBarB: TProgressBar;
    olObj_Name: TLabel;
    oBtn_Backup: TBitBtn;
    oBtn_Salir1: TButton;
    oBtn_Salir2: TButton;
    oBtn_Config1: TBitBtn;
    oBtn_Config2: TBitBtn;
    ProgressBarR: TProgressBar;
    BitBtn2: TBitBtn;
    olStatus_Restore: TLabel;
    olStatus_Backup: TLabel;
    Label1: TLabel;
    oConnection: TFDConnection;
    oConn: TFDConnection;
    oBackup: TFDIBBackup;
    oScript1: TFDScript;
    oRestore: TFDIBRestore;
    procedure oBtn_BackupClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LWEBClick(Sender: TObject);
    procedure bSelDestinoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure oBtn_Salir1Click(Sender: TObject);
    procedure bSelOrigenClick(Sender: TObject);
    function LoadDatabaseInServer(pServer: string; var oCombo: TComboBox): boolean;
    procedure tabConfExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure oMy_DumpBackupProgress(Sender: TObject; ObjectName: string; ObjectNum, ObjectCount, Percent: Integer);
    procedure oMy_DumpRestoreProgress(Sender: TObject; Percent: Integer);
    procedure oBtn_RestoreClick(Sender: TObject);
    procedure oBtn_Config1Click(Sender: TObject);
    procedure oBtn_Config2Click(Sender: TObject);
    procedure Leer_Archvo_Ini;
    procedure Escribe_Archvo_Ini;
    procedure esCadINI(clave, cadena, valor: string);
    function leCadINI(clave, cadena: string; defecto: string): string;
    function leBoolINI(clave, cadena: string; defecto: boolean): boolean;
    procedure esBoolINI(clave, cadena: string; valor: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDatabase_Backup_Restore: TfDatabase_Backup_Restore;
  sDirRespal: string;
  bUseMySqlLocalDir: boolean = true;

implementation

uses UtilesV20, SplashForm;

{$R *.dfm}
// Lee un booleano de un INI

function TfDatabase_Backup_Restore.leBoolINI(clave, cadena: string; defecto: boolean): boolean;
begin
  with tinifile.create(changefileext(paramstr(0), '.INI')) do
    try
      result := readbool(clave, cadena, defecto);
    finally
      free;
    end;
end;

// Lee una cadena de texto de un INI

function TfDatabase_Backup_Restore.leCadINI(clave, cadena: string; defecto: string): string;
begin
  with tinifile.create(changefileext(paramstr(0), '.INI')) do
    try
      result := readString(clave, cadena, defecto);
    finally
      free;
    end;
end;

// escribe un Booleano en un INI

procedure TfDatabase_Backup_Restore.esBoolINI(clave, cadena: string; valor: boolean);
begin
  with tinifile.create(changefileext(paramstr(0), '.INI')) do
    try
      writeBool(clave, cadena, valor);
    finally
      free;
    end;
end;

// escribe una cadena de texto en un INI

procedure TfDatabase_Backup_Restore.esCadINI(clave, cadena, valor: string);
begin
  with tinifile.create(changefileext(paramstr(0), '.INI')) do
    try
      writeString(clave, cadena, valor);
    finally
      free;
    end;
end;

function IsWinNT: boolean;
var
  OSV: OSVERSIONINFO;
begin
  OSV.dwOSVersionInfoSize := sizeof(OSV);
  GetVersionEx(OSV);
  result := OSV.dwPlatformId = VER_PLATFORM_WIN32_NT;
end;

function buscarTexto(textoBuscar: string; textoCompleto: string): boolean;
var
  posicion: Integer;
begin
  result := false;
  posicion := Pos(AnsiUpperCase(textoBuscar), AnsiUpperCase(textoCompleto));
  if (posicion <> 0) then
  begin
    if (Length(textoCompleto) >= posicion + 1) then
    begin
      if (textoCompleto[posicion + Length(textoBuscar)] = ' ') then
        result := true
      else
        result := false;
    end
    else
      result := false;
  end;
end;

procedure insertarPATH(variable: string);
var
  pathOriginal: string;
begin
  // guardamos el valor de la variable path original
  pathOriginal := GetEnvironmentVariable(PCHar('PATH'));

  // añadimos el directorio actual a la variable PATH
  SetEnvironmentVariable(PCHar('PATH'), PCHar(pathOriginal + ';' + variable));

  // dejar valor anterior
  // SetEnvironmentVariable(PChar(variable),PChar(pathOriginal))
end;

procedure TfDatabase_Backup_Restore.oBtn_BackupClick(Sender: TObject);
begin
  if trim(self.txtDestino.Text) = '' then
  begin
    tabConfCop.Show;
    MessageDlg('Debe indicar una unidad, carpeta y fichero de destino ' + 'para la copia de seguridad.', mtInformation,
      [mbok], 0);
    txtDestino.SetFocus;
    exit;
  end;
  { --------------------------------------- }
  self.oList_Databases.Enabled := false;
  self.txtDestino.Enabled := false;
  self.bSelDestino.Enabled := false;
  { --------------------------------------- }

  self.oBtn_Backup.Enabled := false;
  self.oBtn_Config1.Enabled := false;

  self.olStatus_Backup.Caption := '';
  self.oMyConnection.server := trim(self.txtHost.Text);
  self.oMyConnection.port := StrToInt(trim(self.txtPuerto.Text));
  self.oMyConnection.Username := trim(self.txtUsuario.Text);
  self.oMyConnection.Password := trim(self.txtContrasena.Text);
  self.oMyConnection.Database := trim(self.oList_Databases.Text);
  self.oMyConnection.Connected := true;

  self.ProgressBarB.Position := 0;
  self.oMy_Dump.Objects := [];

  if opProcedimientos.Checked = true then
    self.oMy_Dump.Objects := self.oMy_Dump.Objects + [doStoredProcs];

  if self.opSoloDefinicion.Checked = false then
    self.oMy_Dump.Objects := self.oMy_Dump.Objects + [doData];

  self.oMy_Dump.Objects := self.oMy_Dump.Objects + [doDatabase];
  self.oMy_Dump.Objects := self.oMy_Dump.Objects + [doTables];
  self.oMy_Dump.Objects := self.oMy_Dump.Objects + [doViews];
  self.oMy_Dump.Objects := self.oMy_Dump.Objects + [doTriggers];
  self.oMy_Dump.Objects := self.oMy_Dump.Objects + [doUsers];

  if self.opOPT.Checked = true then
  begin
    self.oMy_Dump.Options.AddLock := true;
    self.oMy_Dump.Options.AddDrop := true;
    self.oMy_Dump.Options.DisableKeys := true;
  end
  else
  begin
    self.oMy_Dump.Options.AddLock := false;
    self.oMy_Dump.Options.AddDrop := false;
    self.oMy_Dump.Options.DisableKeys := false;
  end;

  self.oMy_Dump.Options.UseExtSyntax := true;
  self.oMy_Dump.Options.GenerateHeader := true;

  self.oMy_Dump.Options.CompleteInsert := self.opInsertExtendidos.Checked;
  self.oMy_Dump.Options.HexBlob := self.opHexadecimal.Checked;;
  self.oMy_Dump.Options.InsertType := itInsert;
  self.oMy_Dump.Options.QuoteNames := true;

  self.oMy_Dump.Connection := self.oMyConnection;
  self.oMy_Dump.SQL.Clear;
  self.oMy_Dump.TableNames := '';
  self.olStatus_Backup.Caption := 'REALIZANDO RESPALDO........';
  self.olStatus_Backup.Repaint;
  self.oMy_Dump.Backup;
  self.olStatus_Backup.Caption := 'GUARDANDO ARCHIVO DE RESPALDO...';
  self.olStatus_Backup.Repaint;
  self.oMy_Dump.SQL.SaveToFile(trim(self.txtDestino.Text));

  self.txtOrigen.Text := trim(self.txtDestino.Text);

  self.olStatus_Backup.Caption := 'RESPALDO FINALIZADO.';
  self.olStatus_Backup.Repaint;
  self.olStatus_Backup.Caption := '.';
  self.olObj_Name.Caption := '';
  ShowMessage('Proceso finalizado.');

  txtOrigen.Text := self.txtDestino.Text;

  self.txtDestino.Text := sDirRespal + '\BK_RCTECKDB_' + FormatDateTime('yyyy-mm-dd_HHmmss', now()) + '.SQL1';
  self.dlGuardar.FileName := self.txtDestino.Text;
  self.Escribe_Archvo_Ini;

  self.ProgressBarB.Position := 0;
  self.oBtn_Backup.Enabled := true;
  self.oBtn_Config1.Enabled := true;

  { --------------------------------------- }
  self.oList_Databases.Enabled := true;
  self.txtDestino.Enabled := true;
  self.bSelDestino.Enabled := true;
  { --------------------------------------- }
end;

procedure TfDatabase_Backup_Restore.oBtn_RestoreClick(Sender: TObject);
var
  cSql_Ln: string;
  iPos1, iPos2: Integer;
  cTmp_Str1, cTmp_Str2, cTmp_Str3: string;
  cDATABASE_FLE: string;
  cDATABASE_PUT: string;
begin
  if trim(self.txtDestino.Text) = '' then
  begin
    tabConfCop.Show;
    MessageDlg('Debe indicar una unidad, carpeta y fichero de destino ' + 'para la copia de seguridad.', mtInformation,
      [mbok], 0);
    txtDestino.SetFocus;
    exit;
  end;
  { ----------------------------------------------- }
  self.txtBDRes.Enabled := false;
  self.txtOrigen.Enabled := false;
  self.bSelOrigen.Enabled := false;
  { ----------------------------------------------- }

  self.oBtn_Restore.Enabled := false;
  self.oBtn_Config2.Enabled := false;

  self.olStatus_Restore.Caption := 'RESTAURANDO RESPALDO.';
  self.olStatus_Restore.Repaint;

  self.oConnection.Params.Clear;
  self.oConnection.Params.Add('DriverID=MySQL');
  self.oConnection.Params.Add('Server=' + trim(self.txtHostRes.Text));
  self.oConnection.Params.Add('Database=MySQL');
  self.oConnection.Params.Add('CharacterSet=utf8');
  self.oConnection.Params.Add('User_Name=' + trim(self.txtUsuarioRes.Text));
  self.oConnection.Params.Add('Password=' + trim(self.txtContrasenaRes.Text));
  self.oConnection.Params.Add('Port=' + trim(self.txtPuertoRes.Text));
  self.oConnection.LoginPrompt := false;
  self.oConnection.Connected := true;

  cSql_Ln := '';
  cSql_Ln := cSql_Ln + 'CREATE DATABASE IF NOT EXISTS `' + trim(self.txtBDRes.Text) + '`; ';
  cSql_Ln := cSql_Ln + 'ALTER DATABASE `' + trim(self.txtBDRes.Text) + '` COLLATE "utf8_general_ci"; ';
  self.oScript1.Connection := self.oMyConnection;
  self.oScript1.SQL.Text := cSql_Ln;
  self.oScript1.Execute;

  self.oConnection.Connected := false;
  self.oConnection.Params.Clear;
  self.oConnection.Params.Add('DriverID=MySQL');
  self.oConnection.Params.Add('Server=' + trim(self.txtHostRes.Text));
  self.oConnection.Params.Add('Database=' + trim(self.txtBDRes.Text));
  self.oConnection.Params.Add('CharacterSet=utf8');
  self.oConnection.Params.Add('User_Name=' + trim(self.txtUsuarioRes.Text));
  self.oConnection.Params.Add('Password=' + trim(self.txtContrasenaRes.Text));
  self.oConnection.Params.Add('Port=' + trim(self.txtPuertoRes.Text));
  self.oConnection.LoginPrompt := false;
  self.oConnection.Connected := true;

  self.ProgressBarR.Position := 0;
  self.olStatus_Restore.Caption := 'CARCANDO ARCHIVO DE RESPALDO...';
  self.olStatus_Restore.Repaint;

  self.oMy_Dump.Connection := self.oConnection;
  self.oMy_Dump.TableNames := '';
  self.oMy_Dump.SQL.Clear;
  fUtilesV20.WaitStart(self, 'Recuperando archivo de backup...');
  self.oMy_Dump.SQL.LoadFromFile(trim(self.txtOrigen.Text));

  iPos1 := PosEx('-- Database `', self.oMy_Dump.SQL.Text);
  cTmp_Str1 := copy(self.oMy_Dump.SQL.Text, iPos1, 80);
  cTmp_Str2 := copy(cTmp_Str1, PosEx('`', cTmp_Str1), Length(cTmp_Str1));
  cTmp_Str3 := copy(cTmp_Str2, 1, PosEx('`', cTmp_Str2, 2));
  cDATABASE_FLE := trim(cTmp_Str3);

  cDATABASE_PUT := trim(self.txtBDRes.Text);
  cDATABASE_PUT := StringReplace(cDATABASE_PUT, '`', '', [rfReplaceAll, rfIgnoreCase]);
  cDATABASE_PUT := '`' + trim(self.txtBDRes.Text) + '`';

  if cDATABASE_PUT <> '' then
  begin
    fUtilesV20.WaitSetMsg('ajustendo parámetro de BASE DE DATOS DESTINO...');
    self.oMy_Dump.SQL.Text := StringReplace(self.oMy_Dump.SQL.Text, cDATABASE_FLE, cDATABASE_PUT,
      [rfReplaceAll, rfIgnoreCase]);
  end;
  fUtilesV20.WaitEnd;

  self.ProgressBarR.Position := 0;
  self.olStatus_Restore.Caption := 'RESTAURANDO RESPALDO...';
  self.olStatus_Restore.Repaint;
  self.oMy_Dump.Restore;
  self.olStatus_Restore.Repaint;
  self.olStatus_Restore.Caption := 'PROCESO DE RESTAURACION FINALIZADO.';

  ShowMessage('Proceso finalizado.');
  self.ProgressBarR.Position := 0;
  self.oBtn_Restore.Enabled := true;
  self.oBtn_Config2.Enabled := true;

  { ----------------------------------------------- }
  self.txtBDRes.Enabled := true;
  self.txtOrigen.Enabled := true;
  self.bSelOrigen.Enabled := true;
  { ----------------------------------------------- }
end;

procedure TfDatabase_Backup_Restore.tabConfExit(Sender: TObject);
begin
  if tabConfiguracion.TabVisible = true then
    tabConfiguracion.TabVisible := false;
end;

procedure TfDatabase_Backup_Restore.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  self.Escribe_Archvo_Ini;
end;

procedure TfDatabase_Backup_Restore.FormCreate(Sender: TObject);
var
  sPathDest: string;
begin
  self.olObj_Name.Caption := '';
  self.tab.TabIndex := 0;
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  oList_Databases.Text := UtilesV20.oSetting_Fac.Database;
  txtUsuario.Text := UtilesV20.oSetting_Fac.usuario;
  txtContrasena.Text := UtilesV20.oSetting_Fac.clave;
  txtPuerto.Text := IntToStr(UtilesV20.oSetting_Fac.puerto);
  txtHost.Text := UtilesV20.oSetting_Fac.host;

  sDirRespal := ExtractFilePath(paramstr(0)) + 'Respaldos';
  if DirectoryExists(sDirRespal) = false then
  begin
    SysUtils.CreateDir(sDirRespal);
  end;
  FormatSettings.shortdateformat := 'dd-mm-yyyy';
  sPathDest := sDirRespal + '\BK_RCTECKDB_' + FormatDateTime('yyyy-mm-dd_HHmmss', now()) + '.SQL1';

  dlGuardar.FileName := sPathDest;
  // dlAbrir.FileName:=sPathDest;

  self.LoadDatabaseInServer(UtilesV20.oSetting_Fac.host, self.oList_Databases);
  self.Leer_Archvo_Ini;

  self.txtDestino.Text := sPathDest;

  self.tabConfiguracion.TabVisible := false;
  self.tabRecuperar.TabVisible := true;
end;

procedure TfDatabase_Backup_Restore.LWEBClick(Sender: TObject);
begin
  ShellExecute(Handle, nil, PCHar('www.rctech-soft.com/'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfDatabase_Backup_Restore.oMy_DumpBackupProgress(Sender: TObject; ObjectName: string;
  ObjectNum, ObjectCount, Percent: Integer);
begin
  if self.olObj_Name.Caption <> ObjectName then
  begin
    self.olObj_Name.Caption := trim(ObjectName);
    self.olObj_Name.Repaint;
  end;
  ProgressBarB.Position := Percent;
end;

procedure TfDatabase_Backup_Restore.oMy_DumpRestoreProgress(Sender: TObject; Percent: Integer);
begin
  self.ProgressBarR.Position := Percent;
end;

procedure TfDatabase_Backup_Restore.bSelDestinoClick(Sender: TObject);
var
  sDirRespal: string;
begin
  sDirRespal := ExtractFilePath(paramstr(0)) + 'Respaldos';
  dlGuardar.InitialDir := sDirRespal;
  if dlGuardar.Execute then
    txtDestino.Text := dlGuardar.FileName;
end;

procedure TfDatabase_Backup_Restore.FormShow(Sender: TObject);
begin
  self.oList_Databases.Text := UtilesV20.oSetting_Fac.Database;
end;

procedure TfDatabase_Backup_Restore.oBtn_Salir1Click(Sender: TObject);
begin
  close;
end;

procedure TfDatabase_Backup_Restore.oBtn_Config1Click(Sender: TObject);
begin
  self.tabConfiguracion.TabVisible := true;
  self.tabConfRestaurar.TabVisible := false;
  self.tabConfiguracion.Show;
  self.tabConfCop.TabVisible := true;
  self.tabConfCop.Show;
end;

procedure TfDatabase_Backup_Restore.oBtn_Config2Click(Sender: TObject);
begin
  self.tabConfiguracion.TabVisible := false;
  self.tabConfRestaurar.TabVisible := true;
  self.tabConfiguracion.Show;
  self.tabConfCop.TabVisible := true;
  self.tabConfCop.Show;
end;

procedure TfDatabase_Backup_Restore.BitBtn1Click(Sender: TObject);
begin
  if tabConfiguracion.TabVisible = true then
    tabConfiguracion.TabVisible := false;
  tabEjecutar.Show;

end;

procedure TfDatabase_Backup_Restore.BitBtn2Click(Sender: TObject);
begin
  if tabConfiguracion.TabVisible = true then
    tabConfiguracion.TabVisible := false;
  tabRecuperar.Show;
end;

procedure TfDatabase_Backup_Restore.bSelOrigenClick(Sender: TObject);
var
  sDirRespal: string;
begin
  sDirRespal := ExtractFilePath(paramstr(0)) + 'Respaldos';
  if DirectoryExists(sDirRespal) = false then
  begin
    SysUtils.CreateDir(sDirRespal);
  end;
  dlAbrir.InitialDir := sDirRespal;
  dlAbrir.DefaultExt := '*.bk1';

  if dlAbrir.Execute then
    txtOrigen.Text := dlAbrir.FileName;
end;

function TfDatabase_Backup_Restore.LoadDatabaseInServer(pServer: string; var oCombo: TComboBox): boolean;
var
  oQuery1: TFDQuery;
  sText: string;
begin
  try

    self.oConn.Connected := false;
    self.oConn.Params.Clear;
    self.oConn.Params.Add('DriverID=MySQL');
    self.oConn.Params.Add('Server=' + trim(UtilesV20.oSetting_Fac.host));
    self.oConn.Params.Add('Database=mysql');
    self.oConn.Params.Add('CharacterSet=utf8');
    self.oConn.Params.Add('User_Name=' + trim(UtilesV20.oSetting_Fac.usuario));
    self.oConn.Params.Add('Password=' + trim(UtilesV20.oSetting_Fac.clave));
    self.oConn.Params.Add('Port=' + trim(IntToStr(UtilesV20.oSetting_Fac.puerto)));
    self.oConn.LoginPrompt := false;
    self.oConn.Connected := true;

    oCombo.Clear;
    oQuery1 := TFDQuery.create(nil);
    oQuery1.Connection := oConn;
    oQuery1.SQL.Text := 'SHOW DATABASES';
    oQuery1.Open;
    if oQuery1.Eof then
      exit;
    oCombo.Clear;
    oCombo.Items.Clear;
    while not oQuery1.Eof do
    begin
      sText := UpperCase(trim(oQuery1.Fieldbyname('database').Text));
      if not((sText = UpperCase('information_schema')) or (sText = UpperCase('mysql'))) then
        oCombo.Items.Add(sText);

      oQuery1.Next;
    end;
    oCombo.ItemIndex := 0;
    oQuery1.free;
    oConn.free;
    result := true;
  except
    on E: Exception do
    begin
      application.ShowException(E);
      result := false;
    end;
  end;
end;

procedure TfDatabase_Backup_Restore.Leer_Archvo_Ini;
begin
  self.oList_Databases.Text := self.leCadINI('Configuración', 'Bases de datos (catálogos) a copiar',
    trim(fUtilesV20.oPublicCnn.Params.Values['Database']));
  self.txtUsuario.Text := self.leCadINI('Datos acceso', 'Usuario', trim(fUtilesV20.oPublicCnn.Params.Values['User_Name']));
  self.txtContrasena.Text := self.leCadINI('Datos acceso', 'Contraseña', trim(fUtilesV20.oPublicCnn.Params.Values['Password']));
  self.txtHost.Text := self.leCadINI('Datos acceso', 'Host', trim(fUtilesV20.oPublicCnn.Params.Values['Server']));
  self.txtPuerto.Text := self.leCadINI('Datos acceso', 'Puerto', fUtilesV20.oPublicCnn.Params.Values['Port']);
  self.opOPT.Checked := self.leBoolINI('Configuración', 'OPT', true);
  self.opSoloDefinicion.Checked := self.leBoolINI('Configuración', 'Sólo definición', false);
  self.opHexadecimal.Checked := self.leBoolINI('Configuración', 'Hexadecimal', true);
  self.txtDestino.Text := self.leCadINI('Configuración', 'Destino',
    IncludeTrailingBackslash(ExtractFilePath(application.ExeName)) + 'copia_bd.sql');
  self.opProcedimientos.Checked := self.leBoolINI('Configuración', 'Procedures', true);
  self.opInsertExtendidos.Checked := self.leBoolINI('Configuración', 'Insert extendidos', false);

  self.txtBDRes.Text := self.leCadINI('Restauración', 'Catálogo', '');
  self.txtUsuarioRes.Text := self.leCadINI('Restauración', 'Usuario', trim(fUtilesV20.oPublicCnn.Params.Values['User_Name']));
  self.txtContrasenaRes.Text := self.leCadINI('Restauración', 'Contraseña', trim(fUtilesV20.oPublicCnn.Params.Values['Password']));
  self.txtHostRes.Text := self.leCadINI('Restauración', 'Host', trim(fUtilesV20.oPublicCnn.Params.Values['Server']));
  self.txtPuertoRes.Text := self.leCadINI('Restauración', 'Puerto', fUtilesV20.oPublicCnn.Params.Values['Port']);
  self.txtOrigen.Text := self.leCadINI('Restauración', 'Origen', trim(fUtilesV20.oPublicCnn.Params.Values['Database']));
end;

procedure TfDatabase_Backup_Restore.Escribe_Archvo_Ini;
begin
  self.esCadINI('Configuración', 'Bases de datos (catálogos) a copiar', oList_Databases.Text);
  self.esCadINI('Datos acceso', 'Usuario', txtUsuario.Text);
  self.esCadINI('Datos acceso', 'Contraseña', txtContrasena.Text);
  self.esCadINI('Datos acceso', 'Host', txtHost.Text);
  self.esCadINI('Datos acceso', 'Puerto', txtPuerto.Text);
  self.esBoolINI('Configuración', 'OPT', opOPT.Checked);
  self.esBoolINI('Configuración', 'Sólo definición', opSoloDefinicion.Checked);
  self.esBoolINI('Configuración', 'Hexadecimal', opHexadecimal.Checked);
  self.esCadINI('Configuración', 'Destino', txtDestino.Text);
  self.esBoolINI('Configuración', 'Procedures', opProcedimientos.Checked);
  self.esBoolINI('Configuración', 'Insert extendidos', opInsertExtendidos.Checked);

  self.esCadINI('Restauración', 'Catálogo', txtBDRes.Text);
  self.esCadINI('Restauración', 'Usuario', txtUsuarioRes.Text);
  self.esCadINI('Restauración', 'Contraseña', txtContrasenaRes.Text);
  self.esCadINI('Restauración', 'Host', txtHostRes.Text);
  self.esCadINI('Restauración', 'Puerto', txtPuertoRes.Text);
  self.esCadINI('Restauración', 'Origen', txtOrigen.Text);
end;

end.
