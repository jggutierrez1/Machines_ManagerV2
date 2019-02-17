unit UtilesV20;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls, System.win.Registry, Vcl.ExtActns,
  System.win.ComObj, System.inifiles, System.DateUtils, Winapi.ShellAPI,
  Winapi.WinSvc, Winapi.Winsock, Vcl.Grids, Winapi.WinSpool,
  Vcl.Printers, Vcl.FileCtrl, Vcl.DBCtrls, System.StrUtils,
  System.math, Data.win.ADODB,

  IdBaseComponent, IdEcho, DBCtrlsEh,
  GridsEh, DBGridEh,
  SplashForm,
  Base64,
  IdTCPConnection, IdTCPClient,
  IdFTP, IdIPWatch,
  networkFunctions,
  IdTelnet, IdUDPBase, IdUDPClient,
  // clMailMessage, clMC, clSMTP, clTcpClient, clSocket, clPOP3,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.ScriptCommands, FireDAC.Comp.Script, IdComponent,
  IdExplicitTLSClientServerBase, IdRawBase, IdRawClient, IdIcmpClient, FireDAC.VCLUI.Wait, FireDAC.VCLUI.Async,
  FireDAC.VCLUI.Error, FireDAC.VCLUI.Script, FireDAC.Comp.UI, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLite,
  FireDAC.Phys.MySQL, FireDAC.Stan.Util, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.SQLiteDef;

type
  Config2 = object
    nombre: string;
    host: string;
    usuario: string;
    clave: string;
    puerto: integer;
    database: string;
    Reportes: string;
    estado: string;
    protocol: string;
    SmtpSrvName: string;
    SmtpPort: integer;
    SmtpUser: string;
    SmtpPass: string;
    SmtpDebug: Boolean;
    SmtpAuthType: integer;
    SmtpSSL: integer;
    Origen_Email: string;
    Origen_Nombr: string;

    nAutoLogin: integer;
    nAutoStartE: integer;
    nAutoStartR: integer;
    cUsername: string;
    cPassword: string;
    cServerNa: string;
    ResizeScrn: integer;
    LicenseType: integer;
    Beep_Sound: integer;
    Beep_Frecu: integer;
    Beep_Durac: integer;
  end;

type
  THackAccess = class(TcustomDBGridEh)
  end;

type
  TReziseCntl = object
    nMAXCOL_DG: integer; // Maximum number of columns
    nMAXROW_DG: integer; // Maximum number of rows
    aOrg_Width_DG: array [0 .. 30] of integer;
    nOrg_Height_DG: integer;
  end;

type
  Column_Pos = object
    FieldName: string;
    FieldPos: integer;
  end;

type
  Merge_Fields = object
    Cte_Nombre: string;
    Cte_saldo: string;
    Cte_LimiteCR: string;
    Emp_Nombre: string;
    Emp_Tel1: string;
    Emp_Tel2: string;
    Emp_Fax1: string;
    Emp_Fax2: string;
    Emp_Email: string;
    Fecha_Hoy: string;
    Hora_Hoy: string;
  end;

type
  tGenericPrn = object
    Out_Opt: integer;
    cOp_id: string;
    cPrinterName: string;
    bDesign: Boolean;
    cTableName: string;
    oForm: Tform;
  end;

type
  TDateTimePart = (dtpHour, dtpMinute, dtpSecond, dtpMS, dtpDay, dtpMonth, dtpYear);

type
  TStringArray = array of string;

type
  TCorner = (cLeftTop, cLeftButton, cRightTop, cRightButton);

type
  TfUtilesV20 = class(Tform)
    oPub_Qry: TFDQuery;
    oPub_Scp: TFDScript;
    oPublicCnn: TFDConnection;
    oPub_Com: TFDCommand;
    oPublicCnnSQLL: TFDConnection;
    oPublicCnn_Tmp: TFDConnection;
    oIdFTP: TIdFTP;
    oIdIcmpClient: TIdIcmpClient;
    oIdTCPClient: TIdTCPClient;
    oIdIPWatch: TIdIPWatch;
    oPub_Qry2: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;

    procedure ProperCase(var oText: TDBEdit);
    procedure WriteToLog(const key: string; const level: integer; const description: string);
    procedure SaveFileFromString(const FileName: TFileName; const content: string);
    procedure CenterFormOverActive(AForm: Tform);
    procedure CenterForm(AForm: Tform);
    procedure Create_Collate_Tmp();
    procedure Delete_Collate_Tmp();
    procedure Create_Blank_Tables(sFilename: string);
    procedure ShellExecute_AndWait(FileName: string; Params: string);
    procedure LogToFile(const S, FileName: string);
    procedure MoveDBGridColumns(DBGrid: TDBGridEh; FromColumn, ToColumn: integer);
    procedure Delay(msecs: integer);
    function Carga_Setting_Conn2(): Boolean;
    function ValidEmail(email: string): Boolean;
    function GetAppVersion(): string;
    function CenterString(aStr: string; Len: integer): string;
    function CreateUniqueFileName(sPath: string): string;
    function delete_Files(sPath: string; sExten: string): Boolean;
    function PadL(ASource: string; ALimit: integer; APadChar: Char = ' '): string;
    function PadR(ASource: string; ALimit: integer; APadChar: Char = ' '): string;
    function MakeRNDString(Chars: string; Count: integer): string;
    function Decrypt(pr: string): string;
    function Encrypt(tr: string): string;
    function LoadFileToString(const FileName: string): widestring;
    procedure SaveStringToFile(const Path, Data: string);
    function LDOM(Date: TDateTime): TDateTime;
    function FDOM(Date: TDateTime): TDateTime;
    function CargarServidores(var pComboSrvs: TcomboBox): integer;
    function CargarServidoresActivos(var pComboSrvs: TcomboBox): integer;
    function CargarServidoresActivosEh(var pComboSrvs: TDBComboBoxEh): integer;
    function RandomWord(dictSize, lngStepSize, wordLen, minWordLen: integer): string;
    function RandomPassword(PLen: integer): string;
    function RemoveNonAlpha(srcStr: string): string;
    function isEmpty(S: variant): Boolean;
    function LlenarcbEmpresa(var pComboSrvs: TcomboBox): integer;
    function BuscarUsuario(var oQry1: TFDQuery; sUsuario: string; bCheckActive: Boolean = True): integer;
    function OpenSqlLite(): Boolean;
    function iif(Test: Boolean; TrueR, FalseR: variant): variant;
    function GetVersion(sFilename: string): string;
    function ConnectServer(pKey: string): Boolean;
    function GetSetting2(pClaveReg: string): Boolean;
    function SaveSetting2(pClaveReg: string): Boolean;
    function Add_query_in_Combo(pFieldText: string; pFieldKey: string; pSQL: string; var oCombo: TDBComboBoxEh): Boolean;
    function LoadDatabaseInServer(pServer: string; var oCombo: TcomboBox): Boolean;
    function GetWindowsDir: TFileName;
    function GetSystemDir: TFileName;
    function GetRegistryData(RootKey: HKEY; key, Value: string): variant;
    procedure SetRegistryData(RootKey: HKEY; key, Value: string; RegDataType: TRegDataType; Data: variant);
    function GetProgramFilesDir: TFileName;
    function BemaFI32INI(iRuta: integer = 1; iGetValue: integer = 0; sPort: string = ''): string;
    function RightStr(const Str: string; Size: Word): string;
    function MidStr(const Str: string; From, Size: Word): string;
    function LeftStr(const Str: string; Size: Word): string;
    function SetScreenResolution(Width, Height: integer): Longint;
    function TamanoFichero(sFileToExamine: string): Longword;
    function ServiceIsInstalled(nombre: string): Boolean;
    function ServiceisRunning(nombre: string): Boolean;
    function GetMysqlVariables(pVariable: string): string;
    function WinExecAndWait32(FileName: string; Visibility: integer): integer;
    function Win32CreateProcess(const FileName, Parameters: string; var ExitCode: DWORD; const Wait: DWORD = 0;
      const Hide: Boolean = False): Boolean;
    function Find_PrimaryKey(TableName: string): string;
    function Fields_Counts(Full_DB_Table_Name: string): integer;
    function Tables_Counts(DB_Name: string): integer;
    function FieldExists(field: string; Full_DB_Table_Name: string): Boolean;
    function FieldExists2(var field: string; Full_DB_Table_Name: string): Boolean;
    function TableExists(DBName: string; TableName: string): Boolean;
    function DatabaseExists(DBName: string): Boolean;
    function MysQL_Processing_DB(DBName: string): Boolean;
    function Replicate(Caracter: string; Quant: integer): string;
    function HexToString(S: string): string;
    function StringToHex(S: string): string;
    procedure SyncErrLog(const key: string; const level: integer; const description: string);
    procedure SyncSaveEnvList(cPath: string; cFileName: string = 'Index.txt'; cText: string = '');
    function DayOfYear(const Year, Month, Day: Word): integer;
    function LastDayInMonth(const Year, Month: Word): TDateTime;
    procedure FindAllFiles(const Path: string; Attr: integer; List: TStrings);
    function GetWindowsTempDirectory: string;
    function WaitEnd: Boolean;
    procedure WaitSetMsg(sMsg: string);
    function WaitStart(TheParent: TComponent; sMsg: string): Boolean;
    function UnformatNumber(Val: string): string;
    function IsNumber(const c: Char): Boolean;
    function RoundDn(X: Single): Single;
    function RoundUp(X: Single): Single;
    function Sgn(X: Single): integer;
    function DateTimeAdd(SrcDate: TDateTime; DatePart: TDateTimePart; DiffValue: integer): TDateTime;
    function EjecutarComando(comando: string): string;
    function InstallINF(const PathName: string; hParent: HWND): Boolean;
    procedure SetSystemEnvironmentVariable(const name, Value: string);
    function GetSystemEnvironmentVariable(const name: string): string;
    procedure SetUserEnvironmentVariable(const name, Value: string);
    function GetUserEnvironmentVariable(const name: string): string;
    function SetGlobalEnvironment(const name, Value: string; const User: Boolean = True): Boolean;
    function Set_Tmp_Database(): Boolean;
    function IsAdmin: Boolean;
    procedure TxtFile_Write_version(FileName: string; cFull_AppName: string);
    function IsStrANumber(const S: string): Boolean;
    function between(nval, nmin, nmax: Longint): Boolean;
    function strTran(cText, cfor, cwith: string): string;
    function TimeDiff(cTime_Ult: string; cTime_Ant: string): string;
    function SecsToTime(nSeconds: integer): string;
    function TimeToSecs(cTime: string): integer;
    function SecToTime(Sec: integer): string;
    function Operacion_Get_And_Update_Opid: string;
    function Get_Station_id: string;
    function Operacion_Get_And_Update_CargosId(nOption: integer; bAutoSave: Boolean = True): string;
    procedure GetDefault_Decinal_Thousand_Separator;
    procedure Set_Decinal_Thousand_Separator;
    function FloatToStr2(Value: extended): string;
    function RoundD(X: extended; d: integer): extended;
    function Inlist(aCadena: string; aLista: array of string): Boolean;
    function Ctrl_Resize: Boolean;
    procedure PrintLineToGeneric(const line: string);
    procedure PrintLineOnDotMatrix(cPrinterName: string; cDocName: string; cString: string; bDobleCarr: Boolean; bTest: Boolean = False);
    function CenterText(nWidth: integer; sText: string): string;
    function CadLongitudFija(cadena: string; longitud: integer; posicionIzquierda: Boolean; valorRelleno: string): string;
    function Get_Values3: Boolean;
    procedure QuitarEjecutarEnInicio(NombreEjecutable: string; SoloUnaVez, SoloUsuario: Boolean);
    procedure EjecutarEnInicio(NombrePrograma, NombreEjecutable: string; SoloUnaVez, SoloUsuario: Boolean);
    function SeEjecutaEnInicio(NombreEjecutable: string; SoloUnaVez, SoloUsuario: Boolean): Boolean;
    procedure Poner_Facil_De_Inicio_Windows(pCierraSession: Boolean = True);
    procedure ReiniciaWindows;
    procedure CierraSessionWindows;
    procedure OpcionesApagarWindows(Sender: TObject);
    function Strip(L, c: Char; Str: string): string;
    procedure DataRefresh(var oDataset: Tdataset; pfield_Name: string);
    procedure AppendCurrent(DataSet: Tdataset);
    procedure LoadStringGrid(StringGrid: TStringGrid; const FileName: TFileName);
    procedure SaveStringGrid(StringGrid: TStringGrid; const FileName: TFileName);
    function ReplaceDatePart(pDateTime: TDateTime; pDateReplace: TDateTime): TDateTime;
    function TimeToDateTime(pTime: Ttime): TDateTime;
    function esPrimo(X: integer): Boolean;
    function par(n: integer): Boolean;
    function Par2(Num: integer): Boolean;
    function GetProgramFilesDir2: string;
    function tiempo_Transcurrido(pStartTime: DWORD; pEndTime: DWORD): string;
    function MapNetworkDriveDLG(const handle: THandle; const uncPath: string): string;
    function Get_File_Size2(sFileToExamine: string): integer;
    function isValidPath(Value: string): Boolean;
    procedure FormTransparence(oForm: Tform; iLimit: integer = 0);
    procedure FormDegrade(oForm: Tform);
    function GetUNCName(const LocalPath: string): string;
    // function GetIPFromHost(var HostName, IPaddr, WSAErr: string): Boolean;
    function CornerForm(form: TCustomForm; corner: TCorner): Boolean;
    function Ftp_Is_Alive(cHost: string; cUsername: string = 'remoto'; cPassword: string = '1234'; nPort: integer = 21): Boolean;
    function Check_Host_IsAlive(cHost: string; nPort: integer): Boolean;
    procedure InitCheckConnection;
    procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
    function BuscarEstacion(sEstacion: string; bCheckActive: Boolean = True): string;
    function query_selectgen_result(text: string): string;
    function GetIPAddress(name: AnsiString): string;
    function GetIPFromHost(HostName: string): string;
    function GetComputerNetName: string;
    function removeLeadingZeros(const Value: string): string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fUtilesV20: TfUtilesV20;
  oFile: Tinifile;
  oSetting_Fac: Config2;
  oSetting_Fac2: Config2;
  oMerge_Fields: Merge_Fields;
  bConnectionOk: Boolean = False;
  bConnectionStringLoaded: Boolean = False;
  sDSNConnection: string;
  sUserName: string;
  sUserPass: string;
  sPathReports: string;
  iUserID: integer;
  sSlectedHost: string;
  iId_Empresa: integer;
  cDe_Empresa: String;
  cId_Estacion: string = '';
  bId_Estacion_Force: Boolean;
  iUser_Logged: integer = 0;
  cTMP_Database: string = 'tmp';
  WaitForm: Tform;
  WaitLabel: TLabel;
  var_finger: widestring;
  nAct_Finger: integer;
  cpDecimales: Char = '.';
  cpThousand: Char = ',';
  oExe_Cmd: TFDQuery;
  oExe_SQL: TFDQuery;
  CodigoSuc: string;
  TriggerOk: string;
  oQryFlds: TFDQuery;
  bProcBusy: Boolean;
  hMu: THandle;
  oImo_FactLine: tGenericPrn;
  IdIPWatch1: TIdIPWatch;

function TimeADD(cTime: string; nInterval: integer; nValue: integer): string; overload;
function TimeADD(TDateTime: TDateTime; nInterval: integer; nValue: integer): string; overload;
function FormatNumber(flt: Double; decimals: integer = 0; Thousands: Boolean = True): string; Overload;
function FormatNumber(int: Int64; Thousands: Boolean = True): string; Overload;
function FormatNumber(Str: string; Thousands: Boolean = True): string; Overload;
function fields_info(var oQryFlds: TFDQuery; field: string = '*'; DBName: string = ''; TableName: string = ''): Boolean; overload;
function fields_info(oConn_Tmp: TFDConnection; var oQryFlds: TFDQuery; field: string = '*'; DBName: string = ''; TableName: string = '')
  : Boolean; overload;

function Execute_SQL_Script(oConn_Tmp: TFDConnection; pScript: TStrings): Boolean; overload;
function Execute_SQL_Script(pScript: string): Boolean; Overload;
function Execute_SQL_Script(pScript: TStrings): Boolean; Overload;
function Execute_SQL_Command(pSQL: string): Boolean; Overload;
function Execute_SQL_Command(pScript: TStringList): Boolean; Overload;
function Execute_SQL_Command_Tmp(pSQL: string; oSetting_Tmp: Config2): Boolean; Overload;
function Execute_SQL_Command_Tmp(pSQL: string; oConn_Tmp: TFDConnection): Boolean; Overload;
function Execute_SQL_Command_Tmp(pScript: TStringList; oConn_Tmp: TFDConnection): Boolean; overload;
function Execute_SQL_Command_Tmp_Fle(pFilename: string; oConn_Tmp: TFDConnection): Boolean; overload;
function Exec_Select_SQL(var oQry: TFDQuery; sSql: string; oQryExec: Boolean = True; oQryCreate: Boolean = True;
  IsProcedure: Boolean = False; ExecNoOpen: Boolean = False): Boolean; overload;
function Exec_Select_SQL(var oQry: TFDQuery; sSql: TStringList; oQryExec: Boolean = False; oQryCreate: Boolean = True;
  IsProcedure: Boolean = False; ExecNoOpen: Boolean = False): Boolean; overload;
function Exec_Select_SQL(oConn_Tmp: TFDConnection; var oQry: TFDQuery; sSql: string; oQryExec: Boolean = False; oQryCreate: Boolean = True;
  IsProcedure: Boolean = False; ExecNoOpen: Boolean = False): Boolean; overload;
function Execute_SQL_Result(pSQL: string): string; overload;
function Execute_SQL_Result(oConn_Tmp: TFDConnection; pSQL: string): string; overload;
function Execute_SQL_Query(var oQry: TFDQuery; sSql: string; oQryExec: Boolean = False): Boolean; overload;
function Execute_SQL_Query(oConn_Tmp: TFDConnection; var oQry: TFDQuery; sSql: string; oQryExec: Boolean = False): Boolean; overload;
function Execute_SQL_Query(var oQry: TFDQuery; sSql: TStringList; oQryExec: Boolean = False): Boolean; overload;
function Is_Super_User(): Boolean;
function RepeatString(const S: string; Count: cardinal): string;
function CenterString(aStr: String; Len: integer): String;

implementation

{$R *.dfm}

function TfUtilesV20.ValidEmail(email: string): Boolean;
// Returns True if the email address is valid
// Author: Ernesto D'Spirito
const
  // Valid characters in an "atom"
  atom_chars = [#33 .. #255] - ['(', ')', '<', '>', '@', ',', ';', ':', '\', '/', '"', '.', '[', ']', #127];
  // Valid characters in a "quoted-string"
  quoted_string_chars = [#0 .. #255] - ['"', #13, '\'];
  // Valid characters in a subdomain
  letters = ['A' .. 'Z', 'a' .. 'z'];
  letters_digits = ['0' .. '9', 'A' .. 'Z', 'a' .. 'z'];
  subdomain_chars = ['-', '0' .. '9', 'A' .. 'Z', 'a' .. 'z'];
type
  States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR, STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN, STATE_SUBDOMAIN,
    STATE_HYPHEN);
var
  State: States;
  i, n, subdomains: integer;
  c: Char;
begin
  if (email = '') then
  begin
    Result := True;
    exit;
  end;

  State := STATE_BEGIN;
  n := Length(email);
  i := 1;
  subdomains := 1;
  while (i <= n) do
  begin
    c := email[i];
    case State of
      STATE_BEGIN:
        begin
          if c in atom_chars then
            State := STATE_ATOM
          else if c = '"' then
            State := STATE_QTEXT
          else
            break;
        end;
      STATE_ATOM:
        begin
          if c = '@' then
            State := STATE_EXPECTING_SUBDOMAIN
          else if c = '.' then
            State := STATE_LOCAL_PERIOD
          else if not(c in atom_chars) then
            break;
        end;
      STATE_QTEXT:
        begin
          if c = '\' then
            State := STATE_QCHAR
          else if c = '"' then
            State := STATE_QUOTE
          else if not(c in quoted_string_chars) then
            break;
        end;
      STATE_QCHAR:
        begin
          State := STATE_QTEXT;
        end;
      STATE_QUOTE:
        begin
          if c = '@' then
            State := STATE_EXPECTING_SUBDOMAIN
          else if c = '.' then
            State := STATE_LOCAL_PERIOD
          else
            break;
        end;
      STATE_LOCAL_PERIOD:
        begin
          if c in atom_chars then
            State := STATE_ATOM
          else if c = '"' then
            State := STATE_QTEXT
          else
            break;
        end;
      STATE_EXPECTING_SUBDOMAIN:
        begin
          if c in letters then
            State := STATE_SUBDOMAIN
          else
            break;
        end;
      STATE_SUBDOMAIN:
        begin
          if c = '.' then
          begin
            inc(subdomains);
            State := STATE_EXPECTING_SUBDOMAIN
          end
          else
          begin
            if c = '-' then
              State := STATE_HYPHEN
            else if not(c in letters_digits) then
              break;
          end;
        end;
      STATE_HYPHEN:
        if c in letters_digits then
          State := STATE_SUBDOMAIN
        else if c <> '-' then
          break;
    end;
    inc(i);
  end;
  if i <= n then
    Result := False
  else
    Result := ((State = STATE_SUBDOMAIN) and (subdomains >= 2));
end;

function TfUtilesV20.GetAppVersion(): string;
var
  Size, Size2: DWORD;
  Pt, Pt2: Pointer;
begin
  Size := GetFileVersionInfoSize(PChar(Application.ExeName), Size2);
  if Size > 0 then
  begin
    GetMem(Pt, Size);
    try
      GetFileVersionInfo(PChar(Application.ExeName), 0, Size, Pt);
      VerQueryValue(Pt, '\', Pt2, Size2);
      with TVSFixedFileInfo(Pt2^) do
      begin
        Result := IntToStr(HiWord(dwFileVersionMS)) + '.' + IntToStr(LoWord(dwFileVersionMS)) + '.' + IntToStr(HiWord(dwFileVersionLS)) +
          '.' + IntToStr(LoWord(dwFileVersionLS));
      end;
    finally
      FreeMem(Pt);
    end;
  end;
end;

function Exec_Select_SQL(var oQry: TFDQuery; sSql: TStringList; oQryExec: Boolean = False; oQryCreate: Boolean = True;
  IsProcedure: Boolean = False; ExecNoOpen: Boolean = False): Boolean; overload;
begin
  with fUtilesV20 do
  begin
    Result := False;
    fUtilesV20.Carga_Setting_Conn2();

    if oQryCreate = True then
      oQry := TFDQuery.Create(nil);

    if Check_Host_IsAlive(oPublicCnn.Params.Values['Server'], StrToInt(oPublicCnn.Params.Values['port'])) = False then
    begin
      Result := False;
      exit;
    end;

    oQry.Connection := oPublicCnn;
    oQry.close;
    oQry.SQL.Clear;
    oQry.SQL.text := sSql.text;
    // application.ProcessMessages;
    try
      if ExecNoOpen = True then
        oQry.ExecSQL
      else
      begin
        if (oQryExec = True) then
        begin
          oQry.Open;
          if oQry.eof = True then
            Result := False
          else
            Result := True;
        end;
      end;
    except
      on E: Exception do
      begin
        Result := False;
      end;
    end;
  end;
end;

function Exec_Select_SQL(oConn_Tmp: TFDConnection; var oQry: TFDQuery; sSql: string; oQryExec: Boolean = False; oQryCreate: Boolean = True;
  IsProcedure: Boolean = False; ExecNoOpen: Boolean = False): Boolean; overload;
begin
  with fUtilesV20 do
  begin
    Result := False;
    try
      if oQryCreate = True then
        oQry := TFDQuery.Create(nil);

      if Check_Host_IsAlive(oConn_Tmp.Params.Values['Server'], StrToInt(oConn_Tmp.Params.Values['Port'])) = False then
      begin
        Result := False;
        exit;
      end;

      oQry.Connection := oConn_Tmp;
      oQry.close;
      oQry.SQL.Clear;
      oQry.SQL.text := sSql;
      if ExecNoOpen = True then
        oQry.ExecSQL
      else
      begin
        if (oQryExec = True) then
        begin
          oQry.Open;
          if oQry.eof = True then
            Result := False
          else
            Result := True;
        end;
      end;
    except
      on E: Exception do
      begin
        Result := False;
      end;
    end;
  end;
end;

function Exec_Select_SQL(var oQry: TFDQuery; sSql: string; oQryExec: Boolean = True; oQryCreate: Boolean = True;
  IsProcedure: Boolean = False; ExecNoOpen: Boolean = False): Boolean; overload;
begin
  with fUtilesV20 do
  begin

    try
      Carga_Setting_Conn2();
      if oQryCreate = True then
        oQry := TFDQuery.Create(nil);

      if Check_Host_IsAlive(oPublicCnn.Params.Values['Server'], StrToInt(oPublicCnn.Params.Values['Port'])) = False then
      begin
        Result := False;
        exit;
      end;

      oQry.Connection := oPublicCnn;
      oQry.close;
      oQry.SQL.Clear;
      oQry.SQL.text := sSql;
      if ExecNoOpen = True then
      begin
        oQry.ExecSQL;
        Exec_Select_SQL := True;
      end
      else
      begin
        if (oQryExec = True) then
        begin
          oQry.Open;
          if oQry.eof = True then
            Exec_Select_SQL := False
          else
            Exec_Select_SQL := True;
        end;
      end;
    except
      on E: Exception do
      begin
        Exec_Select_SQL := False;
      end;
    end;
  end;
end;

procedure TfUtilesV20.ProperCase(var oText: TDBEdit);
var
  GetString: string;
  GetLength: integer;
  i: integer;
  T: string;
begin
  if oText.SelLength > 0 then
    GetString := oText.Seltext
  else
    GetString := oText.text;
  GetLength := Length(GetString);
  if GetLength > 0 then
  begin
    for i := 0 to GetLength do
    begin
      if (GetString = ' ') or (i = 0) then
      begin
        if GetString[i + 1] in ['a' .. 'z'] then
        begin
          T := GetString[i + 1];
          T := UpperCase(T);
          GetString[i + 1] := T[1];
        end;
      end;
    end;
    if oText.SelLength > 0 then
      oText.Seltext := GetString
    else
      oText.text := GetString;
  end;
end;

function TfUtilesV20.CenterString(aStr: string; Len: integer): string;
var
  posStr: integer;
begin
  if Length(aStr) > Len then
    Result := Copy(aStr, 1, Len)
  else
  begin
    posStr := (Len - Length(aStr)) div 2;
    Result := Format('%*s', [Len, aStr + Format('%-*s', [posStr, ''])]);
  end;
end;

function TfUtilesV20.CreateUniqueFileName(sPath: string): string;
var
  chTemp: Char;
begin
  repeat
    Randomize;
    repeat
      chTemp := Chr(Random(43) + 47);
      if chTemp in ['0' .. '9', 'A' .. 'Z'] then
        Result := Result + chTemp;
    until Length(Result) = 12;
  until not FileExists(sPath + Result);
end;

function TfUtilesV20.delete_Files(sPath: string; sExten: string): Boolean;
var
  SearchRec: TSearchRec;
begin
  if (FindFirst(sPath + sExten, faAnyfile - faDirectory, SearchRec) = 0) then
  begin
    repeat
      DeleteFile(sPath + SearchRec.name);
    until (FindNext(SearchRec) <> 0);
    FindClose(SearchRec);
  end;
  Result := True;
end;

procedure TfUtilesV20.WriteToLog(const key: string; const level: integer; const description: string);
var
  DirectoryName: string;
  FileName: string;
  LogFile: textfile;
begin
  DirectoryName := ExcludeTrailingBackslash(ExtractFilePath(Application.ExeName)) + 'LOG';
  // Create directory, if necessary.
  if not DirectoryExists(DirectoryName) then
    ForceDirectories(DirectoryName);
  FileName := FormatDateTime('yyyymm', Now) + '.LOG';
  AssignFile(LogFile, DirectoryName + '\' + FileName);
  try
    if FileExists(DirectoryName + '\' + FileName) then
      Append(LogFile)
    else
      Rewrite(LogFile); // Create if new
    if level = 0 then
      WriteLn(LogFile) // blank line
    else
      WriteLn(LogFile, FormatDateTime('dd hh:nn:ss', Now), ' ', Format('%-16s', [key]), ' ', description);
    CloseFile(LogFile)
  except
    // Ignore exceptions while writing log files
  end;
end;

procedure TfUtilesV20.SyncErrLog(const key: string; const level: integer; const description: string);
var
  DirectoryName: string;
  FileName: string;
  LogFile: textfile;
begin
  DirectoryName := ExcludeTrailingBackslash(ExtractFilePath(Application.ExeName)) + 'LOG';
  // Create directory, if necessary.
  if not DirectoryExists(DirectoryName) then
    ForceDirectories(DirectoryName);
  FileName := FormatDateTime('yyyymm', Now) + '_ERR.LOG';
  AssignFile(LogFile, DirectoryName + '\' + FileName);
  try
    if FileExists(DirectoryName + '\' + FileName) then
      Append(LogFile) // If existing file
    else
      Rewrite(LogFile); // Create if new
    if level = 0 then
      WriteLn(LogFile) // blank line
    else
      WriteLn(LogFile, FormatDateTime('dd hh:nn:ss', Now), ' ', Format('%-16s', [key]), ' ', description);
    CloseFile(LogFile)
  except
    // Ignore exceptions while writing log files
  end;
end;

// EX: PadL('123', 5, '0') ==> 00123
function TfUtilesV20.PadL(ASource: string; ALimit: integer; APadChar: Char = ' '): string;
var
  i: integer;
begin
  Result := ASource;
  for i := 1 to ALimit - Length(Result) do
  begin
    Result := APadChar + Result;
  end;
end;

// EX: PadR('123', 5, '0') ==> 12300
function TfUtilesV20.PadR(ASource: string; ALimit: integer; APadChar: Char = ' '): string;
var
  i: integer;
begin
  Result := ASource;
  for i := 1 to ALimit - Length(Result) do
  begin
    Result := Result + APadChar;
  end;
end;

function TfUtilesV20.MakeRNDString(Chars: string; Count: integer): string;
var
  i, X: integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
  begin
    X := Length(Chars) - Random(Length(Chars));
    Result := Result + Chars[X];
    Chars := Copy(Chars, 1, X - 1) + Copy(Chars, X + 1, Length(Chars));
  end;
end;

function TfUtilesV20.Encrypt(tr: string): string;
begin
  Encrypt := Base64.Base64Encode(tr);
end;

function TfUtilesV20.Decrypt(pr: string): string;
begin
  Decrypt := Base64.Base64Decode(pr)
end;

function TfUtilesV20.LoadFileToString(const FileName: string): widestring;
var
  handle, Size: cardinal;
begin
  handle := CreateFile(PChar(FileName), GENERIC_READ, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if handle <> INVALID_HANDLE_VALUE then
    try
      Size := GetFileSize(handle, nil);
      SetLength(Result, integer(Size));
      ReadFile(handle, PChar(Result)^, Size, Size, nil);
    finally
      CloseHandle(handle);
    end
  else
    RaiseLastOSError;
end;

procedure TfUtilesV20.SaveFileFromString(const FileName: TFileName; const content: string);
{ Writing a file from a string }
begin
  with TFileStream.Create(FileName, fmCreate) do
    try
      Write(Pointer(content)^, Length(content));
    finally
      Free;
    end;
end;

function TfUtilesV20.FDOM(Date: TDateTime): TDateTime;
var
  wYear, wMonth, wDay: Word;
begin
  DecodeDate(Date, wYear, wMonth, wDay);
  Result := EncodeDate(wYear, wMonth, 1);
end;

function TfUtilesV20.LDOM(Date: TDateTime): TDateTime;
var
  wYear, wMonth, wDay: Word;
begin
  DecodeDate(Date, wYear, wMonth, wDay);
  // (if Month < 12 then inc(Month)
  // else begin Month := 1; inc(Year) end;
  // Result := EncodeDate(Year, Month, 1) - 1;
  Result := EncodeDate(wYear, wMonth, MonthDays[IsLeapYear(wYear), wMonth]);
end;

// ------------------------------------------------------------------------------------------//
function TfUtilesV20.CargarServidoresActivos(var pComboSrvs: TcomboBox): integer;
var
  oFileIni: Tinifile;
  sServerName: string;
  sConnStatus: string;
begin
  oFileIni := Tinifile.Create(ExtractFilePath(Application.ExeName) + 'Data\Config.ini');
  pComboSrvs.Clear;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion1', 'Desconocido1');
  if UpperCase(trim(sServerName)) <> UpperCase('Desconocido1') then
  begin
    sConnStatus := oFileIni.ReadString(sServerName, 'conectado', '');
    if UpperCase(trim(sConnStatus)) = UpperCase('Conexión Exitosa!!!!') then
      pComboSrvs.Items.Add(sServerName);
  end;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion2', 'Desconocido2');
  if UpperCase(trim(sServerName)) <> UpperCase('Desconocido2') then
  begin
    sConnStatus := oFileIni.ReadString(sServerName, 'conectado', '');
    if UpperCase(trim(sConnStatus)) = UpperCase('Conexión Exitosa!!!!') then
      pComboSrvs.Items.Add(sServerName);
  end;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion3', 'Desconocido3');
  if UpperCase(trim(sServerName)) <> UpperCase('Desconocido3') then
  begin
    sConnStatus := oFileIni.ReadString(sServerName, 'conectado', '');
    if UpperCase(trim(sConnStatus)) = UpperCase('Conexión Exitosa!!!!') then
      pComboSrvs.Items.Add(sServerName);
  end;

  oFileIni.Free;
  Result := pComboSrvs.Items.Count;
end;

function TfUtilesV20.CargarServidoresActivosEh(var pComboSrvs: TDBComboBoxEh): integer;
var
  oFileIni: Tinifile;
  sServerName: string;
  sConnStatus: string;
begin
  oFileIni := Tinifile.Create(ExtractFilePath(Application.ExeName) + 'Data\Config.ini');
  pComboSrvs.Clear;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion1', 'Desconocido1');
  if UpperCase(trim(sServerName)) <> UpperCase('Desconocido1') then
  begin
    sConnStatus := oFileIni.ReadString(sServerName, 'conectado', '');
    if UpperCase(trim(sConnStatus)) = UpperCase('Conexión Exitosa!!!!') then
      pComboSrvs.Items.Add(sServerName);
  end;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion2', 'Desconocido2');
  if UpperCase(trim(sServerName)) <> UpperCase('Desconocido2') then
  begin
    sConnStatus := oFileIni.ReadString(sServerName, 'conectado', '');
    if UpperCase(trim(sConnStatus)) = UpperCase('Conexión Exitosa!!!!') then
      pComboSrvs.Items.Add(sServerName);
  end;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion3', 'Desconocido3');
  if UpperCase(trim(sServerName)) <> UpperCase('Desconocido3') then
  begin
    sConnStatus := oFileIni.ReadString(sServerName, 'conectado', '');
    if UpperCase(trim(sConnStatus)) = UpperCase('Conexión Exitosa!!!!') then
      pComboSrvs.Items.Add(sServerName);
  end;

  oFileIni.Free;
  Result := pComboSrvs.Items.Count;
end;

function TfUtilesV20.CargarServidores(var pComboSrvs: TcomboBox): integer;
var
  oFileIni: Tinifile;
  sServerName: string;
begin
  oFileIni := Tinifile.Create(ExtractFilePath(Application.ExeName) + 'Data\Config.ini');
  pComboSrvs.Clear;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion1', 'Desconocido1');
  pComboSrvs.Items.Add(sServerName);

  sServerName := oFileIni.ReadString('servidores', 'Configuracion2', 'Desconocido2');
  pComboSrvs.Items.Add(sServerName);

  sServerName := oFileIni.ReadString('servidores', 'Configuracion3', 'Desconocido3');
  pComboSrvs.Items.Add(sServerName);

  oFileIni.Free;
  Result := pComboSrvs.Items.Count;
end;

function TfUtilesV20.Get_Values3: Boolean;
var
  otLocal_Config: TFDTable;
  bSqlLiteOk: Boolean;
begin
  bSqlLiteOk := self.OpenSqlLite();
  if (bSqlLiteOk = True) then
  begin
    otLocal_Config := TFDTable.Create(nil);
    otLocal_Config.Connection := self.oPublicCnnSQLL;
    otLocal_Config.TableName := 'local_conf';
    otLocal_Config.Active := True;
    if otLocal_Config.eof = True then
    begin
      oSetting_Fac.ResizeScrn := 0;
      oSetting_Fac.Beep_Sound := 0;
      oSetting_Fac.Beep_Frecu := 0;
      oSetting_Fac.Beep_Durac := 0;
    end
    else
    begin
      otLocal_Config.First;
      oSetting_Fac.ResizeScrn := otLocal_Config.FieldByName('ResizeScrn').AsInteger;
      oSetting_Fac.Beep_Sound := otLocal_Config.FieldByName('beep').AsInteger;
      oSetting_Fac.Beep_Frecu := otLocal_Config.FieldByName('beep_frec').AsInteger;
      oSetting_Fac.Beep_Durac := otLocal_Config.FieldByName('beep_durac').AsInteger;
    end;
    freeandnil(otLocal_Config);
    Result := True;
  end
  else
    Result := False;
end;

function TfUtilesV20.SaveSetting2(pClaveReg: string): Boolean;
var
  sPath: string;
  sPass: string;
  otMail_Config2: TFDTable;
  bSqlLiteOk: Boolean;
begin
  try
    bSqlLiteOk := self.OpenSqlLite();
    if (bSqlLiteOk = True) then
    begin
      otMail_Config2 := TFDTable.Create(nil);
      otMail_Config2.Connection := self.oPublicCnnSQLL;
      otMail_Config2.TableName := 'mail_config';
      otMail_Config2.Active := True;
    end;

    sPath := ExtractFilePath(Application.ExeName) + 'Data\Config.ini';
    oFile := Tinifile.Create(sPath);
    if trim(oSetting_Fac.clave) = '' then
      sPass := ''
    else
      sPass := oSetting_Fac.clave;
    // sPass := Encrypt(oSetting_Fac.clave)
    with oFile do
    begin
      writeString(pClaveReg, 'Nombre', trim(oSetting_Fac.nombre));

      if (UpperCase(trim(oSetting_Fac.estado)) <> UpperCase(trim('Conexión fallida!'))) then
        writeString('AUTOLOGIN', 'SERVIDOR', trim(oSetting_Fac.nombre));

      writeString(pClaveReg, 'Servidor', trim(oSetting_Fac.host));
      writeString(pClaveReg, 'Usuario', trim(oSetting_Fac.usuario));
      writeString(pClaveReg, 'Clave', sPass);
      WriteInteger(pClaveReg, 'Puerto', oSetting_Fac.puerto);
      writeString(pClaveReg, 'base', trim(oSetting_Fac.database));
      writeString(pClaveReg, 'rutarep', trim(oSetting_Fac.Reportes));
      writeString(pClaveReg, 'conectado', trim(oSetting_Fac.estado));
      writeString(pClaveReg, 'protocol', trim(oSetting_Fac.protocol));
      WriteInteger('use_key', 'LicenseType', oSetting_Fac.LicenseType);
    end;
    if (bSqlLiteOk = True) then
    begin
      if otMail_Config2.eof = True then
        otMail_Config2.Insert
      else
      begin
        otMail_Config2.First;
        otMail_Config2.Edit;
      end;
      otMail_Config2.FieldByName('smtp_server').AsString := trim(oSetting_Fac.SmtpSrvName);
      otMail_Config2.FieldByName('smtp_Port').AsInteger := Ord(oSetting_Fac.SmtpPort);
      otMail_Config2.FieldByName('smtp_user').AsString := trim(oSetting_Fac.SmtpUser);
      otMail_Config2.FieldByName('smtp_password').AsString := trim(oSetting_Fac.SmtpPass);
      otMail_Config2.FieldByName('smtp_Debug').AsInteger := Ord(oSetting_Fac.SmtpDebug);
      otMail_Config2.FieldByName('smtp_AuthType').AsInteger := Ord(oSetting_Fac.SmtpAuthType);
      otMail_Config2.FieldByName('smtp_ssl').AsInteger := Ord(oSetting_Fac.SmtpSSL);
      otMail_Config2.FieldByName('Ornanization_Mail').AsString := trim(oSetting_Fac.Origen_Email);
      otMail_Config2.FieldByName('Ornanization_Name').AsString := trim(oSetting_Fac.Origen_Nombr);
      otMail_Config2.Post;
      freeandnil(otMail_Config2);
    end;
    Result := True;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
  oFile.Free;
end;

function TfUtilesV20.GetSetting2(pClaveReg: string): Boolean;
var
  sTmpP: string;
  sPath: string;
  sFile: string;
  otMail_Config2: TFDTable;
begin
  try
    sPath := ExtractFilePath(Application.ExeName) + 'Data\';
    sFile := sPath + 'Config.ini';
    oFile := Tinifile.Create(sFile);
    with oSetting_Fac do
    begin
      sTmpP := oFile.ReadString(pClaveReg, 'clave', '');
      if trim(sTmpP) = '' then
        clave := ''
      else
        clave := sTmpP;
      // clave      := Decrypt(sTmpP)

      nombre := oFile.ReadString(pClaveReg, 'Nombre', 'SinNombre');
      host := oFile.ReadString(pClaveReg, 'Servidor', 'localhost');
      usuario := oFile.ReadString(pClaveReg, 'Usuario', 'root');
      puerto := oFile.ReadInteger(pClaveReg, 'puerto', Ord(3306));
      database := oFile.ReadString(pClaveReg, 'base', 'dbName');
      Reportes := oFile.ReadString(pClaveReg, 'reportes', sPath + 'Reportes');
      estado := oFile.ReadString(pClaveReg, 'conectado', 'Conexión fallida!');
      protocol := oFile.ReadString(pClaveReg, 'protocol', 'mysql-5');
      LicenseType := oFile.ReadInteger('use_key', 'LicenseType', 0);
    end;
    Result := True;
    sSlectedHost := pClaveReg;
  except
    Result := False;
    sSlectedHost := '';
  end;
  oFile.Free;
end;

function TfUtilesV20.Carga_Setting_Conn2(): Boolean;
begin
  try
    if (bConnectionOk = False) then
    begin
      self.oPublicCnn.Connected := False;
      self.oPublicCnn.Params.Clear;
      self.oPublicCnn.Params.Add('DriverID=MySQL');
      self.oPublicCnn.Params.Add('Server=' + oSetting_Fac.host);
      self.oPublicCnn.Params.Add('Database=' + oSetting_Fac.database);
      self.oPublicCnn.Params.Add('CharacterSet=utf8');
      self.oPublicCnn.Params.Add('User_Name=' + oSetting_Fac.usuario);
      self.oPublicCnn.Params.Add('Password=' + oSetting_Fac.clave);
      self.oPublicCnn.Params.Add('Port=' + IntToStr(oSetting_Fac.puerto));
      self.oPublicCnn.LoginPrompt := False;

      if self.Check_Host_IsAlive(oSetting_Fac.host, oSetting_Fac.puerto) = True then
        self.oPublicCnn.Connected := True
      else
      begin
        bConnectionOk := False;
        Result := False;
        exit;
      end;
    end;

    bConnectionOk := self.oPublicCnn.Connected;
    GetDefault_Decinal_Thousand_Separator;
    Result := self.oPublicCnn.Connected;
  except
    bConnectionOk := False;
    Result := bConnectionOk;
    exit;
  end;
end;

{ Example: label1.Caption := RandomPassword(10); }
function TfUtilesV20.RandomPassword(PLen: integer): string;
var
  Str: string;
  cResult: string;
begin
  Randomize;
  cResult := '';
  Str := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  repeat
    cResult := cResult + Str[Random(Length(Str)) + 1];
  until (Length(cResult) = PLen);
  Result := cResult;
end;

{ Caption := RandomWord(33, 54, Random(12), 2); }

function TfUtilesV20.RandomWord(dictSize, lngStepSize, wordLen, minWordLen: integer): string;
begin
  Result := '';
  if (wordLen < minWordLen) and (minWordLen > 0) then
    wordLen := minWordLen
  else if (wordLen < 1) and (minWordLen < 1) then
    wordLen := 1;
  repeat
    Result := Result + Chr(Random(dictSize) + lngStepSize);
  until (Length(Result) = wordLen);
end;

function TfUtilesV20.RemoveNonAlpha(srcStr: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to Length(srcStr) - 1 do
    if isCharAlpha(srcStr[i]) then
      Result := Result + srcStr[i];
end;

function TfUtilesV20.isEmpty(S: variant): Boolean;
var
  iTipo: integer;
label ComparaNumeros, ComparaCadenas;
begin
  if ((VarType(S) = varEmpty) or (VarType(S) = varNull)) then
  begin
    Result := True;
    exit;
  end;
  iTipo := VarType(S);
  case iTipo of
    varSmallInt:
      goto ComparaNumeros;
    varInteger:
      goto ComparaNumeros;
    varSingle:
      goto ComparaNumeros;
    varDouble:
      goto ComparaNumeros;
    varCurrency:
      goto ComparaNumeros;
    varUnknown:
      Result := True;
    varString:
      goto ComparaCadenas;
    varUString:
      goto ComparaCadenas;
    // varUString: goto ComparaCadenas;
    varBoolean:
      Result := S;
  end;

ComparaNumeros:
  begin
    if (S <> 0) then
      Result := False
    else
      Result := True;
  end;

ComparaCadenas:
  begin
    if (trim(VarToStr(S)) <> '') then
      Result := False
    else
      Result := True
  end;
end;

function TfUtilesV20.OpenSqlLite(): Boolean;
VAR
  cDatabase: string;
begin
  cDatabase := ExtractFilePath(Application.ExeName) + 'data\local.conf';

  if FileExists(cDatabase) = False then
  begin
    Result := False;
    exit;
  end;

  oPublicCnnSQLL.Params.Clear;
  oPublicCnnSQLL.Params.Add('DriverID=SQLite');
  oPublicCnnSQLL.Params.Add('Database=' + cDatabase);
  oPublicCnnSQLL.Params.Add('OpenMode=CreateUTF16');
  oPublicCnnSQLL.Params.Add('Password=');
  oPublicCnnSQLL.Params.Add('BusyTimeout=10000');
  oPublicCnnSQLL.Params.Add('LockingMode=Normal');
  oPublicCnnSQLL.Params.Add('JournalMode=WAL');
  oPublicCnnSQLL.Params.Add('Synchronous=Full');
  oPublicCnnSQLL.Params.Add('SQLiteAdvanced=temp_store=MEMORY');
  oPublicCnnSQLL.Params.Add('SQLiteAdvanced=page_size=4096');
  oPublicCnnSQLL.Params.Add('SQLiteAdvanced=auto_vacuum=FULL');
  try
    oPublicCnnSQLL.Connected := True;

    if oPublicCnnSQLL.Connected = True then
      Result := True
    else
      Result := False;
  except
    on E: Exception do
    begin
      showmessage('Error al abrir el SQLLITE)');
      Application.ShowException(E);
    end;
  end;
end;

function TfUtilesV20.ConnectServer(pKey: string): Boolean;
begin
  self.GetSetting2(pKey);
  self.Carga_Setting_Conn2();
  Result := self.oPublicCnn.Connected;
end;

function TfUtilesV20.LlenarcbEmpresa(var pComboSrvs: TcomboBox): integer;
var
  oQry1: TFDQuery;
  cSql: string;
  sNomEmp: string;
begin
  oQry1 := TFDQuery.Create(nil);
  oQry1.Connection := self.oPublicCnn;
  cSql := 'SELECT  * FROM empresas WHERE emp_activo=1 ORDER BY emp_descripcion ASC ';
  oQry1.SQL.text := cSql;
  oQry1.Open;
  if not oQry1.eof then
    oQry1.First;
  pComboSrvs.Clear;
  pComboSrvs.Items.Clear;
  while not oQry1.eof do
  begin
    sNomEmp := oQry1.FieldByName('emp_descripcion').text;
    pComboSrvs.Items.Add(sNomEmp);
    oQry1.Next;
  end;
  oQry1.close;
  oQry1.Free;
  Result := pComboSrvs.Items.Count;
end;

procedure TfUtilesV20.Delete_Collate_Tmp();
var
  oQry: TFDQuery;
begin
  try
    Exec_Select_SQL(oQry, 'DROP TABLE IF EXISTS `tmp_collate`;', True, True, True);
    oQry.Free;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
    end;
  end;
end;

procedure TfUtilesV20.Create_Collate_Tmp();
var
  oQry: TFDQuery;
begin
  try
    Exec_Select_SQL(oQry, 'CALL Change_Collate()', True, True, True);
    oQry.Free;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
    end;
  end;
end;

{ -------------------------------------------------------------------------------------------------
  Esta funcion que es una extención de Execute_SQL_Command, ejecuta uan cadena de comandos separados
  por ; y las ejecuta al mismo tiempo en un string no muy grande.
  -------------------------------------------------------------------------------------------------- }
function Execute_SQL_Command(pSQL: string): Boolean; overload;
begin
  with fUtilesV20 do
  begin
    if isEmpty(pSQL) = True then
    begin
      Result := False;
      exit;
    end;
    Result := False;
    if (bConnectionOk = False) then
      Carga_Setting_Conn2();

    if Check_Host_IsAlive(oPublicCnn.Params.Values['Server'], StrToInt(oPublicCnn.Params.Values['port'])) = False then
    begin
      Result := False;
      exit;
    end;

    try
      oPub_Com.Connection := oPublicCnn;
      oPub_Com.CommandText.Clear;
      oPub_Com.CommandText.text := pSQL;
      oPub_Com.Execute;
      Result := True;
    except
      on E: Exception do
      begin
        Result := False;
        Application.ShowException(E);
      end;
    end;
  end;
end;

{ -------------------------------------------------------------------------------------------------
  Esta funcion que es una extención de Execute_SQL_Command, ejecuta uan cadena de comandos separados
  por ; y las ejecuta al mismo tiempo
  -------------------------------------------------------------------------------------------------- }
function Execute_SQL_Script(oConn_Tmp: TFDConnection; pScript: TStrings): Boolean; overload;
begin
  with fUtilesV20 do
  begin
    if isEmpty(pScript.text) = True then
    begin
      Result := False;
      exit;
    end;

    if Check_Host_IsAlive(oConn_Tmp.Params.Values['Server'], StrToInt(oConn_Tmp.Params.Values['Port'])) = False then
    begin
      Result := False;
      exit;
    end;

    oPub_Scp.Connection := oConn_Tmp;
    oPub_Scp.SQLScripts.Clear;
    oPub_Scp.SQLScripts.Add;
    oPub_Scp.SQLScripts[0].SQL.text := pScript.text;
    try
      oPub_Scp.ValidateAll;
      oPub_Scp.ExecuteAll;
      Result := True;
    except
      on E: Exception do
      begin
        Application.ShowException(E);
        Result := False;
      end;
    end;
  end;
end;

function Execute_SQL_Script(pScript: string): Boolean; overload;
begin
  with fUtilesV20 do
  begin
    if isEmpty(pScript) = True then
    begin
      Result := False;
      exit;
    end;

    if (bConnectionOk = False) then
      Carga_Setting_Conn2();

    if Check_Host_IsAlive(oPublicCnn.Params.Values['Server'], StrToInt(oPublicCnn.Params.Values['Port'])) = False then
    begin
      Result := False;
      exit;
    end;

    oPub_Scp.Connection := oPublicCnn;
    oPub_Scp.SQLScripts.Clear;
    oPub_Scp.SQLScripts.Add;
    oPub_Scp.SQLScripts[0].SQL.text := pScript;
    try
      oPub_Scp.ValidateAll;
      oPub_Scp.ExecuteAll;
      Result := True;
    except
      on E: Exception do
      begin
        Application.ShowException(E);
        Result := False;
      end;
    end;
  end;
end;

function Execute_SQL_Script(pScript: TStrings): Boolean; overload;
begin
  with fUtilesV20 do
  begin
    if isEmpty(pScript.text) = True then
    begin
      Result := False;
      exit;
    end;

    if (bConnectionOk = False) then
      Carga_Setting_Conn2();

    if Check_Host_IsAlive(oPublicCnn.Params.Values['Server'], StrToInt(oPublicCnn.Params.Values['Port'])) = False then
    begin
      Result := False;
      exit;
    end;

    oPub_Scp.Connection := oPublicCnn;
    oPub_Scp.SQLScripts.Clear;
    oPub_Scp.SQLScripts.Add;
    oPub_Scp.SQLScripts[0].SQL.text := pScript.text;
    try
      oPub_Scp.ValidateAll;
      oPub_Scp.ExecuteAll;
      Result := True;
    except
      on E: Exception do
      begin
        Application.ShowException(E);
        Result := False;
      end;
    end;
  end;
end;

function Execute_SQL_Command(pScript: TStringList): Boolean; overload;
begin
  with fUtilesV20 do
  begin

    if isEmpty(pScript.text) = True then
    begin
      Result := False;
      exit;
    end;

    if (bConnectionOk = False) then
      Carga_Setting_Conn2();

    if Check_Host_IsAlive(oPublicCnn.Params.Values['Server'], StrToInt(oPublicCnn.Params.Values['port'])) = False then
    begin
      Result := False;
      exit;
    end;

    oPub_Scp.Connection := oPublicCnn;
    oPub_Scp.SQLScripts.Clear;
    oPub_Scp.SQLScripts.Add;
    oPub_Scp.SQLScripts[0].SQL.text := pScript.text;
    try
      oPub_Scp.ValidateAll;
      oPub_Scp.ExecuteAll;
      Result := True;
    except
      on E: Exception do
      begin
        Application.ShowException(E);
        Result := False;
      end;
    end;
  end;
end;

function Execute_SQL_Command_Tmp(pSQL: string; oSetting_Tmp: Config2): Boolean; overload;
begin
  with fUtilesV20 do
  begin
    oPublicCnn_Tmp.Params.Clear;
    oPublicCnn_Tmp.Params.Add('DriverID=MySQL');
    oPublicCnn_Tmp.Params.Add('Server=' + oSetting_Tmp.host);
    oPublicCnn_Tmp.Params.Add('Database=' + oSetting_Tmp.database);
    oPublicCnn_Tmp.Params.Add('CharacterSet=utf8');
    oPublicCnn_Tmp.Params.Add('User_Name=' + oSetting_Tmp.usuario);
    oPublicCnn_Tmp.Params.Add('Password=' + oSetting_Tmp.clave);
    oPublicCnn_Tmp.Params.Add('Port=' + IntToStr(oSetting_Tmp.puerto));
    oPublicCnn_Tmp.Params.Add('MetaDefCatalog=' + oSetting_Tmp.database);
    oPublicCnn_Tmp.Params.Add('MetaCurCatalog=' + oSetting_Tmp.database);
    oPublicCnn_Tmp.LoginPrompt := False;

    if Check_Host_IsAlive(oPublicCnn_Tmp.Params.Values['Server'], StrToInt(oPublicCnn_Tmp.Params.Values['Port'])) = False then
    begin
      Result := False;
      exit;
    end;

    try
      oPublicCnn_Tmp.Connected := True;
      bConnectionOk := oPublicCnn_Tmp.Connected;

      oPub_Com.Connection := oPublicCnn_Tmp;
      oPub_Com.CommandText.Clear;
      oPub_Com.CommandText.text := pSQL;
      oPub_Com.Execute;
      Result := True;
    finally
      Result := False;
    end;
  end;
end;

function Execute_SQL_Command_Tmp(pSQL: string; oConn_Tmp: TFDConnection): Boolean; overload;
begin
  with fUtilesV20 do
  begin
    if Check_Host_IsAlive(oConn_Tmp.Params.Values['Server'], StrToInt(oConn_Tmp.Params.Values['Port'])) = False then
    begin
      Result := False;
      exit;
    end;
    try
      oPub_Com.Connection := oConn_Tmp;
      oPub_Com.CommandText.Clear;
      oPub_Com.CommandText.text := pSQL;
      oPub_Com.Execute;
      Result := True;
    except
      on E: Exception do
      begin
        Result := False;
      end;
    end;
  end;
end;

function Execute_SQL_Command_Tmp(pScript: TStringList; oConn_Tmp: TFDConnection): Boolean; overload;
var
  SqlProcessor: TFDScript;
begin
  with fUtilesV20 do
  begin
    if isEmpty(pScript.text) = True then
    begin
      Result := False;
      exit;
    end;

    if (bConnectionOk = False) then
      Carga_Setting_Conn2();

    if Check_Host_IsAlive(oConn_Tmp.Params.Values['Server'], StrToInt(oConn_Tmp.Params.Values['Port'])) = False then
    begin
      Result := False;
      exit;
    end;

    oPub_Scp.Connection := oConn_Tmp;
    oPub_Scp.Connection := oConn_Tmp;
    oPub_Scp.SQLScripts.Clear;
    oPub_Scp.SQLScripts.Add;
    oPub_Scp.SQLScripts[0].SQL.text := pScript.text;
    try
      oPub_Scp.ValidateAll;
      oPub_Scp.ExecuteAll;
      Result := True;
    except
      on E: Exception do
      begin
        Application.ShowException(E);
        Result := False;
      end;
    end;
  end;
end;

function Execute_SQL_Command_Tmp_Fle(pFilename: string; oConn_Tmp: TFDConnection): Boolean; overload;
begin
  with fUtilesV20 do
  begin
    if isEmpty(pFilename) = True then
    begin
      Result := False;
      exit;
    end;

    if Check_Host_IsAlive(oConn_Tmp.Params.Values['Server'], StrToInt(oConn_Tmp.Params.Values['Port'])) = False then
    begin
      Result := False;
      exit;
    end;

    oPub_Scp.Connection := oConn_Tmp;
    oPub_Scp.SQLScripts.Clear;
    oPub_Scp.SQLScripts.Add;
    oPub_Scp.SQLScripts[0].SQL.LoadFromFile(pFilename);
    try
      oPub_Scp.ValidateAll;
      oPub_Scp.ExecuteAll;
      Result := True;
    except
      on E: Exception do
      begin
        Application.ShowException(E);
        Result := False;
      end;
    end;
  end;
end;

function TfUtilesV20.BuscarUsuario(var oQry1: TFDQuery; sUsuario: string; bCheckActive: Boolean = True): integer;
var
  cSql: string;
begin
  oQry1.Connection := self.oPublicCnn;
  if bCheckActive = False then
    cSql := 'SELECT * FROM usuarios WHERE u_usuario = ' + QuotedStr(sUsuario)
  else
    cSql := 'SELECT * FROM usuarios WHERE u_activo = 1 AND u_usuario = ' + QuotedStr(sUsuario);

  oQry1.SQL.text := cSql;
  oQry1.Open;
  if not oQry1.eof then
  begin
    oQry1.First;
    Result := oQry1.RecordCount;
  end
  else
    Result := 0;
end;

procedure TfUtilesV20.CenterForm(AForm: Tform);
var
  ALeft, ATop: integer;
begin
  ALeft := (Screen.Width - AForm.Width) div 2;
  ATop := (Screen.Height - AForm.Height) div 2;
  { prevents form being twice repainted! }
  AForm.SetBounds(ALeft, ATop, AForm.Width, AForm.Height);
end;

procedure TfUtilesV20.CenterFormOverActive(AForm: Tform);
var
  ALeft, ATop: integer;
begin
  ALeft := Screen.ActiveForm.Left + (Screen.ActiveForm.Width div 2) - (AForm.Width div 2);
  ATop := Screen.ActiveForm.Top + (Screen.ActiveForm.Height div 2) - (AForm.Height div 2);
  { prevent form from being outside screen }
  if ALeft < 0 then
    ALeft := Screen.ActiveForm.Left;
  if ATop < 0 then
    ATop := Screen.ActiveForm.Top;
  if (ALeft + AForm.Width > Screen.Width) or (ATop + AForm.Height > Screen.Height) then
    CenterForm(AForm)
  else
    { prevents form being twice repainted! }
    AForm.SetBounds(ALeft, ATop, AForm.Width, AForm.Height);
end;

function TfUtilesV20.iif(Test: Boolean; TrueR, FalseR: variant): variant;
begin
  if Test then
    Result := TrueR
  else
    Result := FalseR;
end;

function TfUtilesV20.GetVersion(sFilename: string): string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(sFilename), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(sFilename), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

procedure TfUtilesV20.Create_Blank_Tables(sFilename: string);
var
  sLineCMD: string;
  sParamet: string;
  Response: integer;
begin
  try
    sParamet := ' --host=' + trim(oSetting_Fac.host) + ' --user=root --password= -d ' + trim(oSetting_Fac.database) + ' > ' + sFilename;
    sLineCMD := ExtractFilePath(Application.ExeName) + 'Data\mysqldump.exe ';
    Response := WinExec(PAnsiChar(sLineCMD + sParamet), SW_SHOWNORMAL);
  except
    on E: Exception do
    begin
      Application.ShowException(E);
    end;
  end;
  ShellExecute_AndWait(sLineCMD, sParamet);
end;

procedure TfUtilesV20.ShellExecute_AndWait(FileName: string; Params: string);
var
  exInfo: TShellExecuteInfo;
  Ph: DWORD;
begin
  FillChar(exInfo, SizeOf(exInfo), 0);
  with exInfo do
  begin
    cbSize := SizeOf(exInfo);
    fMask := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_DDEWAIT;
    Wnd := GetActiveWindow();
    exInfo.lpVerb := 'open';
    exInfo.lpParameters := PChar(Params);
    lpFile := PChar(FileName);
    nShow := SW_SHOWNORMAL;
  end;
  if ShellExecuteEx(@exInfo) then
    Ph := exInfo.hProcess
  else
  begin
    showmessage(SysErrorMessage(GetLastError));
    exit;
  end;
  while WaitForSingleObject(exInfo.hProcess, 50) <> WAIT_OBJECT_0 do
    Application.ProcessMessages;
  CloseHandle(Ph);
end;

procedure TfUtilesV20.LogToFile(const S, FileName: string);
var
  oFile: TStrings;
begin
  oFile := TStringList.Create;

  if FileExists(FileName) then
    oFile.LoadFromFile(FileName);

  oFile.Add(S);
  oFile.SaveToFile(FileName);
  freeandnil(oFile);
end;

function TfUtilesV20.Add_query_in_Combo(pFieldText: string; pFieldKey: string; pSQL: string; var oCombo: TDBComboBoxEh): Boolean;
var
  oQuery1: TFDQuery;
  sText: string;
  s_Key: string;
begin
  Result := False;
  try
    oCombo.Clear;
    oCombo.KeyItems.Clear;
    oCombo.Items.Clear;
    if Exec_Select_SQL(oQuery1, pSQL, True, True, False) = False then
    begin
      Result := False;
    end;
    while not oQuery1.eof do
    begin
      sText := UpperCase(trim(oQuery1.FieldByName(pFieldText).text));
      s_Key := trim(oQuery1.FieldByName(pFieldKey).text);
      oCombo.KeyItems.Add(s_Key);
      oCombo.Items.Add(sText);
      oQuery1.Next;
    end;
    oQuery1.Free;
    Result := True;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
end;

function TfUtilesV20.LoadDatabaseInServer(pServer: string;

  var oCombo: TcomboBox): Boolean;
var
  oQuery1: TFDQuery;
  sText: string;
begin
  Result := False;
  try
    oCombo.Clear;
    Exec_Select_SQL(oQuery1, 'SHOW DATABASES', True, True, False);
    if oQuery1.eof then
    begin
      Result := False;
      exit;
    end;
    oCombo.Clear;
    oCombo.Items.Clear;
    while not oQuery1.eof do
    begin
      sText := UpperCase(trim(oQuery1.FieldByName('database').text));
      oCombo.Items.Add(sText);
      oQuery1.Next;
    end;
    oQuery1.Free;
    Result := True;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
end;

procedure TfUtilesV20.MoveDBGridColumns(DBGrid: TDBGridEh; FromColumn, ToColumn: integer);
begin
  THackAccess(DBGrid).MoveColumn(FromColumn, ToColumn);
end;

function TfUtilesV20.GetWindowsDir: TFileName;
var
  WinDir: array [0 .. MAX_PATH - 1] of Char;
begin
  SetString(Result, WinDir, GetWindowsDirectory(WinDir, MAX_PATH));
  if Result = '' then
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

function TfUtilesV20.GetSystemDir: TFileName;
var
  SysDir: array [0 .. MAX_PATH - 1] of Char;
begin
  SetString(Result, SysDir, GetSystemDirectory(SysDir, MAX_PATH));
  if Result = '' then
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

function TfUtilesV20.GetProgramFilesDir: TFileName;
begin
  Result := GetRegistryData(HKEY_LOCAL_MACHINE, '\Software\Microsoft\Windows\CurrentVersion', 'ProgramFilesDir');
end;

function TfUtilesV20.GetRegistryData(RootKey: HKEY; key, Value: string): variant;
var
  Reg: TRegistry;
  RegDataType: TRegDataType;
  DataSize, Len: integer;
  S: string;
label cantread;
begin
  Reg := nil;
  try
    Reg := TRegistry.Create(KEY_QUERY_VALUE);
    Reg.RootKey := RootKey;
    if Reg.OpenKeyReadOnly(key) then
    begin
      try
        RegDataType := Reg.GetDataType(Value);
        if (RegDataType = rdString) or (RegDataType = rdExpandString) then
          Result := Reg.ReadString(Value)
        else if RegDataType = rdInteger then
          Result := Reg.ReadInteger(Value)
        else if RegDataType = rdBinary then
        begin
          DataSize := Reg.GetDataSize(Value);
          if DataSize = -1 then
            goto cantread;
          SetLength(S, DataSize);
          Len := Reg.ReadBinaryData(Value, PChar(S)^, DataSize);
          if Len <> DataSize then
            goto cantread;
          Result := S;
        end
        else
        cantread:
          raise Exception.Create(SysErrorMessage(ERROR_CANTREAD));
      except
        S := '';
        // Deallocates memory if allocated
        Reg.CloseKey;
        raise;
      end;
      Reg.CloseKey;
    end
    else
      raise Exception.Create(SysErrorMessage(GetLastError));
  except
    Reg.Free;
    raise;
  end;
  Reg.Free;
end;

procedure TfUtilesV20.SetRegistryData(RootKey: HKEY; key, Value: string; RegDataType: TRegDataType; Data: variant);
var
  Reg: TRegistry;
  S: string;
begin
  Reg := TRegistry.Create(KEY_WRITE);
  try
    Reg.RootKey := RootKey;
    if Reg.OpenKey(key, True) then
    begin
      try
        if RegDataType = rdUnknown then
          RegDataType := Reg.GetDataType(Value);
        if RegDataType = rdString then
          Reg.writeString(Value, Data)
        else if RegDataType = rdExpandString then
          Reg.WriteExpandString(Value, Data)
        else if RegDataType = rdInteger then
          Reg.WriteInteger(Value, Data)
        else if RegDataType = rdBinary then
        begin
          S := Data;
          Reg.WriteBinaryData(Value, PChar(S)^, Length(S));
        end
        else
          raise Exception.Create(SysErrorMessage(ERROR_CANTWRITE));
      except
        Reg.CloseKey;
        raise;
      end;
      Reg.CloseKey;
    end
    else
      raise Exception.Create(SysErrorMessage(GetLastError));
  finally
    Reg.Free;
  end;
end;

function TfUtilesV20.BemaFI32INI(iRuta: integer = 1; iGetValue: integer = 0; sPort: string = ''): string;
var
  sPath: string;
  oFile: Tinifile;
begin

  if iRuta = 1 then
    sPath := self.GetSystemDir() + '\BemaFI32.ini'
  else
    sPath := ExtractFilePath(Application.ExeName) + 'data\utiles\librerias\BemaFI32.ini';

  if FileExists(sPath) = False then
  begin
    exit;
  end;

  oFile := Tinifile.Create(sPath);
  case iGetValue of
    0:
      begin
        Result := oFile.ReadString('Sistema', 'Puerta', 'COM1');
      end;
    1:
      begin
        oFile.writeString('Sistema', 'Puerta', trim(sPort));
        // oFile.writeString('Sistema', 'Log', '1');
        // oFile.writeString('Sistema', 'EmulMFD', '0');
        // oFile.writeString('Sistema', 'StatusCheque', '');
        // oFile.writeString('Sistema', 'PAIS', 'VENEZUELA');
        // oFile.writeString('MFD', 'ImpresoraMFD', '1');
        Result := '';
      end;
  end;
  freeandnil(oFile);
end;

function TfUtilesV20.RightStr(const Str: string; Size: Word): string;
begin
  if Size > Length(Str) then
    Size := Length(Str);
  RightStr := Copy(Str, Length(Str) - Size + 1, Size)
end;

function TfUtilesV20.MidStr(const Str: string; From, Size: Word): string;
begin
  MidStr := Copy(Str, From, Size)
end;

function TfUtilesV20.LeftStr(const Str: string; Size: Word): string;
begin
  LeftStr := Copy(Str, 1, Size)
end;

function TfUtilesV20.SetScreenResolution(Width, Height: integer): Longint;
var
  DeviceMode: TDeviceMode;
begin
  with DeviceMode do
  begin
    dmSize := SizeOf(TDeviceMode);
    dmPelsWidth := Width;
    dmPelsHeight := Height;
    dmFields := DM_PELSWIDTH or DM_PELSHEIGHT;
  end;
  Result := ChangeDisplaySettings(DeviceMode, CDS_UPDATEREGISTRY);
end;

function TfUtilesV20.TamanoFichero(sFileToExamine: string): Longword;
var
  SearchRec: TSearchRec;
  sgPath: string;
  inRetval, I1: integer;
begin
  sgPath := ExpandFileName(sFileToExamine);
  try
    inRetval := FindFirst(ExpandFileName(sFileToExamine), faAnyfile, SearchRec);
    if inRetval = 0 then
      I1 := SearchRec.Size
    else
      I1 := -1;
  finally
    FindClose(SearchRec);
  end;
  Result := I1;
end;

// Para comprobar si el servicio se esta ejecutando
function TfUtilesV20.ServiceisRunning(nombre: string): Boolean;
var
  ServiceControlManager: SC_HANDLE;
  Service: SC_HANDLE;
  ServiceStatus: SERVICE_STATUS;
begin
  Result := False;
  ServiceControlManager := OpenSCManager(nil, nil, SC_MANAGER_CONNECT);
  if ServiceControlManager <> 0 then
  begin
    Service := OpenService(ServiceControlManager, PChar(nombre), GENERIC_READ);
    if Service <> 0 then
    begin
      if QueryServiceStatus(Service, ServiceStatus) then
        Result := ServiceStatus.dwCurrentState = SERVICE_RUNNING;
      CloseServiceHandle(Service);
    end;
    CloseServiceHandle(ServiceControlManager);
  end;
end;

// Para comprobar si el servicio esta instalado
function TfUtilesV20.ServiceIsInstalled(nombre: string): Boolean;
var
  ServiceControlManager: SC_HANDLE;
  Service: SC_HANDLE;
  ServiceStatus: SERVICE_STATUS;
begin
  Result := False;
  ServiceControlManager := OpenSCManager(nil, nil, SC_MANAGER_CONNECT);
  if ServiceControlManager <> 0 then
  begin
    Service := OpenService(ServiceControlManager, PChar(nombre), GENERIC_READ);
    if Service <> 0 then
    begin
      Result := True;
      CloseServiceHandle(Service);
    end;
    CloseServiceHandle(ServiceControlManager);
  end;
end;

function TfUtilesV20.GetMysqlVariables(pVariable: string): string;
var
  oQry: TFDQuery;
begin
  oQry := TFDQuery.Create(nil);
  Exec_Select_SQL(oQry, 'SHOW VARIABLES', True, True, False);
  while not oQry.eof do
  begin
    if oQry.FieldByName(pVariable).AsString = 'basedir' then
    begin
      GetMysqlVariables := oQry.FieldByName('Value').AsString
    end;
    oQry.Next;
  end;
end;

function TfUtilesV20.WinExecAndWait32(FileName: string; Visibility: integer): integer;
var
  zAppName: array [0 .. 512] of Char;
  zCurDir: array [0 .. 255] of Char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  Res: UINT;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;

  if not(CreateProcess(nil, zAppName, { pointer to command line string }
    nil, { pointer to process security attributes }
    nil, { pointer to thread security attributes }
    False, { handle inheritance flag }
    CREATE_NEW_CONSOLE or { creation flags }
    NORMAL_PRIORITY_CLASS, nil, { pointer to new environment block }
    nil, { pointer to current directory name }
    StartupInfo, { pointer to STARTUPINFO }
    ProcessInfo)) then { pointer to PROCESS_INF }
    Result := -1
  else
  begin
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Res);
    { Added v2.4.4 (JS) }
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
    Result := Res;
  end;
end;

function TfUtilesV20.Win32CreateProcess(const FileName, Parameters: string;

  var ExitCode: DWORD;

  const Wait: DWORD = 0;

  const Hide: Boolean = False): Boolean;
var
  myInfo: SHELLEXECUTEINFO;
  iWaitRes: DWORD;
begin
  ZeroMemory(@myInfo, SizeOf(SHELLEXECUTEINFO));
  myInfo.cbSize := SizeOf(SHELLEXECUTEINFO);
  myInfo.fMask := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_NO_UI;
  myInfo.lpFile := PChar(FileName);
  myInfo.lpParameters := PChar(Parameters);
  if Hide then
    myInfo.nShow := SW_HIDE
  else
    myInfo.nShow := SW_SHOWNORMAL;
  ExitCode := 0;
  Result := ShellExecuteEx(@myInfo);
  if Result then
  begin
    while WaitForSingleObject(myInfo.hProcess, 100) = WAIT_TIMEOUT do
      Application.ProcessMessages;

    iWaitRes := WaitForSingleObject(myInfo.hProcess, 100);

    if (iWaitRes = WAIT_TIMEOUT) then
    begin
      Result := False;
      TerminateProcess(myInfo.hProcess, 0);
    end;
    GetExitCodeProcess(myInfo.hProcess, ExitCode);
    CloseHandle(myInfo.hProcess);
  end;
end;

{ --------------------------------------------------------------------------------------------
  Esta función genera un pausa dependiendo del parametro.
  el parámetro indica la cantidad de milisegundos que debe esperar.
  ---------------------------------------------------------------------------------------------- }
procedure TfUtilesV20.Delay(msecs: integer);
var
  FirstTickCount: Longint;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((GetTickCount - FirstTickCount) >= Longint(msecs));
end;

{ --------------------------------------------------------------------------------------------
  Esta función devuelve true si la la base de datos esta actualmente trabajando algun proceso.
  es util en los backup para saber si ya se termino de restaurar o respaldar la bases de datos
  ni no hay ninguna operacion en cuerso en la bases de datos devuelve false.
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.MysQL_Processing_DB(DBName: string): Boolean;
var
  oQry: TFDQuery;
begin
  Result := False;
  Exec_Select_SQL(oQry, 'SHOW PROCESSLIST', True, True, False);
  while not oQry.eof do
  begin
    if oQry.FieldByName('db').AsString = DBName then
    begin
      Result := True;
      exit;
    end;
    oQry.Next;
  end;
  oQry.Free;
end;

{ --------------------------------------------------------------------------------------------
  Esta función devuelve true si la tabla existe en la base de datos y false si no existe.
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.TableExists(DBName: string; TableName: string): Boolean;
var
  oQryFlds: TFDQuery;
  cSqlCmdl: string;
begin
  cSqlCmdl := 'SHOW TABLES FROM ' + DBName + ' LIKE "' + TableName + '" ';
  Exec_Select_SQL(oQryFlds, cSqlCmdl, True, True, False);
  if not oQryFlds.eof then
  begin
    if oQryFlds.RecordCount > 0 then
      Result := True
    else
      Result := False;
  end
  else
    Result := False;
  oQryFlds.Free;
end;

{ --------------------------------------------------------------------------------------------
  Esta función devuelve true si la base de datos existe en mysql.
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.DatabaseExists(DBName: string): Boolean;
var
  cSqlCmdl: string;
begin
  if oExe_SQL = nil then
    oExe_SQL := TFDQuery.Create(nil);
  cSqlCmdl := 'SHOW DATABASES LIKE "' + DBName + '" ';
  Exec_Select_SQL(oExe_SQL, cSqlCmdl, True, False, False);
  if not oExe_SQL.eof then
  begin
    if oExe_SQL.RecordCount > 0 then
      Result := True
    else
      Result := False;
  end
  else
    Result := False;
  oExe_SQL.close;
end;

{ --------------------------------------------------------------------------------------------
  Esta función devuelve true si el campo existe en la tabla y false si no existe.
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.FieldExists(field: string; Full_DB_Table_Name: string): Boolean;
var
  cSqlCmdl: string;
begin
  if oQryFlds = nil then
    oQryFlds := TFDQuery.Create(nil);
  cSqlCmdl := 'SHOW COLUMNS FROM ' + Full_DB_Table_Name + ' WHERE UCASE(field)=UCASE("' + trim(field) + '") ';
  if Exec_Select_SQL(oQryFlds, cSqlCmdl, True, True, False) = True then
  begin
    if oQryFlds.RecordCount > 0 then
    begin
      Result := True;
    end
    else
      Result := False;
  end
  else
    Result := False;
  oQryFlds.close;
end;

{ --------------------------------------------------------------------------------------------
  Esta función devuelve true si el campo existe en la tabla y false si no existe.
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.FieldExists2(var field: string; Full_DB_Table_Name: string): Boolean;
var
  oQryFlds: TFDQuery;
  cSqlCmdl: string;
begin
  cSqlCmdl := 'SHOW COLUMNS FROM ' + Full_DB_Table_Name + ' WHERE UCASE(field)=UCASE("' + trim(field) + '") ';
  if Exec_Select_SQL(oQryFlds, cSqlCmdl, True, True, False) = True then
  begin
    if oQryFlds.RecordCount > 0 then
    begin
      field := oQryFlds.FieldByName('field').AsString;
      Result := True;
    end
    else
      Result := False;
  end
  else
    Result := False;
  oQryFlds.Free;
end;

{ --------------------------------------------------------------------------------------------
  Esta función devuelve el numero de tablas de una base de datos.
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.Tables_Counts(DB_Name: string): integer;
var
  oQryCKFL: TFDQuery;
begin
  Result := 0;
  DB_Name := trim(DB_Name);
  Exec_Select_SQL(oQryCKFL, 'SHOW TABLE STATUS FROM `' + DB_Name + '` WHERE COMMENT=""', True, True, False);
  if not oQryCKFL.eof then
    Result := oQryCKFL.RecordCount;
  oQryCKFL.Free;
end;

{ --------------------------------------------------------------------------------------------
  Esta función devuelve el numero de campos de una tabla, es necesarios especificada la tabla .
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.Fields_Counts(Full_DB_Table_Name: string): integer;
var
  oQryCKFL: TFDQuery;
  cSqlCmdl: string;
begin
  Result := 0;
  cSqlCmdl := 'SHOW COLUMNS FROM ' + Full_DB_Table_Name + ' ';
  Exec_Select_SQL(oQryCKFL, cSqlCmdl, True, True, False);
  if not oQryCKFL.eof then
    Result := oQryCKFL.RecordCount;
  oQryCKFL.Free;
end;

{ --------------------------------------------------------------------------------------------
  Esta función busca la llave primaria de una tabla especificada.
  ---------------------------------------------------------------------------------------------- }

function TfUtilesV20.Find_PrimaryKey(TableName: string): string;
var
  oQryCmd: TFDQuery;
begin
  Result := '';
  Exec_Select_SQL(oQryCmd, 'SHOW COLUMNS FROM ' + TableName + ' WHERE `KEY`="PRI" ', True, True, False);
  if not oQryCmd.eof then
    Result := oQryCmd.FieldByName('field').AsString;
  oQryCmd.Free;
end;

{ --------------------------------------------------------------------------------------------
  esta función duplica un caracter las cantidad de veces especificada.
  Cadena:=Replicate('=',20)
  devuelve a cadena '===================='
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.Replicate(Caracter: string; Quant: integer): string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to Quant do
    Result := Result + Caracter;
end;

procedure TfUtilesV20.SyncSaveEnvList(cPath: string; cFileName: string = 'Index.txt'; cText: string = '');
var
  LogFile: textfile;
  cFullPath: string;
begin
  cFullPath := trim(cPath) + iif(RightStr(trim(cPath), 1) = '\', '', '\') + trim(cFileName);
  if not DirectoryExists(cPath) then
    ForceDirectories(cPath);
  AssignFile(LogFile, cFullPath);
  try
    if FileExists(cFullPath) then
      Append(LogFile)
    else
      Rewrite(LogFile);
    WriteLn(LogFile, cText);
    CloseFile(LogFile)
  except
    // Ignore exceptions while writing log files
  end;
end;

{ --------------------------------------------------------------------------------------------
  esta función convierte de cadena a hexagesimal
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.StringToHex(S: string): string;
var
  i: integer;
begin
  Result := '';
  // Go throught every single characters, and convert them
  // to hexadecimal...
  for i := 1 to Length(S) do
    Result := Result + IntToHex(Ord(S[i]), 2);
end;

{ --------------------------------------------------------------------------------------------
  esta función convierte de exagesimal a cadena
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.HexToString(S: string): string;
var
  i: integer;
begin
  Result := '';
  // Go throught every single hexadecimal characters, and convert
  // them to ASCII characters...
  for i := 1 to Length(S) do
  begin
    // Only process chunk of 2 digit Hexadecimal...
    if ((i mod 2) = 1) then
      Result := Result + Chr(StrToInt('0x' + Copy(S, i, 2)));
  end;
end;

{ --------------------------------------------------------------------------------------------
  // Esta función muestra el numero de dia que desde enero hasta la fecha x de un año
  //o de una fecha.
  // [Meeus91, p. 65]
  // DayOfYear(1978, 11, 14) = 318
  // DayOfYear(2000, 11, 14) = 319
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.DayOfYear(const Year, Month, Day: Word): integer;
var
  k: Word;
begin
  if IsLeapYear(Year) then
    k := 1
  else
    k := 2;
  Result := TRUNC(275 * Month / 9) - k * TRUNC((Month + 9) / 12) + Day - 30;
end; { DayOfYear }

{ --------------------------------------------------------------------------------------------
  Esta función muestra la fecha del correspondiente al ùltimo día del mes.
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.LastDayInMonth(const Year, Month: Word): TDateTime;
begin
  if Month = 12 then
    Result := EncodeDate(Year + 1, 1, 1) - 1
  else
    Result := EncodeDate(Year, Month + 1, 1) - 1;
end;

{ ---------------------------------------------------------------------------------------------- }
{ Esta función muestra el devuelve el directorio temporal de la carpeta del windows. }
{ ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.GetWindowsTempDirectory: string;
var
  tempFolder: array [0 .. MAX_PATH] of Char;
begin
  GetTempPath(MAX_PATH, @tempFolder);
  Result := StrPas(tempFolder);
end;

{ ---------------------------------------------------------------------------------------------- }
{ Crear una Lista de todos los archivos de un directorio [Path]. }
{ Reading a directory content }
{ ---------------------------------------------------------------------------------------------- }
procedure TfUtilesV20.FindAllFiles(const Path: string; Attr: integer; List: TStrings);
var
  Res: TSearchRec;
  EOFound: Boolean;
begin
  // Res := TSearchRec.create(nil);
  EOFound := False;
  if FindFirst(Path, Attr, Res) < 0 then
    exit
  else
  begin
    while not EOFound do
    begin
      List.Add(Res.name);
      EOFound := FindNext(Res) <> 0;
    end;
    FindClose(Res);
  end;
end;

{ ==================================================================================================
  //Este juego de funciones WaitStart,WaitSetMsg,WaitEnd es utilizado para mostrar un pequeño
  //popup que muestra un emnsaje en particular;
  //WaitStart inicia y muestra la ventana, WaitSetMsg presenta el mensaje de texto que se quiere mostrar
  //y WaitEnd lo libera.
  ---------------------------------------------1--------------------------------------------------- }
function TfUtilesV20.WaitStart(TheParent: TComponent; sMsg: string): Boolean;
begin
  Result := False;
  if (nil = WaitForm) then
  begin
    WaitForm := Tform.Create(TheParent);
    with WaitForm do
    begin
      Position := poScreenCenter;
      Width := 500;
      Height := 12;

      WaitLabel := TLabel.Create(WaitForm);
      with WaitLabel do
      begin
        Align := alClient;
        Alignment := taCenter;
        // Font.Height := - 17;
        Font.Size := 10;
        ParentFont := False;
        Caption := sMsg;
        Parent := WaitForm;
        AlignWithMargins := True;
      end;

      SetWindowLong(handle, GWL_STYLE, GetWindowLong(handle, GWL_STYLE) and not WS_CAPTION);
      ClientHeight := Height;

      Show;
      Update;
    end;
    Result := True;
  end;
end;

{ ---------------------------------------------2--------------------------------------------------- }
procedure TfUtilesV20.WaitSetMsg(sMsg: string);
begin
  WaitLabel.Caption := sMsg;
  WaitForm.Refresh;
end;

{ ---------------------------------------------3--------------------------------------------------- }
function TfUtilesV20.WaitEnd: Boolean;
begin
  Result := False;
  if (nil <> WaitForm) then
  begin
    WaitForm.Hide;
    freeandnil(WaitForm);
    Result := True;
  end;
end;
{ =============================================================================================== }

{ --------------------------------------------------------------------------------------------
  Unformat a formatted integer or float. Used for CSV export and composing WHERE clauses for grid editing.
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.UnformatNumber(Val: string): string;
begin
  Result := Val;
  if FormatSettings.ThousandSeparator <> FormatSettings.DecimalSeparator then
    Result := StringReplace(Result, FormatSettings.ThousandSeparator, '', [rfReplaceAll]);
  Result := StringReplace(Result, FormatSettings.DecimalSeparator, '.', [rfReplaceAll]);
end;

{ --------------------------------------------------------------------------------------------
  Return a formatted integer or float from a string
  @param string Text containing a number
  @return string
  ---------------------------------------------------------------------------------------------- }
function FormatNumber(Str: string; Thousands: Boolean = True): string; overload;
var
  i, p, Left: integer;
begin

  Result := StringReplace(Str, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
  if Thousands then
  begin
    if ((Length(Result) >= 1) and (Result[1] = '0')) or ((Length(Result) >= 2) and (Result[1] = '-') and (Result[2] = '0')) then
      exit;
    p := Pos(FormatSettings.DecimalSeparator, Result);
    if p = 0 then
      p := Length(Result) + 1;
    Left := 2;
    if (Length(Result) >= 1) and (Result[1] = '-') then
      Left := 3;
    if p > 0 then
      for i := p - 1 downto Left do
      begin
        if (p - i) mod 3 = 0 then
          Insert(FormatSettings.ThousandSeparator, Result, i);
      end;
  end;
end;

{ --------------------------------------------------------------------------------------------
  Return a formatted number from an integer
  @param int64 Number to format
  @return string
  ---------------------------------------------------------------------------------------------- }
function FormatNumber(int: Int64; Thousands: Boolean = True): string; overload;
begin
  Result := FormatNumber(IntToStr(int), Thousands);
end;

{ --------------------------------------------------------------------------------------------
  Return a formatted number from a float This function TfUtilesV20.is called by two overloaded functions
  @param double Number to format
  @param integer Number of decimals
  @return string
  ---------------------------------------------------------------------------------------------- }
function FormatNumber(flt: Double; decimals: integer = 0; Thousands: Boolean = True): string; overload;
begin
  Result := Format('%10.' + IntToStr(decimals) + 'f', [flt]);
  Result := trim(Result);
  Result := FormatNumber(Result, Thousands);
end;

{ --------------------------------------------------------------------------------------------
  Return true if given character represents a number.
  Limitations: only recognizes ANSI numerals.
  Eligible for inlining, hope the compiler does this automatically.
  ---------------------------------------------------------------------------------------------- }
function TfUtilesV20.IsNumber(const c: Char): Boolean;
var
  b: Word;
begin
  b := Ord(c);
  Result := (b >= 48) and (b <= 57);
end;

{ --------------------------------------------------------------------------------------------
  // Devuelve -1, 0 o 1 de acuerdo al signo del argumento
  -------------------------------------------------------------------------------------------- }
function TfUtilesV20.Sgn(X: Single): integer;
begin
  if X < 0 then
    Result := -1
  else
  begin
    if X = 0 then
      Result := 0
    else
      Result := 1;
  end;
end;

{ --------------------------------------------------------------------------------------------
  // Devuelve el primer entero mayor que o igual al número dado en valor absoluto
  // (se preserva el signo).
  // RoundUp(3.3) = 4    RoundUp(-3.3) = -4
  -------------------------------------------------------------------------------------------- }
function TfUtilesV20.RoundUp(X: Single): Single;
begin
  Result := int(X) + Sgn(Frac(X));
end;

{ --------------------------------------------------------------------------------------------
  // Devuelve el primer entero menor que o igual al número dado en valor absoluto
  // (se preserva el signo).
  //   RoundDn(3.7) = 3    RoundDn(-3.7) = -3
  -------------------------------------------------------------------------------------------- }
function TfUtilesV20.RoundDn(X: Single): Single;
begin
  Result := int(X);
end;

{
  Sample:

  var
  Date3MonthsAfterNow: TDateTime;
  Date2YearsAgo: TDateTime;
  Date11DaysAfterNow: TDateTime;
  begin
  Date3MonthsAfterNow := DateTimeAdd(Now, dtpMonth, 3);
  Date2YearsAgo := DateTimeAdd(Now, dtpYear, -2); // negative is OK
  Date11DaysAfterNow := DateTimeAdd(Now, dtpDay, 11);
  end;
}
function TfUtilesV20.DateTimeAdd(SrcDate: TDateTime; DatePart: TDateTimePart; DiffValue: integer): TDateTime;
var
  m, d, y: Word;
begin
  case DatePart of
    dtpHour: { hour }
      Result := SrcDate + (DiffValue / 24);
    dtpMinute: { Minute }
      Result := SrcDate + (DiffValue / 1440);
    dtpSecond: { Second }
      Result := SrcDate + (DiffValue / 86400);
    dtpMS: { Millisecond }
      Result := SrcDate + (DiffValue / 86400000);
    dtpDay: { Day }
      Result := SrcDate + DiffValue;
    dtpMonth: { Month }
      Result := IncMonth(SrcDate, DiffValue);
  else { Year }
    begin
      DecodeDate(SrcDate, y, m, d);
      Result := TRUNC(EncodeDate(y + DiffValue, m, d)) + Frac(SrcDate);
    end;
  end;
end;

function TfUtilesV20.EjecutarComando(comando: string): string;
var
  Buffer: array [0 .. 4096] of Char;
  si: StartupInfo;
  sa: SECURITY_ATTRIBUTES;
  sd: SECURITY_DESCRIPTOR;
  pi: PROCESS_INFORMATION;
  newstdin, newstdout, read_stdout, write_stdin: THandle;
  exitcod, bread, avail: cardinal;
  sSym: string;
begin

  Application.CreateForm(TTSplashForm, tSplashForm);
  tSplashForm.ProgressBar1.Visible := False;
  tSplashForm.ProgressBar1.Min := 0;
  tSplashForm.ProgressBar1.Max := 0;
  tSplashForm.olMensage.Visible := False;
  sSym := '/';
  Result := '';
  sa.lpSecurityDescriptor := nil;
  sa.nLength := SizeOf(SECURITY_ATTRIBUTES);
  sa.bInheritHandle := True;
  if CreatePipe(newstdin, write_stdin, @sa, 0) then
  begin
    if CreatePipe(read_stdout, newstdout, @sa, 0) then
    begin
      GetStartupInfo(si);
      with si do
      begin
        dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
        wShowWindow := SW_HIDE;
        hStdOutput := newstdout;
        hStdError := newstdout;
        hStdInput := newstdin;
      end;
      FillChar(Buffer, SizeOf(Buffer), 0);
      GetEnvironmentVariable('COMSPEC', @Buffer, SizeOf(Buffer) - 1);
      StrCat(@Buffer, PChar(' /c ' + comando));
      if CreateProcess(nil, @Buffer, nil, nil, True, CREATE_NEW_CONSOLE, nil, nil, si, pi) then
      begin
        tSplashForm.Show;
        tSplashForm.olMensage.Visible := True;
        repeat
          PeekNamedPipe(read_stdout, @Buffer, SizeOf(Buffer) - 1, @bread, @avail, nil);
          if bread > 0 then
          begin
            FillChar(Buffer, SizeOf(Buffer), 0);
            ReadFile(read_stdout, Buffer, bread, bread, nil);
            Result := Result + string(PChar(@Buffer));
          end;
          if sSym = '/' then
            sSym := '-'
          else if sSym = '-' then
            sSym := '\'
          else if sSym = '\' then
            sSym := '/';
          tSplashForm.olMensage.Caption := sSym + 'Espere un momento por favor, mientras se ejecuta el comando:..';
          tSplashForm.Update;
          Application.ProcessMessages;
          GetExitCodeProcess(pi.hProcess, exitcod);
          sleep(80);
        until (exitcod <> STILL_ACTIVE) and (bread = 0);
      end;
      tSplashForm.Free;
      CloseHandle(read_stdout);
      CloseHandle(newstdout);
    end;
    CloseHandle(newstdin);
    CloseHandle(write_stdin);
  end;
end;

function TfUtilesV20.InstallINF(const PathName: string; hParent: HWND): Boolean;
var
  instance: HINST;
begin { InstallINF }
  instance := ShellExecute(hParent, PChar('open'), PChar('rundll32.exe'),
    PChar('setupapi,InstallHinfSection DefaultInstall 132 ' + PathName), nil, SW_HIDE);

  Result := instance > 32
end; { InstallINF }

{ -----------------------------Working S.O. enviroment variables-----------------------------------
  Este juego de funciones se utiliza para leer y escribir las variables de usuario o de seystema
  del sistema operativo, estas variables son las que ves cuando escrives en la la caja de comandos
  del DOS "path" y te devuelve las variables del sistemas con sus respectivos valores actuales.
  Este juego de funciones se utilisa para añadir o alterar esos valores.
  -------------------------------------------------------------------------------------------------- }
function TfUtilesV20.GetUserEnvironmentVariable(const name: string): string;
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('Environment', False);
      Result := ReadString(name);
    finally
      Free
    end
end;

procedure TfUtilesV20.SetUserEnvironmentVariable(const name, Value: string);
var
  rv: DWORD;
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('Environment', False);
      writeString(name, Value);
      SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, 0, LParam(PChar('Environment')), SMTO_ABORTIFHUNG, 5000, rv);
    finally
      Free
    end
end;

{
  The next two procedures read and write environment variables for the
  system and thus affect all users.
}
function TfUtilesV20.GetSystemEnvironmentVariable(const name: string): string;
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('SYSTEM\CurrentControlSet\Control\Session ' + 'Manager\Environment', False);
      Result := ReadString(name);
    finally
      Free
    end
end;

// Modified from
// http://www.delphiabc.com/TipNo.asp?ID=117
// The original article did not include the space in
// "Session Manager" which caused the procedure TfUtilesV20.to fail.
procedure TfUtilesV20.SetSystemEnvironmentVariable(const name, Value: string);
var
  rv: DWORD;
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('SYSTEM\CurrentControlSet\Control\Session ' + 'Manager\Environment', False);
      writeString(name, Value);
      SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, 0, LParam(PChar('Environment')), SMTO_ABORTIFHUNG, 5000, rv);
    finally
      Free
    end
end;

{ ********************************************* }
{ Set Global Environment function TfUtilesV20. }
{ Coder : Kingron,2002.8.6 }
{ Bug Report : Kingron@163.net }
{ Test OK For Windows 2000 Advance Server }
{ Parameter: }
{ Name : environment variable name }
{ Value: environment variable Value }
{ Ex: SetGlobalEnvironment('MyVar','OK') }
{ ********************************************* }
function TfUtilesV20.SetGlobalEnvironment(const name, Value: string;

  const User: Boolean = True): Boolean;
resourcestring
  REG_MACHINE_LOCATION = 'System\CurrentControlSet\Control\Session Manager\Environment';
  REG_USER_LOCATION = 'Environment';
begin
  with TRegistry.Create do
    try
      if User then { User Environment Variable }
        Result := OpenKey(REG_USER_LOCATION, True)
      else { System Environment Variable }
      begin
        RootKey := HKEY_LOCAL_MACHINE;
        Result := OpenKey(REG_MACHINE_LOCATION, True);
      end;
      if Result then
      begin
        writeString(Name, Value); { Write Registry for Global Environment }
        { Update Current Process Environment Variable }
        SetEnvironmentVariable(PChar(Name), PChar(Value));
        { Send Message To All Top Window for Refresh }
        SendMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0, integer(PChar('Environment')));
      end;
    finally
      Free;
    end;
end;
{ SetGlobalEnvironment }
{ -----------------------------Working S.O. enviroment variables------------------------------- }

{ -----------------------------------------------------------------------------------------------
  Esta función determina si el usuario del computador tiene privilegios de administrador del
  sistema.
  ------------------------------------------------------------------------------------------------ }
function TfUtilesV20.IsAdmin: Boolean;
const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS = $00000220;
  SE_GROUP_ENABLED = $00000004;
var
  hAccessToken: THandle;
  ptgGroups: PTokenGroups;
  dwInfoBufferSize: DWORD;
  psidAdministrators: PSID;
  X: integer;
  bSuccess: BOOL;
begin
  Result := False;
  bSuccess := OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True, hAccessToken);
  if not bSuccess then
    if GetLastError = ERROR_NO_TOKEN then
      bSuccess := OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, hAccessToken);
  if bSuccess then
  begin
    GetTokenInformation(hAccessToken, TokenGroups, nil, 0, dwInfoBufferSize);
    ptgGroups := GetMemory(dwInfoBufferSize);
    bSuccess := GetTokenInformation(hAccessToken, TokenGroups, ptgGroups, dwInfoBufferSize, dwInfoBufferSize);
    CloseHandle(hAccessToken);
    if bSuccess then
    begin
      AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2, SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0,
        psidAdministrators);
{$R-}
      for X := 0 to ptgGroups.GroupCount - 1 do
      begin
        if (SE_GROUP_ENABLED = (ptgGroups.Groups[X].Attributes and SE_GROUP_ENABLED)) and
          EqualSid(psidAdministrators, ptgGroups.Groups[X].Sid) then
        begin
          Result := True;
          break;
        end;
      end;
{$R+}
      FreeSid(psidAdministrators);
    end;
    FreeMem(ptgGroups);
  end;
end;

{ -----------------------------------------------------------------------------------------------
  Esta función crear uan carpeta temporal de trabajo en el sistema con el nombre de "cTMP_Database"
  que generalmente es "TMP".
  ------------------------------------------------------------------------------------------------ }
function TfUtilesV20.Set_Tmp_Database(): Boolean;
begin
  Result := Execute_SQL_Command('CREATE DATABASE IF NOT EXISTS `' + trim(cTMP_Database) +
    '` /*!40100 CHARACTER SET utf8 COLLATE utf8_general_ci */;');
end;

{ -----------------------------------------------------------------------------------------------
  Esta función el mandas el archivo y escribe la vesión de FACIL en él.
  ------------------------------------------------------------------------------------------------ }
procedure TfUtilesV20.TxtFile_Write_version(FileName: string; cFull_AppName: string);
begin
end;

{ -----------------------------------------------------------------------------------------------
  Esta función determina si una cadena contiene sólo números
  ------------------------------------------------------------------------------------------------ }
function TfUtilesV20.IsStrANumber(const S: string): Boolean;
var
  p: PChar;
begin
  p := PChar(S);
  Result := False;
  while p^ <> #0 do
  begin
    if not(p^ in ['0' .. '9']) then
      exit;
    inc(p);
  end;
  Result := True;
end;

function TfUtilesV20.strTran(cText, cfor, cwith: string): string;
var
  ntemp: Word;
  nreplen: Word;
begin
  cfor := UpperCase(cfor);
  nreplen := Length(cfor);
  for ntemp := 1 to Length(cText) do
  begin
    if (UpperCase(Copy(cText, ntemp, nreplen)) = cfor) then
    begin
      delete(cText, ntemp, nreplen);
      Insert(cwith, cText, ntemp);
    end;
  end;
  Result := cText;
end;

{ -----------------------------------------------------------------------------------------------
  Esta función sólo funciona para datos numéricos he indica si un valor esta en el rango indicado
  ------------------------------------------------------------------------------------------------ }
function TfUtilesV20.between(nval, nmin, nmax: Longint): Boolean;
begin
  Result := False;
  if (nval >= nmin) and (nval <= nmax) then
    Result := True;
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion convierte de segundos a horas en formato 'hh:mm:ss'.
  ------------------------------------------------------------------------------------------------ }
function TfUtilesV20.SecToTime(Sec: integer): string;
var
  H, m, S: string;
  ZH, ZM, ZS: integer;
begin
  ZH := Sec div 3600;
  ZM := Sec div 60 - ZH * 60;
  ZS := Sec - (ZH * 3600 + ZM * 60);
  H := IntToStr(ZH);
  m := IntToStr(ZM);
  S := IntToStr(ZS);
  Result := H + ':' + m + ':' + S;
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion puede sumar o restar a una hora 'hh:mm:ss' cualquier valor dependiendo el parametro
  de intervalo y el valor, el resultado se entrega en formato  'hh:mm:ss'.
  ------------------------------------------------------------------------------------------------ }
function TimeADD(cTime: string; nInterval: integer; nValue: integer): string; overload;
var
  oQry_Gen: TFDQuery;
  cSql_Line: string;
  cInterval: string;
begin
  case nInterval of
    1:
      begin
        cInterval := 'SECOND';
      end;
    2:
      begin
        cInterval := 'MINUTE';
      end;
    3:
      begin
        cInterval := 'HOUR';
      end;
  end;
  cSql_Line := 'SELECT DATE_FORMAT(DATE_ADD("2000-01-01 ' + cTime + '",INTERVAL ' + IntToStr(nValue) + ' ' + cInterval +
    '),"%T") AS xTime ';
  Exec_Select_SQL(oQry_Gen, cSql_Line, True, True);
  Result := oQry_Gen.FieldByName('xTime').AsString;
  freeandnil(oQry_Gen);
end;

function TimeADD(TDateTime: TDateTime; nInterval: integer; nValue: integer): string; overload;
var
  oQry_Gen: TFDQuery;
  cSql_Line: string;
  cInterval: string;
  cDateTime: string;
begin
  cDateTime := FormatDateTime('yyyy-mm-dd Hh:mm:ss', TDateTime);
  case nInterval of
    1:
      begin
        cInterval := 'SECOND';
      end;
    2:
      begin
        cInterval := 'MINUTE';
      end;
    3:
      begin
        cInterval := 'HOUR';
      end;
  end;
  cSql_Line := 'SELECT DATE_FORMAT(DATE_ADD("' + cDateTime + '",INTERVAL ' + IntToStr(nValue) + ' ' + cInterval + '),"%T") AS xTime ';
  if Exec_Select_SQL(oQry_Gen, cSql_Line, True, True) = True then
    Result := oQry_Gen.FieldByName('xTime').AsString;
  freeandnil(oQry_Gen);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion le entregas la hora inicial y final en formato 'hh:mm:ss' y te devuelve la diferencia en
  el mismo formato.
  ------------------------------------------------------------------------------------------------ }
function TfUtilesV20.TimeDiff(cTime_Ult: string; cTime_Ant: string): string;
var
  oQry_Gen: TFDQuery;
  cSql_Line: string;
begin
  cSql_Line := 'SELECT TIMEDIFF(IFNULL("' + cTime_Ult + '","01:00:00"),IFNULL("' + cTime_Ant + '","00:00:00")) as xTime ';
  Exec_Select_SQL(oQry_Gen, cSql_Line, True, True);
  Result := oQry_Gen.FieldByName('xTime').AsString;
  freeandnil(oQry_Gen);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion le entregas una cadena 'hh:mm:ss' y te devuelve el equivalente en segundos.
  ------------------------------------------------------------------------------------------------ }
function TfUtilesV20.TimeToSecs(cTime: string): integer;
var
  oQry_Gen: TFDQuery;
  cSql_Line: string;
begin
  cSql_Line := 'SELECT TIME_TO_SEC("' + cTime + '") as xTime ';
  Exec_Select_SQL(oQry_Gen, cSql_Line, True, True);
  Result := oQry_Gen.FieldByName('xTime').AsInteger;
  freeandnil(oQry_Gen);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion le entregas los segundos y te los devuelve en formato 'hh:mm:ss'
  ------------------------------------------------------------------------------------------------ }
function TfUtilesV20.SecsToTime(nSeconds: integer): string;
var
  oQry_Gen: TFDQuery;
  cSql_Line: string;
begin
  cSql_Line := 'SELECT SEC_TO_TIME("' + IntToStr(nSeconds) + '") as xTime ';
  Exec_Select_SQL(oQry_Gen, cSql_Line, True, True);
  Result := oQry_Gen.FieldByName('xTime').AsString;
  freeandnil(oQry_Gen);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion busca el número de estación predeterminada en el el sistema y la devuelve
  también automáticamente carga la variable de estación del sistema.
  ------------------------------------------------------------------------------------------------ }
function TfUtilesV20.Get_Station_id: string;
var
  oTab_Sqll: TFDTable;
  cOp_est: string;
begin
  if bId_Estacion_Force = True then
    exit;
  if isEmpty(cId_Estacion) = False then
  begin
    Result := cId_Estacion;
    exit;
  end;
  oTab_Sqll := TFDTable.Create(nil);
  self.OpenSqlLite();
  oTab_Sqll.Connection := self.oPublicCnnSQLL;
  oTab_Sqll.TableName := 'local_conf';
  oTab_Sqll.Active := True;
  oTab_Sqll.First;
  cOp_est := oTab_Sqll.FieldByName('estacion').AsString;
  oTab_Sqll.close;
  freeandnil(oTab_Sqll);
  cId_Estacion := cOp_est;
  Result := cOp_est;
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion muestra y actualiza el número de único de secuencia de una operación.
  ------------------------------------------------------------------------------------------------ }

function TfUtilesV20.Operacion_Get_And_Update_Opid: string;
var
  oQry_Sec_CD: TFDQuery;
  cOp_idC: string;
  cOp_est: string;
  cSqlLine: string;
begin
  Get_Station_id();
  cOp_est := cId_Estacion;
  if Exec_Select_SQL(oQry_Sec_CD, 'SELECT suc_Id,no_estacion,no_operacion FROM  conf_sistema WHERE suc_Id= ' +
    QuotedStr(IntToStr(iId_Empresa)) + ' AND no_estacion= ' + QuotedStr(cId_Estacion) + ' ;', True, True) = True then
  begin
    cOp_idC := trim(IntToStr(iId_Empresa)) + trim(cOp_est) + trim(IntToStr(oQry_Sec_CD.FieldByName('no_operacion').AsInteger + 1));
    oQry_Sec_CD.close;
    freeandnil(oQry_Sec_CD);
    Result := cOp_idC;
  end
  else
  begin
    Get_Station_id();
    cSqlLine := '';
    cSqlLine := cSqlLine + 'INSERT INTO conf_sistema (suc_Id,no_estacion,no_operacion) VALUES ';
    cSqlLine := cSqlLine + '("' + IntToStr(iId_Empresa) + '","' + cId_Estacion + '",0)';
    Execute_SQL_Command(cSqlLine);
    cOp_idC := trim(IntToStr(iId_Empresa)) + trim(cOp_est) + '1';
    Result := cOp_idC;
  end;
  Execute_SQL_Command('UPDATE conf_sistema SET no_operacion = no_operacion + 1 WHERE suc_Id= ' + QuotedStr(IntToStr(iId_Empresa)) +
    ' AND no_estacion= ' + QuotedStr(cId_Estacion) + '; ');

end;

function TfUtilesV20.Operacion_Get_And_Update_CargosId(nOption: integer; bAutoSave: Boolean = True): string;
var
  oQry_Sec_CD: TFDQuery;
  nOp_Corre: integer;
  cOp_est: string;
  cSqlLine: string;
begin
  Get_Station_id();
  cOp_est := cId_Estacion;
  if bAutoSave = True then
  begin
    case nOption of
      1:
        Execute_SQL_Command('UPDATE conf_sistema SET no_cargoinv     = no_cargoinv + 1 WHERE suc_Id= ' + QuotedStr(IntToStr(iId_Empresa)) +
          ' AND no_estacion= ' + QuotedStr(cId_Estacion) + ' ;');
      2:
        Execute_SQL_Command('UPDATE conf_sistema SET no_descargoinv  = no_descargoinv + 1  WHERE suc_Id= ' + QuotedStr(IntToStr(iId_Empresa)
          ) + ' AND no_estacion= ' + QuotedStr(cId_Estacion) + ' ;');
      3:
        Execute_SQL_Command('UPDATE conf_sistema SET no_ordenprod    = no_ordenprod + 1    WHERE suc_Id= ' + QuotedStr(IntToStr(iId_Empresa)
          ) + ' AND no_estacion= ' + QuotedStr(cId_Estacion) + ' ;');
      4:
        Execute_SQL_Command('UPDATE conf_sistema SET no_cargoprod    = no_cargoprod + 1    WHERE suc_Id= ' + QuotedStr(IntToStr(iId_Empresa)
          ) + ' AND no_estacion= ' + QuotedStr(cId_Estacion) + ' ;');
      5:
        Execute_SQL_Command('UPDATE conf_sistema SET no_descargoprod = no_descargoprod + 1 WHERE suc_Id= ' + QuotedStr(IntToStr(iId_Empresa)
          ) + ' AND no_estacion= ' + QuotedStr(cId_Estacion) + ' ;');
      6:
        Execute_SQL_Command('UPDATE conf_sistema SET no_tomainv      = no_tomainv + 1      WHERE suc_Id= ' + QuotedStr(IntToStr(iId_Empresa)
          ) + ' AND no_estacion= ' + QuotedStr(cId_Estacion) + ' ;');
    end;
    if Exec_Select_SQL(oQry_Sec_CD, 'SELECT * FROM  conf_sistema WHERE suc_Id=' + QuotedStr(IntToStr(iId_Empresa)) + ' AND no_estacion= ' +
      QuotedStr(cId_Estacion) + ' ;', True, True) = True then
    begin
      case nOption of
        1:
          nOp_Corre := oQry_Sec_CD.FieldByName('no_cargoinv').AsInteger;
        2:
          nOp_Corre := oQry_Sec_CD.FieldByName('no_descargoinv').AsInteger;
        3:
          nOp_Corre := oQry_Sec_CD.FieldByName('no_ordenprod').AsInteger;
        4:
          nOp_Corre := oQry_Sec_CD.FieldByName('no_cargoprod').AsInteger;
        5:
          nOp_Corre := oQry_Sec_CD.FieldByName('no_descargoprod').AsInteger;
        6:
          nOp_Corre := oQry_Sec_CD.FieldByName('no_tomainv').AsInteger;
      end;
    end;
    Result := IntToStr(nOp_Corre);
    freeandnil(oQry_Sec_CD);
    exit;
  end
  else
  begin
    if Exec_Select_SQL(oQry_Sec_CD, 'SELECT * FROM  conf_sistema WHERE suc_Id= ' + QuotedStr(IntToStr(iId_Empresa)) + ' AND no_estacion= ' +
      QuotedStr(cId_Estacion) + ' ;', True, True) = True then
    begin
      case nOption of
        1:
          nOp_Corre := oQry_Sec_CD.FieldByName('no_cargoinv').AsInteger + 1;
        2:
          nOp_Corre := oQry_Sec_CD.FieldByName('no_descargoinv').AsInteger + 1;
        3:
          nOp_Corre := oQry_Sec_CD.FieldByName('no_ordenprod').AsInteger + 1;
        4:
          nOp_Corre := oQry_Sec_CD.FieldByName('no_cargoprod').AsInteger + 1;
        5:
          nOp_Corre := oQry_Sec_CD.FieldByName('no_descargoprod').AsInteger + 1;
        6:
          nOp_Corre := oQry_Sec_CD.FieldByName('no_tomainv').AsInteger + 1;
      end;
    end
    else
    begin
      Get_Station_id();
      cSqlLine := '';
      cSqlLine := cSqlLine + 'INSERT INTO conf_sistema (suc_Id,no_estacion) VALUES ';
      cSqlLine := cSqlLine + '("' + IntToStr(iId_Empresa) + '","' + cId_Estacion + '")';
      Execute_SQL_Command(cSqlLine);
      nOp_Corre := 1;
    end;
  end;
  Result := IntToStr(nOp_Corre);
  freeandnil(oQry_Sec_CD);
end;

{ -------------------------------------------------------------------------------------------
  Esta función toma la configuración de la computadora y setea en el sistema las variables
  de separador de decimales y miles para a partir de ahi el sistema la tome y las uses.
  J.G.G. junio 2010.
  -------------------------------------------------------------------------------------------- }
procedure TfUtilesV20.GetDefault_Decinal_Thousand_Separator;
var
  Decimal: PChar;
  Thousand: PChar;
  tmp: string;
begin
  if ((cpDecimales <> #0) and (cpThousand <> #0)) then
    exit;

  Decimal := StrAlloc(10);
  GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_SDECIMAL, Decimal, 10);
  tmp := Decimal;
  FormatSettings.DecimalSeparator := tmp[1];
  cpDecimales := tmp[1];

  Thousand := StrAlloc(10);
  GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_STHOUSAND, Thousand, 10);
  tmp := Thousand;
  FormatSettings.ThousandSeparator := tmp[1];
  cpThousand := tmp[1];
end;

{ -----------------------------------------------------------------------------------------------------
  El sistema contiene en una de sus tablas almacenada la notación de separador de miles y decimales
  esta información cuando el sistema inicia se carga en dos variables.
  en esta funcion se toma el valor de esas variables y se les asigna al la configuracion del software.
  J.G.G. junio 2010.
  ------------------------------------------------------------------------------------------------------ }
procedure TfUtilesV20.Set_Decinal_Thousand_Separator;
begin
  FormatSettings.DecimalSeparator := cpDecimales;
  FormatSettings.ThousandSeparator := cpThousand;
end;

{ -------------------------------------------------------------------------------------------
  Devido a que esta funciona manda error cuando la totacion de decimales es coma ",", hemos
  creado esta funcion que lo que hace es colocar en punto '.' la notacion de decimales, hacer
  la operación y luego lo vuelve a colocar como estab en el sistema anteriormente
  J.G.G. julio 2010.
  -------------------------------------------------------------------------------------------- }
function TfUtilesV20.FloatToStr2(Value: extended): string;
begin
  FormatSettings.DecimalSeparator := '.';
  Result := floattostr(Value);
  Set_Decinal_Thousand_Separator;
end;

{ -------------------------------------------------------------------------------------------------
  Estas funciones que acabamos de presentar siempre redondean el último dígito entero, pero a veces
  necesitamos redondear por ejemplo la segunda cifra decimal o los miles, millones y billones. La siguiente función realiza un "redondeo normal" tomando un parámetro adicional para indicar el dígito a ser redondeado:
  // RoundD(123.456, 0) = 123.00
  // RoundD(123.456, 2) = 123.46
  // RoundD(123456, -3) = 123000
}
function TfUtilesV20.RoundD(X: extended; d: integer): extended;
var
  n: extended;
begin
  n := IntPower(10, d);
  X := X * n;
  Result := (int(X) + int(Frac(X) * 2)) / n;
end;

{ -------------------------------------------------------------------------------------------------
  esta funcion es original de Foxpro/Visual Foxpro, le agregas una lista de elementos y te devuelve
  true si la cadena contiene alguno de los elementos de la lista y false si no lo tiene.
  ejemplo de uso:

  VariableTexto:='gato';
  if Inlist(VariableTexto,['perro','gato','canario'])=true then
  begin
  //es un gato
  .....
  end;
  -------------------------------------------------------------------------------------------------- }
function TfUtilesV20.Inlist(aCadena: string; aLista: array of string): Boolean;
var
  i: integer;
begin
  Result := False;
  for i := Low(aLista) to High(aLista) do
  begin
    if UpperCase(aCadena) = UpperCase(aLista[i]) then
    begin
      Result := True;
      break;
    end
    else
      Result := False;
  end;
end;

procedure TfUtilesV20.SaveStringToFile(const Path, Data: string);
var
  fp: file of Byte;
begin
  AssignFile(fp, Path);
  FileMode := fmOpenWrite;
  Rewrite(fp);
  try
    BlockWrite(fp, Pointer(Data)^, Length(Data));
  finally
    CloseFile(fp);
  end;
end;

function TfUtilesV20.Ctrl_Resize: Boolean;
begin
  if oSetting_Fac.ResizeScrn = 0 then
    Result := False
  else
    Result := True
end;

procedure TfUtilesV20.PrintLineToGeneric(const line: string);
// Uses WinSpool;
var
  BytesWritten: DWORD;
  hPrinter: THandle;
  DocInfo: TDocInfo1;
const
  GenericPrinter: PChar = 'Factura';
  // Change to systems generic drivers name
begin
  if not OpenPrinter(GenericPrinter, hPrinter, nil) then
    raise Exception.Create('Printer not found');
  try
    DocInfo.pDocName := 'MyDocument';
    DocInfo.pOutputFile := nil;
    DocInfo.pDataType := 'RAW';
    if StartDocPrinter(hPrinter, 1, @DocInfo) = 0 then
      Abort;
    try
      if not StartPagePrinter(hPrinter) then
        Abort;
      try
        if not WritePrinter(hPrinter, @line[1], Length(line), BytesWritten) then
          Abort;
      finally
        EndPagePrinter(hPrinter);
      end;
    finally
      EndDocPrinter(hPrinter);
    end;
  finally
    ClosePrinter(hPrinter);
  end;
end;

function TfUtilesV20.CadLongitudFija(cadena: string; longitud: integer; posicionIzquierda: Boolean; valorRelleno: string): string;
var
  i: integer;
begin
  if Length(cadena) > longitud then
    cadena := Copy(cadena, 1, longitud)
  else
  begin
    for i := 1 to longitud - Length(cadena) do
      if posicionIzquierda then
        cadena := valorRelleno + cadena
      else
        cadena := cadena + valorRelleno;
  end;
  Result := cadena;
end;

function TfUtilesV20.CenterText(nWidth: integer; sText: string): string;
var
  nSpaces: integer;
begin
  nSpaces := (nWidth - Length(sText)) div 2;
  Result := Replicate(' ', nSpaces) + sText;
end;

procedure TfUtilesV20.PrintLineOnDotMatrix(cPrinterName: string; cDocName: string; cString: string; bDobleCarr: Boolean;
  bTest: Boolean = False);
// Uses WinSpool;
var
  handle: THandle;
  n: DWORD;
  DocInfo1: TDocInfo1;
  cText: string;
begin
  if not OpenPrinter(PChar(cPrinterName), handle, nil) then
  begin
    showmessage('Impresora «[' + cPrinterName + ']» No encontrada.');
    exit;
  end;

  with DocInfo1 do
  begin
    pDocName := PChar(cDocName);
    pOutputFile := nil;
    pDataType := 'RAW';
  end;

  StartDocPrinter(handle, 1, @DocInfo1);

  if bTest = True then
  begin
    cText := '1234567890123456789012345678901234567890' + #13 + #10;
    WritePrinter(handle, PChar(cText), Length(cText), n);
    exit;
  end;
  if bDobleCarr = False then
    cText := CadLongitudFija(cString, 40, False, ' ') + #13 + #10
  else
    cText := CadLongitudFija(cString, 40, False, ' ') + ' ' + CadLongitudFija(cString, 39, False, ' ') + #13 + #10;

  WritePrinter(handle, PChar(cText), Length(cText), n);

  EndPagePrinter(handle);
  EndDocPrinter(handle);

  ClosePrinter(handle);
end;

function TfUtilesV20.SeEjecutaEnInicio(NombreEjecutable: string; SoloUnaVez, SoloUsuario: Boolean): Boolean;
{
  ENTRADA:
  NombreEjecutable    = Nombre del ejecutable a comprobar
  SoloUnaVez          = TRUE  para comprobar sólo el siguiente arranque
  FALSE para comprobar la ejecucion en todos los arranques
  SoloUsuario         = TRUE para comprobar sólo en el usuario en curso

  SALIDA:
  Devuelve TRUE si el programa se encuentra en el regitro, en la clave:
  HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run ó RunOnce ó bien en la clave
  HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run ó RunOnce en funcion de la ENTRADA
}
var
  Registro: TRegistry;
  RegInfo: TRegDataInfo;
  clave: string;
  Valores: TStringList;
  n: integer;

begin
  Result := False;
  clave := 'Software\Microsoft\Windows\CurrentVersion\Run';
  if SoloUnaVez then
    clave := clave + 'Once';

  Registro := TRegistry.Create;
  try
    // Seleccionamos HKEY_LOCAL_MACHINE o bien si no la cambiamos, se queda
    // HKEY_CURRENT_USER que es la clave por defecto al crear un TRegistry
    if not SoloUsuario then
      Registro.RootKey := HKEY_LOCAL_MACHINE;

    // Abrimos la clave en cuestión:
    if not Registro.OpenKey(clave, False) then
      raise Exception.Create('Error: No se pudo abrir la clave ' + clave + ' del registro de windows');

    Valores := TStringList.Create;
    try
      // Obtenemos una lista de los Nombres de los valores de la clave
      Registro.GetValueNames(Valores);

      // Comprobamos si esos valores son string, si lo son, los leemos, sino, lo borramos de la lista:
      for n := 0 to Pred(Valores.Count) do
      begin
        // Comprobamos si se trata de un valor string:
        if Registro.GetDataInfo(Valores[n], RegInfo) then
        begin
          if (RegInfo.RegData = rdString) then
          begin
            if Lowercase(NombreEjecutable) = Lowercase(Registro.ReadString(Valores[n])) then
            begin
              Result := True;
              break;
            end;
          end;
        end
        else
          Valores[n] := '';
      end; // for n

    finally
      Valores.Free;
    end;
  finally
    Registro.Free;
  end;
end; // SeEjecutaEnInicio

procedure TfUtilesV20.EjecutarEnInicio(NombrePrograma, NombreEjecutable: string; SoloUnaVez, SoloUsuario: Boolean);
{
  COMETIDO DE LA PROCEDURE:
  Añade un programa en el registro de Windows, para que se ejecute cuando Windows arranque.
  Se puede seleccionar que se arranque siempre o sólo una vez en el siguiente arranque y tambien
  si ha de ejecutarse en cada arranque de máquina o bien cuando el usuario en curso abra una sesion

  ENTRADA:
  NombrePrograma      = Nombre del programa
  NombreEjecutable    = Nombre del ejecutable del programa con el path completo
  SoloUnaVez          = TRUE  para comprobar sólo el siguiente arranque
  FALSE para comprobar la ejecucion en todos los arranques
  SoloUsuario         = TRUE para comprobar sólo en el usuario en curso
}

var
  Registro: TRegistry;
  clave: string;
begin
  clave := 'Software\Microsoft\Windows\CurrentVersion\Run';
  if SoloUnaVez then
    clave := clave + 'Once';

  Registro := TRegistry.Create;
  try
    // Seleccionamos HKEY_LOCAL_MACHINE o bien si no la cambiamos, se queda
    // HKEY_CURRENT_USER que es la clave por defecto al crear un TRegistry
    if not SoloUsuario then
      Registro.RootKey := HKEY_LOCAL_MACHINE;

    // Abrimos la clave en cuestión:
    if not Registro.OpenKey(clave, False) then
      raise Exception.Create('Error: No se pudo abrir la clave ' + clave + ' del registro de windows');
    // Escribimos el valor para que se arranque el programa especificado:
    Registro.writeString(NombrePrograma, NombreEjecutable);
  finally
    Registro.Free;
  end;
end;
// procedure TfUtilesV20.EjecutarEnInicio

procedure TfUtilesV20.QuitarEjecutarEnInicio(NombreEjecutable: string; SoloUnaVez, SoloUsuario: Boolean);
{
  COMETIDO DE LA PROCEDURE:
  Si el ejecutable 'NombreEjecutable' esta en el registro de Windows, en la clave
  que hace que se ejecute en cada arranque de Windows, la funcion lo borra de ahí.


  ENTRADA:
  NombreEjecutable    = Nombre del ejecutable del programa con el path completo
  SoloUnaVez          = TRUE  para borrar sólo del siguiente arranque
  FALSE para borrar la ejecucion en todos los arranques
  SoloUsuario         = TRUE para borrar sólo en el usuario en curso
}
var
  Registro: TRegistry;
  RegInfo: TRegDataInfo;
  clave: string;
  Valores: TStringList;
  n: integer;
begin
  clave := 'Software\Microsoft\Windows\CurrentVersion\Run';
  if SoloUnaVez then
    clave := clave + 'Once';

  Registro := TRegistry.Create;
  try
    // Seleccionamos HKEY_LOCAL_MACHINE o bien si no la cambiamos, se queda
    // HKEY_CURRENT_USER que es la clave por defecto al crear un TRegistry
    if not SoloUsuario then
      Registro.RootKey := HKEY_LOCAL_MACHINE;

    // Abrimos la clave en cuestión:
    if not Registro.OpenKey(clave, False) then
      raise Exception.Create('Error: No se pudo abrir la clave ' + clave + ' del registro de windows');

    Valores := TStringList.Create;
    try
      // Obtenemos una lista de los Nombres de los valores de la clave
      Registro.GetValueNames(Valores);

      // Comprobamos si el nombre del ejecutable figura en alguno de los valores
      for n := 0 to Pred(Valores.Count) do
      begin
        // Comprobamos si se trata de un valor string:
        if Registro.GetDataInfo(Valores[n], RegInfo) then
        begin
          if (RegInfo.RegData = rdString) then
          begin
            if Lowercase(NombreEjecutable) = Lowercase(Registro.ReadString(Valores[n])) then
            begin
              // Si figura, borramos ese valor
              Registro.DeleteValue(Valores[n]);
            end;
          end;
        end;
      end; // for n

    finally
      Valores.Free;
    end;
  finally
    Registro.Free;
  end;
end; // procedure TfUtilesV20.QuitarEjecutarEnInicio
{
  //Comprobar si un programa se ejecuta en cada arranque de la máquina:
  if SeEjecutaEnInicio( 'c:\winnt\notepad.exe', FALSE, FALSE) then
  ShowMessage('Si, se ejecuta en cada arranque')
  else
  ShowMessage('NO, NO se ejecuta en cada arranque');

  //Hacer que se ejecute el Notepad.exe en cada arranque para todos los usuarios:
  EjecutarEnInicio('Block de Notas', 'c:\winnt\notepad.exe', FALSE, FALSE);

  //Hacer que deje de ejecutarse el Notepad.exe de cada arranque:
  QuitarEjecutarEnInicio('c:\winnt\notepad.exe', FALSE, FALSE);
}

procedure TfUtilesV20.OpcionesApagarWindows(Sender: TObject);
var
  Shell: OleVariant;

begin
  Shell := CreateOleObject('shell.application');
  Shell.ShutDownWindows;
end;

procedure TfUtilesV20.CierraSessionWindows;
begin
  ExitWindowsEx(0, 0);
  { EWX_LOGOFF - Cierra los procesos y la sesión del usuario. }
end;

procedure TfUtilesV20.ReiniciaWindows;
begin
  ExitWindowsEx(2, 0);
  { EWX_REBOOT - Reboot. Debes tener privilegio SE_SHUTDOWN_NAME }
end;

procedure TfUtilesV20.Poner_Facil_De_Inicio_Windows(pCierraSession: Boolean = True);
var
  cApp_Name: string;
begin
  cApp_Name := UpperCase(ExtractFileName(Application.ExeName));
  EjecutarEnInicio('RCTECH ' + cApp_Name, UpperCase(Application.ExeName), False, True);
  if pCierraSession = True then
    CierraSessionWindows;
end;

{ ********************************************************************* }
{ Strip('L',' ',' bob') returns 'bob' }
{ Strip('R','5','56345') returns '5634' }
{ Strip('B','H','HASH') returns 'as' }
{ strip('A','E','fleetless') returns fltlss }
{ ********************************************************************* }

function TfUtilesV20.Strip(L, c: Char; Str: string): string;
{ L is left,center,right,all,ends }
var
  i: Byte;
begin
  case Upcase(L) of
    'L':
      begin { Left }
        while (Str[1] = c) and (Length(Str) > 0) do
          delete(Str, 1, 1);
      end;
    'R':
      begin { Right }
        while (Str[Length(Str)] = c) and (Length(Str) > 0) do
          delete(Str, Length(Str), 1);
      end;
    'B':
      begin
        { Both left and right }
        while (Str[1] = c) and (Length(Str) > 0) do
          delete(Str, 1, 1);
        while (Str[Length(Str)] = c) and (Length(Str) > 0) do
          delete(Str, Length(Str), 1);
      end;
    'A':
      begin { All }
        i := 1;
        repeat
          if (Str[i] = c) and (Length(Str) > 0) then
            delete(Str, i, 1)
          else
            i := succ(i);
        until (i > Length(Str)) or (Str = '');
      end;
  end;
  Strip := Str;
end; { Func Strip }

function fields_info(var oQryFlds: TFDQuery; field: string = '*'; DBName: string = ''; TableName: string = ''): Boolean; overload;
var
  cSqlCmdl: string;
begin
  with fUtilesV20 do
  begin
    if oQryFlds = nil then
    begin
      Result := False;
      exit;
    end;

    cSqlCmdl := '';
    cSqlCmdl := cSqlCmdl + 'SELECT * ';
    cSqlCmdl := cSqlCmdl + 'FROM `information_schema`.`COLUMNS` ';
    cSqlCmdl := cSqlCmdl + 'WHERE  TABLE_NAME   = "' + TableName + '" ';
    cSqlCmdl := cSqlCmdl + 'AND  TABLE_SCHEMA = "' + DBName + '" ';
    if trim(field) <> '*' then
      cSqlCmdl := cSqlCmdl + 'AND  COLUMN_NAME  = "' + field + '" ';
    if Exec_Select_SQL(oQryFlds, cSqlCmdl, True, False, False) = True then
      Result := True
    else
      Result := False;
  end;
end;

function fields_info(oConn_Tmp: TFDConnection; var oQryFlds: TFDQuery; field: string = '*'; DBName: string = ''; TableName: string = '')
  : Boolean; overload;
var
  cSqlCmdl: string;
begin
  with fUtilesV20 do
  begin

    if oQryFlds = nil then
    begin
      Result := False;
      exit;
    end;

    cSqlCmdl := '';
    cSqlCmdl := cSqlCmdl + 'SELECT * ';
    cSqlCmdl := cSqlCmdl + 'FROM `information_schema`.`COLUMNS` ';
    cSqlCmdl := cSqlCmdl + 'WHERE  TABLE_NAME   = "' + TableName + '" ';
    cSqlCmdl := cSqlCmdl + 'AND  TABLE_SCHEMA = "' + DBName + '" ';
    if trim(field) <> '*' then
      cSqlCmdl := cSqlCmdl + 'AND  COLUMN_NAME  = "' + field + '" ';
    if Exec_Select_SQL(oConn_Tmp, oQryFlds, cSqlCmdl, True, False, False) = True then
      Result := True
    else
      Result := False;
  end;
end;

procedure TfUtilesV20.DataRefresh(var oDataset: Tdataset; pfield_Name: string);
var
  oldKey: integer;
begin
  oldKey := oDataset.FieldByName(pfield_Name).AsInteger;
  oDataset.Refresh;
  oDataset.Locate(pfield_Name, oldKey, []);
end;

{ ************************************************
  // procedure TfUtilesV20.AppendCurrent
  // Written By: Steve Zimmelman
  //
  // Will append an exact copy of the current
  // record of the dataset that is passed into
  // the procedure TfUtilesV20.and will return the dataset
  // in edit state with the record pointer on
  // the currently appended record.
  ************************************************ }
procedure TfUtilesV20.AppendCurrent(DataSet: Tdataset);
var
  aField: variant;
  i: integer;
begin
  // Create a variant Array
  aField := VarArrayCreate([0, DataSet.Fieldcount - 1], VarVariant);
  // read values into the array
  for i := 0 to (DataSet.Fieldcount - 1) do
  begin
    aField[i] := DataSet.Fields[i].Value;
  end;
  DataSet.Append;
  // Put array values into new the record
  for i := 0 to (DataSet.Fieldcount - 1) do
  begin
    DataSet.Fields[i].Value := aField[i];
  end;
end;

// Save a TStringGrid to a file
procedure TfUtilesV20.SaveStringGrid(StringGrid: TStringGrid; const FileName: TFileName);
var
  f: textfile;
  i, k: integer;
begin
  AssignFile(f, FileName);
  Rewrite(f);
  with StringGrid do
  begin
    // Write number of Columns/Rows
    WriteLn(f, ColCount);
    WriteLn(f, RowCount);
    // loop through cells
    for i := 0 to ColCount - 1 do
    begin
      for k := 0 to RowCount - 1 do
      begin
        WriteLn(f, Cells[i, k]);
      end;
    end;
  end;
  CloseFile(f);
end;

// Load a TStringGrid from a file
procedure TfUtilesV20.LoadStringGrid(StringGrid: TStringGrid; const FileName: TFileName);
var
  f: textfile;
  iTmp, i, k: integer;
  strTemp: string;
begin
  AssignFile(f, FileName);
  Reset(f);
  with StringGrid do
  begin
    // Get number of columns
    Readln(f, iTmp);
    ColCount := iTmp;
    // Get number of rows
    Readln(f, iTmp);
    RowCount := iTmp;
    // loop through cells & fill in values
    for i := 0 to ColCount - 1 do
    begin
      for k := 0 to RowCount - 1 do
      begin
        Readln(f, strTemp);
        Cells[i, k] := strTemp;
      end;
    end;
  end;
  CloseFile(f);
end;

function TfUtilesV20.ReplaceDatePart(pDateTime: TDateTime; pDateReplace: TDateTime): TDateTime;
var
  oDay, oMonth, oYear, oHour, oMinute, oSecond, oMilli: Word;
  rDay, rMonth, rYear: Word;
begin
  DecodeDateTime(pDateTime, oYear, oMonth, oDay, oHour, oMinute, oSecond, oMilli);
  DecodeDate(pDateReplace, rYear, rMonth, rDay);
  Result := EncodeDateTime(rYear, rMonth, rDay, oHour, oMinute, oSecond, oMilli);
end;

function TfUtilesV20.TimeToDateTime(pTime: Ttime): TDateTime;
begin
  Result := StrToDateTime(FormatDateTime('yyyy-mm-dd', Now) + ' ' + TimeToStr(pTime));
end;

function TfUtilesV20.esPrimo(X: integer): Boolean;
var
  i, r: Longint;
begin
  r := Round(sqrt(X));
  for i := 2 to r do
    if (X mod i = 0) then
    begin
      esPrimo := False;
      exit;
    end;
  esPrimo := True;
end;

function TfUtilesV20.Par2(Num: integer): Boolean;
begin
  if Num mod 2 = 0 then
    Result := True
  else
    Result := False;
end;

function TfUtilesV20.par(n: integer): Boolean;
asm
  and ax,1
  dec ax
end;

function TfUtilesV20.GetProgramFilesDir2: string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion', False);
    Result := Reg.ReadString('ProgramFilesDir');
  finally
    Reg.Free;
  end;
end;

function TfUtilesV20.tiempo_Transcurrido(pStartTime: DWORD; pEndTime: DWORD): string;
var
  ElapsedTime: DWORD;
  Estimated_hours: DWORD;
  Estimated_Minutes: DWORD;
  Estimated_seconds: DWORD;
begin
  ElapsedTime := pEndTime - pStartTime;
  // calculo de horas minutos y segundos
  Estimated_hours := (ElapsedTime div (3600 * 999)) mod 24;
  Estimated_Minutes := (ElapsedTime div (60 * 999)) mod 60;
  Estimated_seconds := (ElapsedTime div 999) mod 60;
  if (Estimated_hours + Estimated_Minutes) = 0 then
    Result := 'Tiempo Transcurrido: ' + IntToStr(Estimated_seconds) + ' Segundos. '
  else
    Result := 'Tiempo Transcurrido: ' + IntToStr(Estimated_hours) + ':' + IntToStr(Estimated_Minutes) + ':' + IntToStr(Estimated_seconds);
end;

function TfUtilesV20.MapNetworkDriveDLG(const handle: THandle; const uncPath: string): string;
{ Usage: MapNetworkDrive(Application.Handle, '\\server\shared-folder'); }
{ returns mapped drive ("z:") on success or uncPath on failure / cancel }
var
  cds: TConnectDlgStruct;
  netResource: TNetResource;
begin
  Result := uncPath;

  ZeroMemory(@netResource, SizeOf(TNetResource));
  netResource.dwType := RESOURCETYPE_DISK;
  netResource.lpRemoteName := PChar(uncPath);

  cds.cbStructure := SizeOf(TConnectDlgStruct);
  cds.hwndOwner := handle;
  cds.lpConnRes := @netResource;
  cds.dwFlags := CONNDLG_PERSIST;

  if WNetConnectionDialog1(cds) = NO_ERROR then
    Result := Chr(-1 + Ord('A') + cds.dwDevNum) + DriveDelim;
end;

function TfUtilesV20.Get_File_Size2(sFileToExamine: string): integer;
var
  SearchRec: TSearchRec;
  sgPath: string;
  inRetval, I1: integer;
begin
  sgPath := ExpandFileName(sFileToExamine);
  try
    inRetval := FindFirst(ExpandFileName(sFileToExamine), faAnyfile, SearchRec);
    if inRetval = 0 then
      I1 := SearchRec.Size
    else
      I1 := -1;
  finally
    FindClose(SearchRec);
  end;
  Result := I1;
end;

function TfUtilesV20.isValidPath(Value: string): Boolean;
var
  S: string;
  i: integer;
begin
  S := UpperCase(trim(Value));
  if (S[1] in ['A' .. 'Z']) and (S[2] = ':') and (S[3] = '\') then
  begin
    Result := True;
    for i := 4 to Length(S) do
      if S[i] in [#0 .. #31, #34, #42, #47, #58, #60, #62, #63] then
        Result := False
  end
  else
    Result := False;
end;

procedure TfUtilesV20.FormTransparence(oForm: Tform; iLimit: integer = 0);
var
  CloseValue, Transparency: 0 .. 255;
begin
  if oForm.AlphaBlend = False then
  begin
    oForm.AlphaBlendValue := 255;
    oForm.AlphaBlend := True;
  end;
  Transparency := oForm.AlphaBlendValue;
  for CloseValue := Transparency downto iLimit do
  begin
    oForm.AlphaBlendValue := CloseValue;
    self.Delay(10);
    Application.ProcessMessages;
  end;
end;

procedure TfUtilesV20.FormDegrade(oForm: Tform);
var
  i, Rows: integer;
begin
  Rows := oForm.ClientHeight div 24;
  for i := 0 to 24 do
  begin
    oForm.Canvas.Brush.Color := RGB(255 - (i * 2), 255 - i, 255);
    oForm.Canvas.FillRect(Rect(0, Rows * i, oForm.ClientWidth, Rows * i * 2))
  end;
end;

function TfUtilesV20.GetUNCName(const LocalPath: string): string;
var
  BufferSize: DWORD;
  DummyBuffer: Byte;
  Buffer: Pointer;
  Error: DWORD;
begin
  BufferSize := 1;
  WNetGetUniversalName(PChar(LocalPath), UNIVERSAL_NAME_INFO_LEVEL, @DummyBuffer, BufferSize);
  Buffer := AllocMem(BufferSize);
  try
    Error := WNetGetUniversalName(PChar(LocalPath), UNIVERSAL_NAME_INFO_LEVEL, Buffer, BufferSize);
    if Error <> NO_ERROR then
    begin
      SetLastError(Error);
      RaiseLastWin32Error;
    end;
    Result := PUniversalNameInfo(Buffer)^.lpUniversalName
  finally
    FreeMem(Buffer);
  end;
end;

function TfUtilesV20.GetIPFromHost(HostName: string): string;
type
  TaPInAddr = array [0 .. 10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  i: integer;
begin
  Result := '';
  phe := GetHostByName(PAnsiChar(HostName));
  if phe = nil then
    exit;
  pptr := PaPInAddr(phe^.h_addr_list);
  i := 0;
  while pptr^[i] <> nil do
  begin
    Result := inet_ntoa(pptr^[i]^);
    inc(i);
  end;
end;

function TfUtilesV20.CornerForm(form: TCustomForm; corner: TCorner): Boolean;
var
  r: TRect;
begin
  Result := False;
  if SystemParametersInfo(SPI_GETWORKAREA, 0, @r, 0) then
  begin
    case corner of
      cLeftTop:
        begin
          form.Top := r.Top;
          form.Left := r.Left;
        end;
      cLeftButton:
        begin
          form.Left := r.Left;
          form.Top := r.Bottom - form.Height;
        end;
      cRightTop:
        begin
          form.Top := r.Top;
          form.Left := r.Right - form.Width;
        end;
      cRightButton:
        begin
          form.Top := r.Bottom - form.Height;
          form.Left := r.Right - form.Width;
        end;
    end;
    Result := True;
  end
  else
    RaiseLastOSError();
end;

function TfUtilesV20.Ftp_Is_Alive(cHost: string; cUsername: string = 'remoto'; cPassword: string = '1234'; nPort: integer = 21): Boolean;
begin
  try
    begin
      oIdFTP := TIdFTP.Create(nil);
      oIdFTP.Username := cUsername;
      oIdFTP.Password := cPassword;
      oIdFTP.host := cHost;
      oIdFTP.Port := nPort;
      oIdFTP.Connect;
      Result := True;
      exit;
    end;
  except
    Result := False;
    exit;
  end;
end;

function TfUtilesV20.Check_Host_IsAlive(cHost: string; nPort: integer): Boolean;
var
  cIpAdress, cHostName: string;
  oFileIni: Tinifile;
  nPING_ON_CONNECTION: integer;
begin
  if ((trim(cHost) = '') and (nPort = 0)) then
  begin
    Result := False;
    exit;
  end;
  if ((trim(cHost) = '') or (nPort = 0)) then
  begin
    Result := False;
    exit;
  end;
  if trim(cHost) = 'localhost' then
    cHost := GetComputerNetName();

  cIpAdress := GetIPAddress(cHost);
  oFileIni := Tinifile.Create(ExtractFilePath(Application.ExeName) + 'Data\Config.ini');
  nPING_ON_CONNECTION := oFileIni.ReadInteger('GENERAL', 'PING_ON_CONNECTION', 0);
  if nPING_ON_CONNECTION = 1 then
  begin
    if trim(cIpAdress) <> '127.0.0.1' then
    begin

      if networkFunctions.Ping(cIpAdress, 50) = False then
        Result := False
      else
        Result := True;
    end;
  end
  else
    Result := True;

  oFileIni.WriteInteger('GENERAL', 'PING_ON_CONNECTION', nPING_ON_CONNECTION);
  oFileIni.Free;
end;

procedure TfUtilesV20.InitCheckConnection;
begin
  if (oIdIPWatch.Active = False) then
    oIdIPWatch.Active := True;
end;

procedure TfUtilesV20.Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
  Assert(Assigned(Strings));
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

function TfUtilesV20.BuscarEstacion(sEstacion: string; bCheckActive: Boolean = True): string;
var
  cSql: string;
  oQry1: TFDQuery;
begin
  if bCheckActive = False then
    cSql := 'SELECT * FROM estaciones WHERE UCASE(TRIM(e_descripcion)) = ' + QuotedStr(UpperCase(trim(sEstacion)))
  else
    cSql := 'SELECT * FROM estaciones WHERE e_activo = 1 AND UCASE(TRIM(e_descripcion)) = ' + QuotedStr(UpperCase(trim(sEstacion)));

  if Exec_Select_SQL(oQry1, cSql, True, True, False) = True then
    Result := oQry1.FieldByName('e_id').AsString
  else
    Result := '0';
end;

function TfUtilesV20.query_selectgen_result(text: string): string;
begin
  try
    self.oPub_Qry2 := TFDQuery.Create(nil);
    self.oPub_Qry2.Connection := self.oPublicCnn;
    self.oPub_Qry2.Active := False;
    self.oPub_Qry2.SQL.Clear;
    self.oPub_Qry2.SQL.text := text;
    self.oPub_Qry2.Open;
    if self.oPub_Qry2.Fields[0].text <> '' then
      Result := self.oPub_Qry2.Fields[0].text
    else
      Result := self.oPub_Qry2.Fields[0].text;
  except
    Result := '';
  end;
  self.oPub_Qry2.close;
end;

function TfUtilesV20.GetIPAddress(name: AnsiString): string;
const
  WSVer = $101;
var
  WSAData: TWSAData;
  p: PHostEnt;
begin
  Result := '';
  if WSAStartup(WSVer, WSAData) = 0 then
  begin
    begin
      p := GetHostByName(PAnsiChar(name));
      if p <> nil then
        Result := inet_ntoa(PInAddr(p^.h_addr_list^)^);
    end;
    WSACleanup;
  end;
end;

function TfUtilesV20.GetComputerNetName: string;
var
  NameBuffer: array [0 .. 255] of Char;
  NameString: String;
  Size: DWORD;
begin
  Result := '';

  try
    Size := 256;
    if GetComputerName(NameBuffer, Size) then
    begin
      NameString := NameBuffer;
      Result := trim(NameString);
    end;
  except
    // eat errors
  end;
end;

// GetComputerNetName
function TfUtilesV20.removeLeadingZeros(const Value: string): string;
var
  i: integer;
begin
  for i := 1 to Length(Value) do
    if Value[i] <> '0' then
    begin
      Result := Copy(Value, i, MaxInt);
      exit;
    end;
  Result := '';
end;

function Execute_SQL_Result(pSQL: string): string; overload;
begin
  with fUtilesV20 do
  begin
    if isEmpty(pSQL) = True then
    begin
      Result := '';
      exit;
    end;

    Result := '';
    if (bConnectionOk = False) then
      Carga_Setting_Conn2();

    if Check_Host_IsAlive(oPublicCnn.Params.Values['Server'], StrToInt(oPublicCnn.Params.Values['Port'])) = False then
    begin
      Result := '';
      exit;
    end;

    oPub_Qry.Connection := oPublicCnn;
    oPub_Qry.SQL.text := pSQL;
    try
      oPub_Qry.Open;
      if oPub_Qry.Fields[0].IsNull then
        Result := ''
      else
        Result := oPub_Qry.Fields[0].AsString;
    except
      on E: Exception do
      begin
        Application.ShowException(E);
        Result := ''
      end;
    end;
    oPub_Qry.close;
  end;
end;

function Execute_SQL_Result(oConn_Tmp: TFDConnection; pSQL: string): string; overload;
begin
  with fUtilesV20 do
  begin
    if isEmpty(pSQL) = True then
    begin
      Result := '';
      exit;
    end;

    if Check_Host_IsAlive(oConn_Tmp.Params.Values['Server'], StrToInt(oConn_Tmp.Params.Values['Port'])) = False then
    begin
      Result := '';
      exit;
    end;

    oPub_Qry.Connection := oConn_Tmp;
    oPub_Qry.SQL.text := pSQL;
    try
      oPub_Qry.Open;
      if oPub_Qry.Fields[0].IsNull then
        Result := ''
      else
        Result := oPub_Qry.Fields[0].AsString;
    except
      on E: Exception do
      begin
        Application.ShowException(E);
        Result := ''
      end;
    end;
    oPub_Qry.close;
  end;
end;

function Execute_SQL_Query(var oQry: TFDQuery; sSql: TStringList; oQryExec: Boolean = False): Boolean; overload;
begin
  with fUtilesV20 do
  begin
    Carga_Setting_Conn2();

    if oQry = nil then
      oQry := TFDQuery.Create(nil);

    Carga_Setting_Conn2();
    if Check_Host_IsAlive(oPublicCnn.Params.Values['Server'], StrToInt(oPublicCnn.Params.Values['Port'])) = False then
    begin
      Result := False;
      exit;
    end;

    oQry.Connection := oPublicCnn;
    oQry.close;
    oQry.SQL.Clear;
    oQry.SQL.text := sSql.text;

    try
      if (oQryExec = True) then
      begin
        oQry.ExecSQL;
        Result := True;
      end
      else
      begin
        oQry.Open;
        Result := (oQry.Fields[0].IsNull = False);
      end;
    except
      on E: Exception do
      begin
        Result := False;
      end;
    end;
  end;
end;

function Execute_SQL_Query(oConn_Tmp: TFDConnection; var oQry: TFDQuery; sSql: string; oQryExec: Boolean = False): Boolean; overload;
begin
  with fUtilesV20 do
  begin
    if oQry = nil then
      oQry := TFDQuery.Create(nil);

    Carga_Setting_Conn2();

    if Check_Host_IsAlive(oConn_Tmp.Params.Values['Server'], StrToInt(oConn_Tmp.Params.Values['Port'])) = False then
    begin
      Result := False;
      exit;
    end;

    oQry.close;
    oQry.Connection := oConn_Tmp;
    oQry.SQL.Clear;
    oQry.SQL.text := sSql;
    try
      if (oQryExec = True) then
      begin
        oQry.ExecSQL;
        Result := True;
      end
      else
      begin
        oQry.Open;
        Result := (oQry.Fields[0].IsNull = False);
      end;
    except
      on E: Exception do
      begin
        Result := False;
      end;
    end;
  end;
end;

function Execute_SQL_Query(var oQry: TFDQuery; sSql: string; oQryExec: Boolean = False): Boolean; overload;
begin
  with fUtilesV20 do
  begin

    if oQry = nil then
      oQry := TFDQuery.Create(nil);

    if Check_Host_IsAlive(oPublicCnn.Params.Values['Server'], StrToInt(oPublicCnn.Params.Values['Port'])) = False then
    begin
      Result := False;
      exit;
    end;

    Carga_Setting_Conn2();

    oQry.Connection := oPublicCnn;
    oQry.close;
    oQry.SQL.Clear;
    oQry.SQL.text := sSql;

    try
      if (oQryExec = True) then
      begin
        oQry.ExecSQL;
        Result := True;
      end
      else
      begin
        oQry.Open;
        Result := (oQry.Fields[0].IsNull = False);
      end;
    except
      on E: Exception do
      begin
        Result := False;
      end;
    end;
  end;
end;

function Is_Super_User(): Boolean;
var
  cSql_Ln: string;
  oQry_UsrCk: TFDQuery;
begin
  Result := True;
  oQry_UsrCk := TFDQuery.Create(nil);

  cSql_Ln := '';
  cSql_Ln := cSql_Ln + 'SELECT u_acceso1 ';
  cSql_Ln := cSql_Ln + 'FROM usuarios ';
  cSql_Ln := cSql_Ln + 'WHERE  u_usuario=' + QuotedStr(trim(UtilesV20.sUserName)) + ' ';
  cSql_Ln := cSql_Ln + 'ORDER BY u_usuario ';
  UtilesV20.Exec_Select_SQL(oQry_UsrCk, cSql_Ln, True, False);

  if (oQry_UsrCk.FieldByName('u_acceso1').AsInteger = 1) then
    Result := True
  else
    Result := False;
  freeandnil(oQry_UsrCk);
end;

function RepeatString(const S: string; Count: cardinal): string;
var
  i: integer;
begin
  for i := 1 to Count do
    Result := Result + S;
end;

function CenterString(aStr: String; Len: integer): String;
var
  posStr: integer;
begin
  if Length(aStr) = Len then
    Result := Copy(aStr, 1, Len)
  else
  begin
    posStr := (Len - Length(aStr)) div 2;
    Result := Format('%*s', [Len, aStr + Format('%-*s', [posStr, ''])]);
  end;
end;

end.
