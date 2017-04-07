{ ******************************************************* }
{ johnn Gutierrez jg_gutierrez@yahoo.es }
{ septiembre 2009- mayo 2010 }
{ ******************************************************* }

unit Utiles;

interface

uses Windows, Messages, SysUtils, Classes, Controls, Forms, ComObj,
  Dialogs, inifiles, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, Registry,
  ExtActns,
  ZConnection, ZDataset, IdBaseComponent, IdEcho, DBCtrlsEh,
  GridsEh, DBGridEh, DateUtils,
  ShellAPI, DB, ADODB, DBCtrls, StrUtils, WinSvc, math, variants,
  SplashForm, VirtualTable, ZSqlProcessor, ZScriptParser,
  Grids, WinSpool, Printers,
  Winsock, FileCtrl, Base64,
  IdTCPConnection, IdTCPClient,
  IdFTP, IdIPWatch,
  networkFunctions, clMailMessage, clMC, clSMTP, clTcpClient, clSocket, clPOP3,
  IdTelnet, IdUDPBase, IdUDPClient;

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
  TDateTimePart = (dtpHour, dtpMinute, dtpSecond, dtpMS, dtpDay,
    dtpMonth, dtpYear);

type
  TStringArray = array of string;

type
  TCorner = (cLeftTop, cLeftButton, cRightTop, cRightButton);

var
  oFile: Tinifile;
  oSetting_Fac: Config2;
  oSetting_Fac2: Config2;
  oMerge_Fields: Merge_Fields;
  oMyPublicCnn: TMyConnection;
  oPublicCnn: TZConnection;
  oPublicCnnProc: TZConnection;
  oPublicCnnSQLL: TZConnection;
  bConnectionOk: Boolean = False;
  bConnectionStringLoaded: Boolean = False;
  sDSNConnection: string;
  sUserName: string;
  sUserPass: string;
  sPathReports: string;
  iUserID: integer;
  sSlectedHost: string;
  iId_Empresa: integer;
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
  oExe_Cmd: Tzquery;
  oExe_SQL: Tzquery;
  CodigoSuc: string;
  TriggerOk: string;
  oQryFlds: Tzquery;
  bProcBusy: Boolean;
  hMu: THandle;
  oImo_FactLine: tGenericPrn;
  IdIPWatch1: TIdIPWatch;
  HKA_FP_Status: ^integer;
  HKA_FP_Error: ^integer;
  oPub_Qry: TMyQuery;
  oPub_Com: TMyCommand;
  oPub_Scp: TMyScript;

const
  Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';

procedure ProperCase(var oText: TDBEdit);
procedure WriteToLog(const key: string; const level: integer;
  const description: string);
procedure SaveFileFromString(const FileName: TFileName; const content: string);
procedure Carga_DSN_String2();
procedure CenterFormOverActive(AForm: Tform);
procedure CenterForm(AForm: Tform);
procedure Create_Collate_Tmp();
procedure Delete_Collate_Tmp();
procedure RunAs(AUsername, APassword, ADomain, AApplication: string);
procedure Create_Blank_Tables(sFilename: string);
procedure ShellExecute_AndWait(FileName: string; Params: string);
procedure LogToFile(const S, FileName: string);
procedure MoveDBGridColumns(DBGrid: TDBGridEh; FromColumn, ToColumn: integer);
procedure Delay(msecs: integer);
function Change_Collate_All(pDatabase: string): Boolean;
function Carga_Setting_Conn2(): Boolean;
function ValidEmail(email: string): Boolean;
function GetAppVersion(): string;
function Execute_SQL_Script(oConn_Tmp: TMyConnection; pScript: TStrings)
  : Boolean; overload;
function Execute_SQL_Script(pScript: string): Boolean; overload;
function Execute_SQL_Script(pScript: TStrings): Boolean; overload;
function Execute_SQL_Command(pSQL: string): Boolean; overload;
function Execute_SQL_Command(pScript: TStringList): Boolean; overload;
function Execute_SQL_Command_Tmp(pSQL: string; oSetting_Tmp: Config2)
  : Boolean; overload;
function Execute_SQL_Command_Tmp(pSQL: string; oConn_Tmp: TMyConnection)
  : Boolean; overload;
function Execute_SQL_Command_Tmp(pScript: TStringList; oConn_Tmp: TMyConnection)
  : Boolean; overload;
function Execute_SQL_Command_Tmp_Fle(pFilename: string;
  oConn_Tmp: TMyConnection): Boolean; overload;
function Exec_Select_SQL(var oQry: Tzquery; sSql: string;
  oQryExec: Boolean = False; oQryCreate: Boolean = True;
  IsProcedure: Boolean = False; ExecNoOpen: Boolean = False): Boolean; overload;
function Exec_Select_SQL(var oQry: Tzquery; sSql: TStringList;
  oQryExec: Boolean = False; oQryCreate: Boolean = True;
  IsProcedure: Boolean = False; ExecNoOpen: Boolean = False): Boolean; overload;
function Exec_Select_SQL(oConn_Tmp: TZConnection; var oQry: Tzquery;
  sSql: string; oQryExec: Boolean = False; oQryCreate: Boolean = True;
  IsProcedure: Boolean = False; ExecNoOpen: Boolean = False): Boolean; overload;
function CenterString(aStr: string; Len: integer): string;
function CreateUniqueFileName(sPath: string): string;
function delete_Files(sPath: string; sExten: string): Boolean;
function PadL(ASource: string; ALimit: integer; APadChar: Char = ' '): string;
function PadR(ASource: string; ALimit: integer; APadChar: Char = ' '): string;
function GeneratePWDSecutityString: string;
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
function RandomWord(dictSize, lngStepSize, wordLen,
  minWordLen: integer): string;
function RandomPassword(PLen: integer): string;
function RemoveNonAlpha(srcStr: string): string;
function isEmpty(S: variant): Boolean; overload;
function LlenarcbEmpresa(var pComboSrvs: TcomboBox): integer;
function BuscarUsuario(var oQry1: Tzquery; sUsuario: string;
  bCheckActive: Boolean = True): integer;
function OpenSqlLite(): Boolean;
function iif(Test: Boolean; TrueR, FalseR: variant): variant;
function GetVersion(sFilename: string): string;
function ConnectServer(pKey: string): Boolean;
function GetSetting2(pClaveReg: string): Boolean;
function SaveSetting2(pClaveReg: string): Boolean;
function Add_query_in_Combo(pFieldText: string; pFieldKey: string; pSQL: string;
  var oCombo: TDBComboBoxEh): Boolean;
function LoadDatabaseInServer(pServer: string; var oCombo: TcomboBox): Boolean;
function GetWindowsDir: TFileName;
function GetSystemDir: TFileName;
function GetRegistryData(RootKey: HKEY; key, Value: string): variant;
procedure SetRegistryData(RootKey: HKEY; key, Value: string;
  RegDataType: TRegDataType; Data: variant);
function GetProgramFilesDir: TFileName;
function BemaFI32INI(iRuta: integer = 1; iGetValue: integer = 0;
  sPort: string = ''): string;
function RightStr(const Str: string; Size: Word): string;
function MidStr(const Str: string; From, Size: Word): string;
function LeftStr(const Str: string; Size: Word): string;
function SetScreenResolution(Width, Height: integer): Longint;
function TamanoFichero(sFileToExamine: string): Longword;
function ServiceIsInstalled(nombre: string): Boolean;
function ServiceisRunning(nombre: string): Boolean;
function GetMysqlVariables(pVariable: string): string;
function WinExecAndWait32(FileName: string; Visibility: integer): integer;
function Win32CreateProcess(const FileName, Parameters: string;
  var ExitCode: DWORD; const Wait: DWORD = 0;
  const Hide: Boolean = False): Boolean;
function Find_PrimaryKey(TableName: string): string;
function Fields_Counts(Full_DB_Table_Name: string): integer;
function Tables_Counts(DB_Name: string): integer;
function FieldExists(field: string; Full_DB_Table_Name: string): Boolean;
function FieldExists2(var field: string; Full_DB_Table_Name: string): Boolean;
function TableExists(DBName: string; TableName: string): Boolean;
function fields_info(var oQryFlds: Tzquery; field: string = '*';
  DBName: string = ''; TableName: string = ''): Boolean; overload;
function fields_info(oConn_Tmp: TZConnection; var oQryFlds: Tzquery;
  field: string = '*'; DBName: string = ''; TableName: string = '')
  : Boolean; overload;
function DatabaseExists(DBName: string): Boolean;
function MysQL_Processing_DB(DBName: string): Boolean;
function Replicate(Caracter: string; Quant: integer): string;
function HexToString(S: string): string;
function StringToHex(S: string): string;
procedure SyncErrLog(const key: string; const level: integer;
  const description: string);
procedure SyncFullLog(const key: string; const level: integer;
  const description: string);
procedure SyncSaveEnvList(cPath: string; cFileName: string = 'Index.txt';
  cText: string = '');
function Verify_sysdb_config: Boolean;
procedure Read_Trigger_Vars;
function DayOfYear(const Year, Month, Day: Word): integer;
function LastDayInMonth(const Year, Month: Word): TDateTime;
procedure FindAllFiles(const Path: string; Attr: integer; List: TStrings);
function ASCIIEncrypt(Data, Cipher: string): string;
function GetWindowsTempDirectory: string;
function WaitEnd: Boolean;
procedure WaitSetMsg(sMsg: string);
function WaitStart(TheParent: TComponent; sMsg: string): Boolean;
function FormatNumber(flt: Double; decimals: integer = 0;
  Thousands: Boolean = True): string; Overload;
function FormatNumber(int: Int64; Thousands: Boolean = True): string; Overload;
function FormatNumber(Str: string; Thousands: Boolean = True): string; Overload;
function UnformatNumber(Val: string): string;
function IsNumber(const c: Char): Boolean;
procedure Product_Unpacking_Level(var pPrCodigo: string; var pFactC: integer;
  var pUnid_Dev: integer; pUnid_Ped: integer; pIndex: integer);
function Product_Unpacking(pPrCodigo: string; pCant_Solic: integer): integer;
function RoundDn(X: Single): Single;
function RoundUp(X: Single): Single;
function Sgn(X: Single): integer;
procedure Aplly_Unpacking_Level(var oTable: TVirtualTable;
  var pPrCodigo: string; const pId_Deposito: integer; var pFactC: integer;
  var pUnid_Dev: Single; pUnid_Ped: Single; var pFx1: Single; pIndex: integer;
  pTotCarg: Single; pTotDesc: Single);
function Aplly_Unpacking(pid_Op: integer; pPrCodigo: string;
  pId_DepInve: integer; pCant_Solic: Single;
  var oVTable: TVirtualTable): Single;
function DateTimeAdd(SrcDate: TDateTime; DatePart: TDateTimePart;
  DiffValue: integer): TDateTime;
function EjecutarComando(comando: string): string;
function IsWinNT: Boolean;
function InstallINF(const PathName: string; hParent: HWND): Boolean;
procedure SetSystemEnvironmentVariable(const name, Value: string);
function GetSystemEnvironmentVariable(const name: string): string;
procedure SetUserEnvironmentVariable(const name, Value: string);
function GetUserEnvironmentVariable(const name: string): string;
function SetGlobalEnvironment(const name, Value: string;
  const User: Boolean = True): Boolean;
function Set_Tmp_Database(): Boolean;
function Opt_Database(iOpt: integer = 0; cPattern: string = '%';
  cDBName: string = ''): Boolean;
function IsAdmin: Boolean;
procedure TxtFile_Write_version(FileName: string; cFull_AppName: string);
function Change_Collate_Srv(): Boolean;
procedure ResizeKit_DBGridEh_Prepare(oDBGridEh: TDBGridEh;
  var pReziseVars: TReziseCntl); overload;
procedure ResizeKit_DBGridEh(oDBGridEh: TDBGridEh; pXScale: Double;
  pYScale: Double; pReziseVars: TReziseCntl); overload;
function IsStrANumber(const S: string): Boolean;
function between(nval, nmin, nmax: Longint): Boolean;
function strTran(cText, cfor, cwith: string): string;
procedure DeleteArrayItem(var X: TStringArray; const Index: integer);
function BinSearchArray(Strings: TStringArray; SubStr: string): integer;
function SearchInArray(PNames: TStringArray; PName: string): integer;
procedure QuickSortArray(var Strings: TStringArray; Start, Stop: integer);
function ClearArray(var PNames: TStringArray): integer;
function TimeDiff(cTime_Ult: string; cTime_Ant: string): string;
function TimeADD(cTime: string; nInterval: integer; nValue: integer)
  : string; overload;
function TimeADD(TDateTime: TDateTime; nInterval: integer; nValue: integer)
  : string; overload;
function SecsToTime(nSeconds: integer): string;
function TimeToSecs(cTime: string): integer;
function SecToTime(Sec: integer): string;
function Producto_Recalcula_Montos_Imp(pCodigo: string;
  pFull_TableName: string = 'productos_det'): Boolean;
function Producto_Recalcula_Margenes(pCodigo: string;
  pFull_TableName: string = 'productos_det'): Boolean;
function Producto_Recalcula_Utilidad_Monto(pCodigo: string;
  pFull_TableName: string = 'productos_det'): Boolean;
function Producto_Recalcula_PreciosVta_Con_Costos(pCodigo: string;
  pFull_TableName: string = 'productos_det'): Boolean;
function Producto_Recalcula_PreciosVta_Con_Imp(pCodigo: string;
  pFull_TableName: string = 'productos_det'): Boolean;
function Producto_Recalcula_PreciosVta_Con_PreciosVtaImp(pCodigo: string;
  pFull_TableName: string = 'productos_det'): Boolean;
function Operacion_Get_And_Update_Opid: string;
function Get_Station_id: string;
function Operacion_Get_And_Update_CargosId(nOption: integer;
  bAutoSave: Boolean = True): string;
function Actualiza_Exist_Deps(tipo_op: string): Boolean;
function Muestra_Producto_Presentaciones(var oVTable: TVirtualTable;
  pCodigo: string; nPrtecio: integer): Boolean;
procedure GetDefault_Decinal_Thousand_Separator;
procedure Set_Decinal_Thousand_Separator;
function Inserta_compuestos_poperacion(pPo_op_id: integer;
  bAllItems: Boolean = True; pMPr_id: string = ''): Boolean;
function Productos_Compuestos_Actualiza_Costos_Precios(pPo_op_id: integer;
  bAllItems: Boolean = True; pMPr_id: string = ''): Boolean;
function Productos_Desempaque_Actualiza_Costos_Precios(pPo_op_id: integer;
  bAllItems: Boolean = True; pMPr_id: string = ''): Boolean;
function Busca_Enlace_Desempaque(var oQry: Tzquery; var pCod_Buscar: string;
  var pCod_Result: string; bBusca_Enlace: Boolean = True): Boolean;
function Listas_Familia_un_Desempaque(pCodigo: string): string;
function FloatToStr2(Value: extended): string;
function Calcular_Costo_Promedio(pr_id: string; cost_New: Single;
  exist_new: Single): Single;
function RoundD(X: extended; d: integer): extended;
function Inlist(aCadena: string; aLista: array of string): Boolean;
procedure Actualiza_Exist_Online(pTipo: string; pPo_op_id: integer;
  Sign: integer = 1; bAllItems: Boolean = True; pMPr_id: string = '');
function Ctrl_Resize: Boolean;
procedure PrintLineToGeneric(const line: string);
procedure PrintLineOnDotMatrix(cPrinterName: string; cDocName: string;
  cString: string; bDobleCarr: Boolean; bTest: Boolean = False);
function CenterText(nWidth: integer; sText: string): string;
function CadLongitudFija(cadena: string; longitud: integer;
  posicionIzquierda: Boolean; valorRelleno: string): string;
function Get_Values3: Boolean;
procedure QuitarEjecutarEnInicio(NombreEjecutable: string;
  SoloUnaVez, SoloUsuario: Boolean);
procedure EjecutarEnInicio(NombrePrograma, NombreEjecutable: string;
  SoloUnaVez, SoloUsuario: Boolean);
function SeEjecutaEnInicio(NombreEjecutable: string;
  SoloUnaVez, SoloUsuario: Boolean): Boolean;
procedure Poner_Facil_De_Inicio_Windows(pCierraSession: Boolean = True);
procedure Quita_Facil_De_Inicio_Windows(pCierraSession: Boolean = True);
procedure ReiniciaWindows;
procedure CierraSessionWindows;
procedure OpcionesApagarWindows(Sender: TObject);
function Strip(L, c: Char; Str: string): string;
procedure DataRefresh(var oDataset: Tdataset; pfield_Name: string);
procedure AppendCurrent(Dataset: Tdataset);
procedure LoadStringGrid(StringGrid: TStringGrid; const FileName: TFileName);
procedure SaveStringGrid(StringGrid: TStringGrid; const FileName: TFileName);
function ReplaceDatePart(pDateTime: TDateTime; pDateReplace: TDateTime)
  : TDateTime;
function TimeToDateTime(pTime: Ttime): TDateTime;
function esPrimo(X: integer): Boolean;
function par(n: integer): Boolean;
function Par2(Num: integer): Boolean;
function GetProgramFilesDir2: string;
function tiempo_Transcurrido(pStartTime: DWORD; pEndTime: DWORD): string;
function MapNetworkDriveDLG(const handle: THandle;
  const uncPath: string): string;
function Get_File_Size2(sFileToExamine: string): integer;
function isValidPath(Value: string): Boolean;
function DoAutologin(var bStartApp1: Boolean; var bStartApp2: Boolean;
  var bIsServer: Boolean; bCheckPassword: Boolean = False): Boolean;
procedure FormTransparence(oForm: Tform; iLimit: integer = 0);
procedure FormDegrade(oForm: Tform);
function GetUNCName(const LocalPath: string): string;
// function GetIPFromHost(var HostName, IPaddr, WSAErr: string): Boolean;
function CornerForm(form: TCustomForm; corner: TCorner): Boolean;
function Ftp_Is_Alive(cHost: string; cUsername: string = 'remoto';
  cPassword: string = '1234'; nPort: integer = 21): Boolean;
function Check_Host_IsAlive(cHost: string; nPort: integer): Boolean;
procedure InitCheckConnection;
procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
function BuscarEstacion(sEstacion: string;
  bCheckActive: Boolean = True): string;
// * -----------------Funciones productos The Factory HKA---------------------------------- */
function OpenFpctrl(lpcstr: string): Boolean; stdcall; external 'tfhkaif.dll';
function CloseFpctrl(): Boolean; stdcall; external 'tfhkaif.dll';
function CheckFprinter(): Boolean; stdcall; external 'tfhkaif.dll';
function ReadFpStatus(status, error: Pointer): Boolean; stdcall;
  external 'tfhkaif.dll';
function SendCmd(status: Pointer; error: Pointer; cmd: AnsiString): Boolean;
  stdcall; external 'tfhkaif.dll';
function SendNCmd(var status: Pointer; var error: Pointer; cmd: AnsiString)
  : Boolean; stdcall; external 'tfhkaif.dll';
function SendFileCmd(var status: Pointer; var error: Pointer;
  FileName: AnsiString): Boolean; stdcall; external 'tfhkaif.dll';
function UploadReportCmd(var status: Pointer; var error: Pointer;
  cmd, FileName: AnsiString): Boolean; stdcall; external 'tfhkaif.dll';
function HKA_ShowErrorByName(pShowMessage: Boolean;
  var pStringStatus: string): Boolean;
function HKA_ShowStatusByName(pShowMessage: Boolean;
  var pStringStatus: string): Boolean;
// * ---------------------------------------------------------------------------------------*/
function query_selectgen_result(text: string): string;
function GetIPAddress(name: AnsiString): string;
function GetIPFromHost(HostName: string): string;
function GetHostByAddr(IP: string): string;
function GetComputerNetName: string;
function removeLeadingZeros(const Value: string): string;

function Execute_SQL_Result(pSQL: string): string; overload;
function Execute_SQL_Result(oConn_Tmp: TMyConnection; pSQL: string)
  : string; overload;
function Execute_SQL_Query(var oQry: TMyQuery; sSql: string;
  oQryExec: Boolean = False): Boolean; overload;
function Execute_SQL_Query(oConn_Tmp: TMyConnection; var oQry: TMyQuery;
  sSql: string; oQryExec: Boolean = False): Boolean; overload;
function Execute_SQL_Query(var oQry: TMyQuery; sSql: TStringList;
  oQryExec: Boolean = False): Boolean; overload;
procedure BuscarArchivos(const directorio, mascara: string; atributos: integer;
  var listado: TStringList);

implementation

uses SplashForm2;

function ValidEmail(email: string): Boolean;
// Returns True if the email address is valid
// Author: Ernesto D'Spirito
const
  // Valid characters in an "atom"
  atom_chars = [#33 .. #255] - ['(', ')', '<', '>', '@', ',', ';', ':', '\',
    '/', '"', '.', '[', ']', #127];
  // Valid characters in a "quoted-string"
  quoted_string_chars = [#0 .. #255] - ['"', #13, '\'];
  // Valid characters in a subdomain
  letters = ['A' .. 'Z', 'a' .. 'z'];
  letters_digits = ['0' .. '9', 'A' .. 'Z', 'a' .. 'z'];
  subdomain_chars = ['-', '0' .. '9', 'A' .. 'Z', 'a' .. 'z'];
type
  States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR, STATE_QUOTE,
    STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN, STATE_SUBDOMAIN,
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

function GetAppVersion(): string;
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
        Result := IntToStr(HiWord(dwFileVersionMS)) + '.' +
          IntToStr(LoWord(dwFileVersionMS)) + '.' +
          IntToStr(HiWord(dwFileVersionLS)) + '.' +
          IntToStr(LoWord(dwFileVersionLS));
      end;
    finally
      FreeMem(Pt);
    end;
  end;
end;

function Exec_Select_SQL(var oQry: Tzquery; sSql: TStringList;
  oQryExec: Boolean = False; oQryCreate: Boolean = True;
  IsProcedure: Boolean = False; ExecNoOpen: Boolean = False): Boolean; overload;
begin
  Result := False;
  Carga_Setting_Conn2();
  if oQryCreate = True then
    oQry := Tzquery.Create(nil);
  oQry.Active := False;

  if IsProcedure = True then
  begin

    if Check_Host_IsAlive(Utiles.oPublicCnnProc.HostName,
      Utiles.oPublicCnnProc.Port) = False then
    begin
      Result := False;
      exit;
    end;

    oQry.Connection := Utiles.oPublicCnnProc;
  end
  else
  begin

    if Check_Host_IsAlive(Utiles.oPublicCnn.HostName, Utiles.oPublicCnn.Port) = False
    then
    begin
      Result := False;
      exit;
    end;

    // application.ProcessMessages;
    oQry.Connection := Utiles.oPublicCnn;
  end;
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
    Utiles.oPublicCnnProc.reconnect;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

function Exec_Select_SQL(oConn_Tmp: TZConnection; var oQry: Tzquery;
  sSql: string; oQryExec: Boolean = False; oQryCreate: Boolean = True;
  IsProcedure: Boolean = False; ExecNoOpen: Boolean = False): Boolean; overload;
begin
  Result := False;
  try
    if oQryCreate = True then
      oQry := Tzquery.Create(nil);
    oQry.Active := False;

    if Check_Host_IsAlive(oConn_Tmp.HostName, oConn_Tmp.Port) = False then
    begin
      Result := False;
      exit;
    end;

    if IsProcedure = True then
      oQry.Connection := oConn_Tmp
    else
    begin
      // application.ProcessMessages;
      oQry.Connection := oConn_Tmp;
    end;
    oQry.SQL.Clear;
    oQry.SQL.text := sSql;
    // application.ProcessMessages;
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

function Exec_Select_SQL(var oQry: Tzquery; sSql: string;
  oQryExec: Boolean = False; oQryCreate: Boolean = True;
  IsProcedure: Boolean = False; ExecNoOpen: Boolean = False): Boolean; overload;
begin
  try
    Carga_Setting_Conn2();
    if oQryCreate = True then
      oQry := Tzquery.Create(nil);
    oQry.Active := False;
    if IsProcedure = True then
    begin

      if Check_Host_IsAlive(Utiles.oPublicCnnProc.HostName,
        Utiles.oPublicCnnProc.Port) = False then
      begin
        Result := False;
        exit;
      end;

      oQry.Connection := Utiles.oPublicCnnProc;
    end
    else
    begin

      if Check_Host_IsAlive(Utiles.oPublicCnn.HostName, Utiles.oPublicCnn.Port)
        = False then
      begin
        Result := False;
        exit;
      end;

      // application.ProcessMessages;
      oQry.Connection := Utiles.oPublicCnn;
    end;
    oQry.SQL.Clear;
    oQry.SQL.text := sSql;
    // application.ProcessMessages;
    if ExecNoOpen = True then
    begin
      oQry.ExecSQL;
      Utiles.oPublicCnnProc.reconnect;
      Exec_Select_SQL := True;
    end
    else
    begin
      if (oQryExec = True) then
      begin
        oQry.Open;
        Utiles.oPublicCnnProc.reconnect;
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

procedure ProperCase(var oText: TDBEdit);
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

function CenterString(aStr: string; Len: integer): string;
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

function CreateUniqueFileName(sPath: string): string;
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

function delete_Files(sPath: string; sExten: string): Boolean;
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

procedure AddLog(ErrorText: string; bCreateNew: Boolean = False;
  cFileName: string = 'EmailLog.txt');
begin
end;

procedure WriteToLog(const key: string; const level: integer;
  const description: string);
var
  DirectoryName: string;
  FileName: string;
  LogFile: textfile;
begin
  DirectoryName := ExcludeTrailingBackslash
    (ExtractFilePath(Application.ExeName)) + 'LOG';
  // Create directory, if necessary.
  if not FileCtrl.DirectoryExists(DirectoryName) then
    FileCtrl.ForceDirectories(DirectoryName);
  FileName := FormatDateTime('yyyymm', Now) + '.LOG';
  AssignFile(LogFile, DirectoryName + '\' + FileName);
  try
    if SysUtils.FileExists(DirectoryName + '\' + FileName) then
      Append(LogFile)
    else
      Rewrite(LogFile); // Create if new
    if level = 0 then
      WriteLn(LogFile) // blank line
    else
      WriteLn(LogFile, FormatDateTime('dd hh:nn:ss', Now), ' ',
        Format('%-16s', [key]), ' ', description);
    CloseFile(LogFile)
  except
    // Ignore exceptions while writing log files
  end;
end;

procedure SyncFullLog(const key: string; const level: integer;
  const description: string);
var
  DirectoryName: string;
  FileName: string;
  LogFile: textfile;
begin
  DirectoryName := ExcludeTrailingBackslash
    (ExtractFilePath(Application.ExeName)) + 'LOG';
  // Create directory, if necessary.
  if not FileCtrl.DirectoryExists(DirectoryName) then
    FileCtrl.ForceDirectories(DirectoryName);
  FileName := FormatDateTime('yyyymm', Now) + '_FULL.LOG';
  AssignFile(LogFile, DirectoryName + '\' + FileName);
  try
    if SysUtils.FileExists(DirectoryName + '\' + FileName) then
      Append(LogFile) // If existing file
    else
      Rewrite(LogFile); // Create if new
    if level = 0 then
      WriteLn(LogFile) // blank line
    else
      WriteLn(LogFile, FormatDateTime('dd hh:nn:ss', Now), ' ',
        Format('%-16s', [key]), ' ', description);
    CloseFile(LogFile)
  except
    // Ignore exceptions while writing log files
  end;
end;

procedure SyncErrLog(const key: string; const level: integer;
  const description: string);
var
  DirectoryName: string;
  FileName: string;
  LogFile: textfile;
begin
  DirectoryName := ExcludeTrailingBackslash
    (ExtractFilePath(Application.ExeName)) + 'LOG';
  // Create directory, if necessary.
  if not FileCtrl.DirectoryExists(DirectoryName) then
    FileCtrl.ForceDirectories(DirectoryName);
  FileName := FormatDateTime('yyyymm', Now) + '_ERR.LOG';
  AssignFile(LogFile, DirectoryName + '\' + FileName);
  try
    if SysUtils.FileExists(DirectoryName + '\' + FileName) then
      Append(LogFile) // If existing file
    else
      Rewrite(LogFile); // Create if new
    if level = 0 then
      WriteLn(LogFile) // blank line
    else
      WriteLn(LogFile, FormatDateTime('dd hh:nn:ss', Now), ' ',
        Format('%-16s', [key]), ' ', description);
    CloseFile(LogFile)
  except
    // Ignore exceptions while writing log files
  end;
end;

// EX: PadL('123', 5, '0') ==> 00123

function PadL(ASource: string; ALimit: integer; APadChar: Char = ' '): string;
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

function PadR(ASource: string; ALimit: integer; APadChar: Char = ' '): string;
var
  i: integer;
begin
  Result := ASource;
  for i := 1 to ALimit - Length(Result) do
  begin
    Result := Result + APadChar;
  end;
end;

function GeneratePWDSecutityString: string;
var
  i, X: integer;
  s1, s2: string;
begin
  s1 := Codes64;
  s2 := '';
  for i := 0 to 15 do
  begin
    X := Random(Length(s1));
    X := Length(s1) - X;
    s2 := s2 + s1[X];
    s1 := Copy(s1, 1, X - 1) + Copy(s1, X + 1, Length(s1));
  end;
  Result := s2;
end;

function MakeRNDString(Chars: string; Count: integer): string;
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

function Encrypt(tr: string): string;
begin
  Encrypt := Base64.Base64Encode(tr);
end;

function Decrypt(pr: string): string;
begin
  Decrypt := Base64.Base64Decode(pr)
end;

function LoadFileToString(const FileName: string): widestring;
var
  handle, Size: Cardinal;
begin
  handle := CreateFile(PChar(FileName), GENERIC_READ, 0, nil, OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL, 0);
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

procedure SaveFileFromString(const FileName: TFileName; const content: string);
{ Writing a file from a string }
begin
  with TFileStream.Create(FileName, fmCreate) do
    try
      Write(Pointer(content)^, Length(content));
    finally
      Free;
    end;
end;

function FDOM(Date: TDateTime): TDateTime;
var
  wYear, wMonth, wDay: Word;
begin
  DecodeDate(Date, wYear, wMonth, wDay);
  Result := EncodeDate(wYear, wMonth, 1);
end;

function LDOM(Date: TDateTime): TDateTime;
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

function CargarServidoresActivos(var pComboSrvs: TcomboBox): integer;
var
  oFileIni: Tinifile;
  sServerName: string;
  sConnStatus: string;
begin
  oFileIni := Tinifile.Create(ExtractFilePath(Application.ExeName) +
    'Data\Config.ini');
  pComboSrvs.Clear;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion1',
    'Desconocido1');
  if UpperCase(trim(sServerName)) <> UpperCase('Desconocido1') then
  begin
    sConnStatus := oFileIni.ReadString(sServerName, 'conectado', '');
    if UpperCase(trim(sConnStatus)) = UpperCase('Conexión Exitosa!!!!') then
      pComboSrvs.Items.Add(sServerName);
  end;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion2',
    'Desconocido2');
  if UpperCase(trim(sServerName)) <> UpperCase('Desconocido2') then
  begin
    sConnStatus := oFileIni.ReadString(sServerName, 'conectado', '');
    if UpperCase(trim(sConnStatus)) = UpperCase('Conexión Exitosa!!!!') then
      pComboSrvs.Items.Add(sServerName);
  end;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion3',
    'Desconocido3');
  if UpperCase(trim(sServerName)) <> UpperCase('Desconocido3') then
  begin
    sConnStatus := oFileIni.ReadString(sServerName, 'conectado', '');
    if UpperCase(trim(sConnStatus)) = UpperCase('Conexión Exitosa!!!!') then
      pComboSrvs.Items.Add(sServerName);
  end;

  oFileIni.Free;
  Result := pComboSrvs.Items.Count;
end;

function CargarServidoresActivosEh(var pComboSrvs: TDBComboBoxEh): integer;
var
  oFileIni: Tinifile;
  sServerName: string;
  sConnStatus: string;
begin
  oFileIni := Tinifile.Create(ExtractFilePath(Application.ExeName) +
    'Data\Config.ini');
  pComboSrvs.Clear;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion1',
    'Desconocido1');
  if UpperCase(trim(sServerName)) <> UpperCase('Desconocido1') then
  begin
    sConnStatus := oFileIni.ReadString(sServerName, 'conectado', '');
    if UpperCase(trim(sConnStatus)) = UpperCase('Conexión Exitosa!!!!') then
      pComboSrvs.Items.Add(sServerName);
  end;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion2',
    'Desconocido2');
  if UpperCase(trim(sServerName)) <> UpperCase('Desconocido2') then
  begin
    sConnStatus := oFileIni.ReadString(sServerName, 'conectado', '');
    if UpperCase(trim(sConnStatus)) = UpperCase('Conexión Exitosa!!!!') then
      pComboSrvs.Items.Add(sServerName);
  end;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion3',
    'Desconocido3');
  if UpperCase(trim(sServerName)) <> UpperCase('Desconocido3') then
  begin
    sConnStatus := oFileIni.ReadString(sServerName, 'conectado', '');
    if UpperCase(trim(sConnStatus)) = UpperCase('Conexión Exitosa!!!!') then
      pComboSrvs.Items.Add(sServerName);
  end;

  oFileIni.Free;
  Result := pComboSrvs.Items.Count;
end;

function CargarServidores(var pComboSrvs: TcomboBox): integer;
var
  oFileIni: Tinifile;
  sServerName: string;
begin
  oFileIni := Tinifile.Create(ExtractFilePath(Application.ExeName) +
    'Data\Config.ini');
  pComboSrvs.Clear;

  sServerName := oFileIni.ReadString('servidores', 'Configuracion1',
    'Desconocido1');
  pComboSrvs.Items.Add(sServerName);

  sServerName := oFileIni.ReadString('servidores', 'Configuracion2',
    'Desconocido2');
  pComboSrvs.Items.Add(sServerName);

  sServerName := oFileIni.ReadString('servidores', 'Configuracion3',
    'Desconocido3');
  pComboSrvs.Items.Add(sServerName);

  oFileIni.Free;
  Result := pComboSrvs.Items.Count;
end;

function Get_Values3: Boolean;
var
  otLocal_Config: Tztable;
  bSqlLiteOk: Boolean;
begin
  bSqlLiteOk := Utiles.OpenSqlLite();
  if (bSqlLiteOk = True) then
  begin
    otLocal_Config := Tztable.Create(nil);
    otLocal_Config.Connection := Utiles.oPublicCnnSQLL;
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
      oSetting_Fac.ResizeScrn := otLocal_Config.FieldByName('ResizeScrn')
        .AsInteger;
      oSetting_Fac.Beep_Sound := otLocal_Config.FieldByName('beep').AsInteger;
      oSetting_Fac.Beep_Frecu := otLocal_Config.FieldByName('beep_frec')
        .AsInteger;
      oSetting_Fac.Beep_Durac := otLocal_Config.FieldByName('beep_durac')
        .AsInteger;
    end;
    freeandnil(otLocal_Config);
    Result := True;
  end
  else
    Result := False;
end;

function SaveSetting2(pClaveReg: string): Boolean;
var
  sPath: string;
  sPass: string;
  otMail_Config2: Tztable;
  bSqlLiteOk: Boolean;
begin
  try
    bSqlLiteOk := Utiles.OpenSqlLite();
    if (bSqlLiteOk = True) then
    begin
      otMail_Config2 := Tztable.Create(nil);
      otMail_Config2.Connection := Utiles.oPublicCnnSQLL;
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

      if (UpperCase(trim(oSetting_Fac.estado)) <>
        UpperCase(trim('Conexión fallida!'))) then
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
      otMail_Config2.FieldByName('smtp_server').AsString :=
        trim(oSetting_Fac.SmtpSrvName);
      otMail_Config2.FieldByName('smtp_Port').AsInteger :=
        Ord(oSetting_Fac.SmtpPort);
      otMail_Config2.FieldByName('smtp_user').AsString :=
        trim(oSetting_Fac.SmtpUser);
      otMail_Config2.FieldByName('smtp_password').AsString :=
        trim(oSetting_Fac.SmtpPass);
      otMail_Config2.FieldByName('smtp_Debug').AsInteger :=
        Ord(oSetting_Fac.SmtpDebug);
      otMail_Config2.FieldByName('smtp_AuthType').AsInteger :=
        Ord(oSetting_Fac.SmtpAuthType);
      otMail_Config2.FieldByName('smtp_ssl').AsInteger :=
        Ord(oSetting_Fac.SmtpSSL);
      otMail_Config2.FieldByName('Ornanization_Mail').AsString :=
        trim(oSetting_Fac.Origen_Email);
      otMail_Config2.FieldByName('Ornanization_Name').AsString :=
        trim(oSetting_Fac.Origen_Nombr);
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

function GetSetting2(pClaveReg: string): Boolean;
var
  sTmpP: string;
  sPath: string;
  sFile: string;
  otMail_Config2: Tztable;
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
    Utiles.sSlectedHost := pClaveReg;
  except
    Result := False;
    Utiles.sSlectedHost := '';
  end;
  oFile.Free;
end;

procedure Carga_DSN_String2();
var
  sCadena: string;
begin
  if bConnectionStringLoaded = True then
    exit;
  sDSNConnection :=
    'DRIVER=MySQL ODBC 5.1 Driver;SERVER=ServerID;UID=UserID;PWD=PassID;DATABASE=DatabaseID;PORT=PortID';
  sDSNConnection :=
    'DRIVER=MySQL ODBC 5.1 Driver; SERVER=ServerID; DATABASE=DatabaseID; UID=UserID; PASSWORD=PassID;OPTION=3';
  sCadena := sDSNConnection;
  sCadena := StringReplace(sCadena, 'ServerID', trim(oSetting_Fac.host),
    [rfReplaceAll, rfIgnoreCase]);
  sCadena := StringReplace(sCadena, 'UserID', trim(oSetting_Fac.usuario),
    [rfReplaceAll, rfIgnoreCase]);
  sCadena := StringReplace(sCadena, 'PassID', trim(oSetting_Fac.clave),
    [rfReplaceAll, rfIgnoreCase]);
  sCadena := StringReplace(sCadena, 'DatabaseID', trim(oSetting_Fac.database),
    [rfReplaceAll, rfIgnoreCase]);
  sCadena := StringReplace(sCadena, 'PortID', IntToStr(oSetting_Fac.puerto),
    [rfReplaceAll, rfIgnoreCase]);
  sDSNConnection := sCadena;
end;

function Carga_Setting_Conn2(): Boolean;
begin
  try
    if (oMyPublicCnn = nil) then
      oMyPublicCnn := TMyConnection.Create(nil);

    if ((oPublicCnn = nil) or (oPublicCnn.Connected = False)) then
    begin
      oPublicCnn := TZConnection.Create(nil);
    end;

    if ((oPublicCnnProc = nil) or (oPublicCnnProc.Connected = False)) then
    begin
      oPublicCnnProc := TZConnection.Create(nil);
    end;

    if (oPublicCnn.Connected = False) then
    begin
      if Pos('MYSQL', UpperCase(oSetting_Fac.protocol)) > 0 then
      begin
        oPublicCnn.Properties.Clear;
        oPublicCnn.Properties.Add('CLIENT_MULTI_STATEMENTS=1');
        oPublicCnn.Properties.Add('CHARSET=utf8');
        oPublicCnn.Properties.Add('COLLATE=utf8_general_ci');
{        oPublicCnn.Properties.Add('character_set_client=utf8');
        oPublicCnn.Properties.Add('character_set_connection=utf8');
        oPublicCnn.Properties.Add('character_set_database=utf8');
        oPublicCnn.Properties.Add('character_set_results=utf8');
        oPublicCnn.Properties.Add('character_set_server=utf8');
        oPublicCnn.Properties.Add('character_set_system=utf8');
        oPublicCnn.Properties.Add('collation_connection=utf8_general_ci');
        oPublicCnn.Properties.Add('collation_database=utf8_general_ci');
        oPublicCnn.Properties.Add('collation_server=utf8_general_ci');
        oPublicCnn.Properties.Add('Codepage=utf8');
}      end;
      oPublicCnn.HostName := oSetting_Fac.host;
      oPublicCnn.protocol := trim(oSetting_Fac.protocol);
      oPublicCnn.Port := oSetting_Fac.puerto;
      oPublicCnn.User := oSetting_Fac.usuario;
      oPublicCnn.Password := oSetting_Fac.clave;
      oPublicCnn.database := oSetting_Fac.database;
      oPublicCnn.Catalog := oSetting_Fac.database;

      oMyPublicCnn.LoginPrompt := False;
      oMyPublicCnn.Options.Charset := 'UTF8';
      oMyPublicCnn.server := oPublicCnn.HostName;
      oMyPublicCnn.Username := oPublicCnn.User;
      oMyPublicCnn.Password := oPublicCnn.Password;
      oMyPublicCnn.database := oPublicCnn.database;

      if Utiles.Check_Host_IsAlive(oSetting_Fac.host, oSetting_Fac.puerto) = True
      then
      begin
        oPublicCnn.Connected := True;
        //oMyPublicCnn.Connect;
      end
      else
      begin
        bConnectionOk := False;
        Result := False;
        exit;
      end;
    end;

    if (oPublicCnnProc.Connected = False) then
    begin
      if Pos('MYSQL', UpperCase(oSetting_Fac.protocol)) > 0 then
      begin
        oPublicCnnProc.Properties.Clear;
        oPublicCnnProc.Properties.Add('CLIENT_MULTI_STATEMENTS=1');
        oPublicCnnProc.Properties.Add('CHARSET=utf8');
        oPublicCnnProc.Properties.Add('COLLATE=utf8_general_ci');
        {oPublicCnnProc.Properties.Add('character_set_client=utf8');
        oPublicCnnProc.Properties.Add('character_set_connection=utf8');
        oPublicCnnProc.Properties.Add('character_set_database=utf8');
        oPublicCnnProc.Properties.Add('character_set_results=utf8');
        oPublicCnnProc.Properties.Add('character_set_server=utf8');
        oPublicCnnProc.Properties.Add('character_set_system=utf8');
        oPublicCnnProc.Properties.Add('collation_connection=utf8_general_ci');
        oPublicCnnProc.Properties.Add('collation_database=utf8_general_ci');
        oPublicCnnProc.Properties.Add('collation_server=utf8_general_ci');
        oPublicCnnProc.Properties.Add('Codepage=utf8');
      }end;
      oPublicCnnProc.HostName := oSetting_Fac.host;
      oPublicCnnProc.protocol := trim(oSetting_Fac.protocol);
      oPublicCnnProc.Port := oSetting_Fac.puerto;
      oPublicCnnProc.User := oSetting_Fac.usuario;
      oPublicCnnProc.Password := oSetting_Fac.clave;
      oPublicCnnProc.database := oSetting_Fac.database;
      oPublicCnnProc.Catalog := oSetting_Fac.database;
      oPublicCnnProc.Connected := True;
    end;

    bConnectionOk := oPublicCnn.Connected;
    GetDefault_Decinal_Thousand_Separator;
    Result := oPublicCnn.Connected;
  except
    bConnectionOk := False;
    Result := bConnectionOk;
    exit;
  end;
end;

{ Example: label1.Caption := RandomPassword(10); }

function RandomPassword(PLen: integer): string;
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

function RandomWord(dictSize, lngStepSize, wordLen,
  minWordLen: integer): string;
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

function RemoveNonAlpha(srcStr: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to Length(srcStr) - 1 do
    if isCharAlpha(srcStr[i]) then
      Result := Result + srcStr[i];
end;

function isEmpty(S: variant): Boolean; overload;
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

function OpenSqlLite(): Boolean;
begin
  try
    if FileExists(ExtractFilePath(Application.ExeName) + 'data\local.conf') = False
    then
    begin
      Result := False;
      exit;
    end;
    oPublicCnnSQLL := TZConnection.Create(nil);
    oPublicCnnSQLL.protocol := 'sqlite-3';
    oPublicCnnSQLL.database := ExtractFilePath(Application.ExeName) +
      'data\local.conf';
    oPublicCnnSQLL.Connect;
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

function ConnectServer(pKey: string): Boolean;
begin
  Utiles.GetSetting2(pKey);
  if Utiles.Carga_Setting_Conn2() = True then;
  begin
    Utiles.Carga_DSN_String2();
  end;
  Result := Utiles.oPublicCnn.Connected;
end;

function LlenarcbEmpresa(var pComboSrvs: TcomboBox): integer;
var
  oQry1: Tzquery;
  cSql: string;
  sNomEmp: string;
begin
  oQry1 := Tzquery.Create(nil);
  oQry1.Connection := Utiles.oPublicCnn;
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
  oQry1.Close;
  oQry1.Free;
  Result := pComboSrvs.Items.Count;
end;

procedure Delete_Collate_Tmp();
var
  oQry: Tzquery;
begin
  try
    Utiles.Exec_Select_SQL(oQry, 'DROP TABLE IF EXISTS `tmp_collate`;', True,
      True, True);
    oQry.Free;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
    end;
  end;
end;

procedure Create_Collate_Tmp();
var
  oQry: Tzquery;
begin
  try
    Utiles.Exec_Select_SQL(oQry, 'CALL Change_Collate()', True, True, True);
    oQry.Free;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
    end;
  end;
end;

function Change_Collate_Srv(): Boolean;
var
  ScriptsToExecute: TStringList;
begin
  ScriptsToExecute := TStringList.Create;
  ScriptsToExecute.Clear;
  try
    ScriptsToExecute.Clear;
    ScriptsToExecute.Add('SET @@global.collation_server = "utf8_general_ci" ;');
    ScriptsToExecute.Add
      ('SET @@session.collation_server = "utf8_general_ci" ;');
    ScriptsToExecute.Add('SET @@global.character_set_database = "utf8" ;');
    ScriptsToExecute.Add('SET @@session.character_set_database = "utf8" ;');
    Execute_SQL_Command(ScriptsToExecute);
    Result := True;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
end;

function Change_Collate_All(pDatabase: string): Boolean;
begin
end;

{ -------------------------------------------------------------------------------------------------
  Esta funcion que es una extención de Execute_SQL_Command, ejecuta uan cadena de comandos separados
  por ; y las ejecuta al mismo tiempo en un string no muy grande.
  -------------------------------------------------------------------------------------------------- }
function Execute_SQL_Command(pSQL: string): Boolean; overload;
begin
  if (oPub_Com = NIL) then
    oPub_Com := TMyCommand.Create(nil);

  if isEmpty(pSQL) = True then
  begin
    Result := False;
    exit;
  end;
  Result := False;
  if (bConnectionOk = False) then
    Carga_Setting_Conn2();

  if Check_Host_IsAlive(Utiles.oPublicCnn.HostName, Utiles.oPublicCnn.Port) = False
  then
  begin
    Result := False;
    exit;
  end;

  try
    oPub_Com.Connection := Utiles.oMyPublicCnn;
    oPub_Com.SQL.text := pSQL;
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

{ -------------------------------------------------------------------------------------------------
  Esta funcion que es una extención de Execute_SQL_Command, ejecuta uan cadena de comandos separados
  por ; y las ejecuta al mismo tiempo
  -------------------------------------------------------------------------------------------------- }
function Execute_SQL_Script(oConn_Tmp: TMyConnection; pScript: TStrings)
  : Boolean; overload;
begin
  if (oPub_Scp = NIL) then
    oPub_Scp := TMyScript.Create(nil);

  if isEmpty(pScript.text) = True then
  begin
    Result := False;
    exit;
  end;

  if Check_Host_IsAlive(oConn_Tmp.server, oConn_Tmp.Port) = False then
  begin
    Result := False;
    exit;
  end;

  oPub_Scp.Connection := oConn_Tmp;
  oPub_Scp.Delimiter := ';';
  oPub_Scp.SQL.text := pScript.text;
  try
    oPub_Scp.Execute;
    Result := True;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
end;

function Execute_SQL_Script(pScript: string): Boolean; overload;
begin
  if (oPub_Scp = NIL) then
    oPub_Scp := TMyScript.Create(nil);

  if isEmpty(pScript) = True then
  begin
    Result := False;
    exit;
  end;

  if (bConnectionOk = False) then
    Carga_Setting_Conn2();

  if Check_Host_IsAlive(Utiles.oMyPublicCnn.server, Utiles.oMyPublicCnn.Port) = False
  then
  begin
    Result := False;
    exit;
  end;

  oPub_Scp.Connection := Utiles.oMyPublicCnn;
  oPub_Scp.Delimiter := ';';
  oPub_Scp.SQL.text := pScript;
  try
    oPub_Scp.Execute;
    Result := True;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
end;

function Execute_SQL_Script(pScript: TStrings): Boolean; overload;
begin
  if (oPub_Scp = NIL) then
    oPub_Scp := TMyScript.Create(nil);

  if isEmpty(pScript.text) = True then
  begin
    Result := False;
    exit;
  end;

  if (bConnectionOk = False) then
    Carga_Setting_Conn2();

  if Check_Host_IsAlive(Utiles.oMyPublicCnn.server, Utiles.oMyPublicCnn.Port) = False
  then
  begin
    Result := False;
    exit;
  end;

  oPub_Scp.Connection := Utiles.oMyPublicCnn;
  oPub_Scp.Delimiter := ';';
  oPub_Scp.SQL.text := pScript.text;
  try
    oPub_Scp.Execute;
    Result := True;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
end;

function Execute_SQL_Command(pScript: TStringList): Boolean; overload;
begin
  if (oPub_Scp = NIL) then
    oPub_Scp := TMyScript.Create(nil);

  if isEmpty(pScript.text) = True then
  begin
    Result := False;
    exit;
  end;

  if (bConnectionOk = False) then
    Carga_Setting_Conn2();

  if Check_Host_IsAlive(Utiles.oPublicCnn.HostName, Utiles.oPublicCnn.Port) = False
  then
  begin
    Result := False;
    exit;
  end;

  oPub_Scp.Connection := Utiles.oMyPublicCnn;
  oPub_Scp.Delimiter := ';';
  oPub_Scp.SQL.text := pScript.text;
  try
    oPub_Scp.Execute;
    Result := True;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
end;

function Execute_SQL_Command_Tmp(pSQL: string; oSetting_Tmp: Config2)
  : Boolean; overload;
var
  oConn: TMyConnection;
begin
  if (oPub_Com = NIL) then
    oPub_Com := TMyCommand.Create(nil);

  oConn := TMyConnection.Create(nil);
  oConn.server := oSetting_Tmp.host;
  oConn.Username := oSetting_Tmp.usuario;
  oConn.Password := oSetting_Tmp.clave;
  oConn.Port := oSetting_Tmp.puerto;

  if Check_Host_IsAlive(oConn.server, oConn.Port) = False then
  begin
    Result := False;
    exit;
  end;

  try
    oConn.Connect;
    Utiles.bConnectionOk := oConn.Connected;

    oPub_Com.Connection := oConn;
    oPub_Com.SQL.text := pSQL;
    oPub_Com.Execute;
    Result := True;
  finally
    Result := False;
    oConn.Free;
  end;
end;

function Execute_SQL_Command_Tmp(pSQL: string; oConn_Tmp: TMyConnection)
  : Boolean; overload;
begin
  if (oPub_Com = NIL) then
    oPub_Com := TMyCommand.Create(nil);

  if Check_Host_IsAlive(oConn_Tmp.server, oConn_Tmp.Port) = False then
  begin
    Result := False;
    exit;
  end;
  try
    oPub_Com.Connection := oConn_Tmp;
    oPub_Com.SQL.Clear;
    oPub_Com.SQL.text := pSQL;
    oPub_Com.Execute;
    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

function Execute_SQL_Command_Tmp(pScript: TStringList; oConn_Tmp: TMyConnection)
  : Boolean; overload;
var
  SqlProcessor: TZSqlProcessor;
begin
  if oPub_Scp = nil then
    oPub_Scp := TMyScript.Create(nil);

  if isEmpty(pScript.text) = True then
  begin
    Result := False;
    exit;
  end;

  if (bConnectionOk = False) then
    Carga_Setting_Conn2();

  if Check_Host_IsAlive(oConn_Tmp.server, oConn_Tmp.Port) = False then
  begin
    Result := False;
    exit;
  end;

  oPub_Scp.Connection := oConn_Tmp;
  oPub_Scp.Delimiter := ';';
  oPub_Scp.SQL.text := pScript.text;
  try
    oPub_Scp.Execute;
    Result := True;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
end;

function Execute_SQL_Command_Tmp_Fle(pFilename: string;
  oConn_Tmp: TMyConnection): Boolean; overload;
begin
  if oPub_Scp = nil then
    oPub_Scp := TMyScript.Create(nil);

  if isEmpty(pFilename) = True then
  begin
    Result := False;
    exit;
  end;

  if Check_Host_IsAlive(oConn_Tmp.server, oConn_Tmp.Port) = False then
  begin
    Result := False;
    exit;
  end;

  oPub_Scp.Connection := oConn_Tmp;
  oPub_Scp.Delimiter := ';';
  oPub_Scp.SQL.LoadFromFile(pFilename);
  try
    oPub_Scp.Execute;
    Result := True;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
end;

function BuscarUsuario(var oQry1: Tzquery; sUsuario: string;
  bCheckActive: Boolean = True): integer;
var
  cSql: string;
begin
  oQry1.Connection := Utiles.oPublicCnn;
  if bCheckActive = False then
    cSql := 'SELECT * FROM usuarios WHERE u_usuario = "' + '' + sUsuario
      + '' + '"'
  else
    cSql := 'SELECT * FROM usuarios WHERE u_activo = 1 AND u_usuario = "' + '' +
      sUsuario + '' + '"';

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

procedure CenterForm(AForm: Tform);
var
  ALeft, ATop: integer;
begin
  ALeft := (Screen.Width - AForm.Width) div 2;
  ATop := (Screen.Height - AForm.Height) div 2;
  { prevents form being twice repainted! }
  AForm.SetBounds(ALeft, ATop, AForm.Width, AForm.Height);
end;

procedure CenterFormOverActive(AForm: Tform);
var
  ALeft, ATop: integer;
begin
  ALeft := Screen.ActiveForm.Left + (Screen.ActiveForm.Width div 2) -
    (AForm.Width div 2);
  ATop := Screen.ActiveForm.Top + (Screen.ActiveForm.Height div 2) -
    (AForm.Height div 2);
  { prevent form from being outside screen }
  if ALeft < 0 then
    ALeft := Screen.ActiveForm.Left;
  if ATop < 0 then
    ATop := Screen.ActiveForm.Top;
  if (ALeft + AForm.Width > Screen.Width) or
    (ATop + AForm.Height > Screen.Height) then
    CenterForm(AForm)
  else
    { prevents form being twice repainted! }
    AForm.SetBounds(ALeft, ATop, AForm.Width, AForm.Height);
end;

function iif(Test: Boolean; TrueR, FalseR: variant): variant;
begin
  if Test then
    Result := TrueR
  else
    Result := FalseR;
end;

function GetVersion(sFilename: string): string;
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

function CreateProcessWithLogonW(lpUsername: PWideChar; lpDomain: PWideChar;
  lpPassword: PWideChar; dwLogonFlags: DWORD; lpApplicationName: PWideChar;
  lpCommandLine: PWideChar; dwCreationFlags: DWORD; lpEnvironment: Pointer;
  lpCurrentDirectory: PWideChar;

  const lpStartupInfo: TStartupInfo;

  var lpProcessInformation: TProcessInformation): BOOL; stdcall;
  external 'advapi32.dll' name 'CreateProcessWithLogonW';

procedure RunAs(AUsername, APassword, ADomain, AApplication: string);
const
  LOGON_WITH_PROFILE = $00000001;
var
  si: TStartupInfo;
  pi: TProcessInformation;
begin
  ZeroMemory(@si, SizeOf(si));
  si.cb := SizeOf(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_NORMAL;
  ZeroMemory(@pi, SizeOf(pi));

  if not CreateProcessWithLogonW(PWideChar(widestring(AUsername)),
    PWideChar(widestring(ADomain)), PWideChar(widestring(APassword)),
    LOGON_WITH_PROFILE, nil, PWideChar(widestring(AApplication)), 0, nil, nil,
    si, pi) then
    RaiseLastOSError;

  CloseHandle(pi.hThread);
  CloseHandle(pi.hProcess);
end;

procedure Create_Blank_Tables(sFilename: string);
var
  sLineCMD: string;
  sParamet: string;
  Response: integer;
begin
  try
    sParamet := ' --host=' + trim(Utiles.oSetting_Fac.host) +
      ' --user=root --password= -d ' + trim(Utiles.oSetting_Fac.database) +
      ' > ' + sFilename;
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

procedure ShellExecute_AndWait(FileName: string; Params: string);
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

procedure LogToFile(const S, FileName: string);
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

function Add_query_in_Combo(pFieldText: string; pFieldKey: string; pSQL: string;
  var oCombo: TDBComboBoxEh): Boolean;
var
  oQuery1: Tzquery;
  sText: string;
  s_Key: string;
begin
  Result := False;
  try
    oCombo.Clear;
    oCombo.KeyItems.Clear;
    oCombo.Items.Clear;
    if Utiles.Exec_Select_SQL(oQuery1, pSQL, True, True, False) = False then
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

function LoadDatabaseInServer(pServer: string;

  var oCombo: TcomboBox): Boolean;
var
  oQuery1: Tzquery;
  sText: string;
begin
  Result := False;
  try
    oCombo.Clear;
    Utiles.Exec_Select_SQL(oQuery1, 'SHOW DATABASES', True, True, False);
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

procedure MoveDBGridColumns(DBGrid: TDBGridEh; FromColumn, ToColumn: integer);
begin
  THackAccess(DBGrid).MoveColumn(FromColumn, ToColumn);
end;

function GetWindowsDir: TFileName;
var
  WinDir: array [0 .. MAX_PATH - 1] of Char;
begin
  SetString(Result, WinDir, GetWindowsDirectory(WinDir, MAX_PATH));
  if Result = '' then
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

function GetSystemDir: TFileName;
var
  SysDir: array [0 .. MAX_PATH - 1] of Char;
begin
  SetString(Result, SysDir, GetSystemDirectory(SysDir, MAX_PATH));
  if Result = '' then
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

function GetProgramFilesDir: TFileName;
begin
  Result := GetRegistryData(HKEY_LOCAL_MACHINE,
    '\Software\Microsoft\Windows\CurrentVersion', 'ProgramFilesDir');
end;

function GetRegistryData(RootKey: HKEY; key, Value: string): variant;
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

procedure SetRegistryData(RootKey: HKEY; key, Value: string;
  RegDataType: TRegDataType; Data: variant);
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

function BemaFI32INI(iRuta: integer = 1; iGetValue: integer = 0;
  sPort: string = ''): string;
var
  sPath: string;
  oFile: Tinifile;
begin

  if iRuta = 1 then
    sPath := Utiles.GetSystemDir() + '\BemaFI32.ini'
  else
    sPath := ExtractFilePath(Application.ExeName) +
      'data\utiles\librerias\BemaFI32.ini';

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

function RightStr(const Str: string; Size: Word): string;
begin
  if Size > Length(Str) then
    Size := Length(Str);
  RightStr := Copy(Str, Length(Str) - Size + 1, Size)
end;

function MidStr(const Str: string; From, Size: Word): string;
begin
  MidStr := Copy(Str, From, Size)
end;

function LeftStr(const Str: string; Size: Word): string;
begin
  LeftStr := Copy(Str, 1, Size)
end;

function SetScreenResolution(Width, Height: integer): Longint;
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

function TamanoFichero(sFileToExamine: string): Longword;
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
    SysUtils.FindClose(SearchRec);
  end;
  Result := I1;
end;


// Para comprobar si el servicio se esta ejecutando

function ServiceisRunning(nombre: string): Boolean;
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

function ServiceIsInstalled(nombre: string): Boolean;
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

function GetMysqlVariables(pVariable: string): string;
var
  oQry: Tzquery;
begin
  oQry := Tzquery.Create(nil);
  Utiles.Exec_Select_SQL(oQry, 'SHOW VARIABLES', True, True, False);
  while not oQry.eof do
  begin
    if oQry.FieldByName(pVariable).AsString = 'basedir' then
    begin
      GetMysqlVariables := oQry.FieldByName('Value').AsString
    end;
    oQry.Next;
  end;
end;

function WinExecAndWait32(FileName: string; Visibility: integer): integer;
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

function Win32CreateProcess(const FileName, Parameters: string;

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

procedure Delay(msecs: integer);
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

function MysQL_Processing_DB(DBName: string): Boolean;
var
  oQry: Tzquery;
begin
  Result := False;
  Utiles.Exec_Select_SQL(oQry, 'SHOW PROCESSLIST', True, True, False);
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

function TableExists(DBName: string; TableName: string): Boolean;
var
  oQryFlds: Tzquery;
  cSqlCmdl: string;
begin
  cSqlCmdl := 'SHOW TABLES FROM ' + DBName + ' LIKE "' + TableName + '" ';
  Utiles.Exec_Select_SQL(oQryFlds, cSqlCmdl, True, True, False);
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

function DatabaseExists(DBName: string): Boolean;
var
  cSqlCmdl: string;
begin
  if oExe_SQL = nil then
    oExe_SQL := Tzquery.Create(nil);
  cSqlCmdl := 'SHOW DATABASES LIKE "' + DBName + '" ';
  Utiles.Exec_Select_SQL(oExe_SQL, cSqlCmdl, True, False, False);
  if not oExe_SQL.eof then
  begin
    if oExe_SQL.RecordCount > 0 then
      Result := True
    else
      Result := False;
  end
  else
    Result := False;
  oExe_SQL.Close;
end;

{ --------------------------------------------------------------------------------------------
  Esta función devuelve true si el campo existe en la tabla y false si no existe.
  ---------------------------------------------------------------------------------------------- }

function FieldExists(field: string; Full_DB_Table_Name: string): Boolean;
var
  cSqlCmdl: string;
begin
  if oQryFlds = nil then
    oQryFlds := Tzquery.Create(nil);
  cSqlCmdl := 'SHOW COLUMNS FROM ' + Full_DB_Table_Name +
    ' WHERE UCASE(field)=UCASE("' + trim(field) + '") ';
  if Utiles.Exec_Select_SQL(oQryFlds, cSqlCmdl, True, True, False) = True then
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
  oQryFlds.Close;
end;

{ --------------------------------------------------------------------------------------------
  Esta función devuelve true si el campo existe en la tabla y false si no existe.
  ---------------------------------------------------------------------------------------------- }

function FieldExists2(var field: string; Full_DB_Table_Name: string): Boolean;
var
  oQryFlds: Tzquery;
  cSqlCmdl: string;
begin
  cSqlCmdl := 'SHOW COLUMNS FROM ' + Full_DB_Table_Name +
    ' WHERE UCASE(field)=UCASE("' + trim(field) + '") ';
  if Utiles.Exec_Select_SQL(oQryFlds, cSqlCmdl, True, True, False) = True then
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

function Tables_Counts(DB_Name: string): integer;
var
  oQryCKFL: Tzquery;
begin
  Result := 0;
  DB_Name := trim(DB_Name);
  Utiles.Exec_Select_SQL(oQryCKFL, 'SHOW TABLE STATUS FROM `' + DB_Name +
    '` WHERE COMMENT=""', True, True, False);
  if not oQryCKFL.eof then
    Result := oQryCKFL.RecordCount;
  oQryCKFL.Free;
end;

{ --------------------------------------------------------------------------------------------
  Esta función devuelve el numero de campos de una tabla, es necesarios especificada la tabla .
  ---------------------------------------------------------------------------------------------- }

function Fields_Counts(Full_DB_Table_Name: string): integer;
var
  oQryCKFL: Tzquery;
  cSqlCmdl: string;
begin
  Result := 0;
  cSqlCmdl := 'SHOW COLUMNS FROM ' + Full_DB_Table_Name + ' ';
  Utiles.Exec_Select_SQL(oQryCKFL, cSqlCmdl, True, True, False);
  if not oQryCKFL.eof then
    Result := oQryCKFL.RecordCount;
  oQryCKFL.Free;
end;

{ --------------------------------------------------------------------------------------------
  Esta función busca la llave primaria de una tabla especificada.
  ---------------------------------------------------------------------------------------------- }

function Find_PrimaryKey(TableName: string): string;
var
  oQryCmd: Tzquery;
begin
  Result := '';
  Utiles.Exec_Select_SQL(oQryCmd, 'SHOW COLUMNS FROM ' + TableName +
    ' WHERE `KEY`="PRI" ', True, True, False);
  if not oQryCmd.eof then
    Result := oQryCmd.FieldByName('field').AsString;
  oQryCmd.Free;
end;

{ --------------------------------------------------------------------------------------------
  esta función duplica un caracter las cantidad de veces especificada.
  Cadena:=Replicate('=',20)
  devuelve a cadena '===================='
  ---------------------------------------------------------------------------------------------- }

function Replicate(Caracter: string; Quant: integer): string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to Quant do
    Result := Result + Caracter;
end;

procedure SyncSaveEnvList(cPath: string; cFileName: string = 'Index.txt';
  cText: string = '');
var
  LogFile: textfile;
  cFullPath: string;
begin
  cFullPath := trim(cPath) + iif(RightStr(trim(cPath), 1) = '\', '', '\') +
    trim(cFileName);
  if not FileCtrl.DirectoryExists(cPath) then
    FileCtrl.ForceDirectories(cPath);
  AssignFile(LogFile, cFullPath);
  try
    if SysUtils.FileExists(cFullPath) then
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

function StringToHex(S: string): string;
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

function HexToString(S: string): string;
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
  esta función lee las variebles del sistema que estan en sysdb_config y activa los triggers
  si estos estan configurados.
  ---------------------------------------------------------------------------------------------- }

procedure Read_Trigger_Vars;
var
  oQrydbs: Tzquery;
  SqlSel: string;
begin
  SqlSel := '';
  SqlSel := SqlSel + 'SELECT * FROM sysdb_config ';
  if Utiles.Exec_Select_SQL(oQrydbs, SqlSel, True, True) = False then
  begin
    freeandnil(oQrydbs);
    Utiles.Execute_SQL_Command('SET @CodigoSuc=0;');
    exit;
  end;
  if oQrydbs.eof then
  begin
    freeandnil(oQrydbs);
    Utiles.Execute_SQL_Command('SET @CodigoSuc=0;');
    exit;
  end;
  oQrydbs.First;
  CodigoSuc := oQrydbs.FieldByName('DB_CODIGO').AsString;
  TriggerOk := oQrydbs.FieldByName('ACTIVE_TRIGGER').AsString;

  Utiles.Execute_SQL_Command('SET @CodigoSuc=' + trim(CodigoSuc) + ' ; ');
  freeandnil(oQrydbs);
end;

function Verify_sysdb_config: Boolean;
var
  SqlCmd: string;
  oQryGen: Tzquery;
begin
  Result := False;

  SqlCmd := '';
  SqlCmd := SqlCmd + 'CREATE TABLE IF NOT EXISTS `sysdb_config` ( ';
  SqlCmd := SqlCmd + '`id_reg` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, ';
  SqlCmd := SqlCmd + '`db_codigo` INT(10) UNSIGNED NULL DEFAULT "0", ';
  SqlCmd := SqlCmd + '`active_trigger` TINYINT(1) UNSIGNED NULL DEFAULT NULL, ';
  SqlCmd := SqlCmd + '`ACTIVE_SRVCAM` TINYINT(1) NULL DEFAULT NULL, ';
  SqlCmd := SqlCmd + '`port_dvrcam` INT(4) NULL DEFAULT NULL, ';
  SqlCmd := SqlCmd + '`host_dvrcam` VARCHAR(60) NULL DEFAULT "127.0.0.1", ';
  SqlCmd := SqlCmd +
    '`apply_datetm` DATETIME NULL DEFAULT "0000-00-00 00:00:00", ';
  SqlCmd := SqlCmd + '`active_balanza` TINYINT(1) NULL DEFAULT "0", ';
  SqlCmd := SqlCmd + '`bal_dig` TINYINT(1) NULL DEFAULT "2", ';
  SqlCmd := SqlCmd + '`bal_verifpeso` TINYINT(1) NULL DEFAULT "0", ';
  SqlCmd := SqlCmd + '`bal_longmed` TINYINT(1) NULL DEFAULT "5", ';
  SqlCmd := SqlCmd + '`bal_logdec` TINYINT(3) NULL DEFAULT "3", ';
  SqlCmd := SqlCmd + '`bal_longplu` TINYINT(1) NULL DEFAULT "5", ';
  SqlCmd := SqlCmd + '`bal_codref` TINYINT(1) NULL DEFAULT "1", ';
  SqlCmd := SqlCmd + '`balc_dig` TINYINT(1) NULL DEFAULT "2", ';
  SqlCmd := SqlCmd + '`balc_verifcant` TINYINT(1) NULL DEFAULT "1", ';
  SqlCmd := SqlCmd + '`balc_longmed` TINYINT(1) NULL DEFAULT "5", ';
  SqlCmd := SqlCmd + '`balc_logdec` TINYINT(3) NULL DEFAULT "0", ';
  SqlCmd := SqlCmd + '`balc_longplu` TINYINT(1) NULL DEFAULT "5", ';
  SqlCmd := SqlCmd + '`balc_codref` TINYINT(1) NULL DEFAULT "1", ';
  SqlCmd := SqlCmd + 'PRIMARY KEY (`id_reg`)) ';
  SqlCmd := SqlCmd + 'COLLATE="utf8_general_ci" ';
  SqlCmd := SqlCmd + 'ENGINE=InnoDB ';
  SqlCmd := SqlCmd + 'AUTO_INCREMENT=0; ';
  Utiles.Execute_SQL_Command(SqlCmd);

  if Utiles.Exec_Select_SQL(oQryGen, 'SELECT * FROM sysdb_config ', True, True)
    = False then
  begin
    SqlCmd := '';
    SqlCmd := SqlCmd + 'INSERT INTO `sysdb_config` (DB_CODIGO) VALUES (1)';
    Utiles.Execute_SQL_Command(SqlCmd);
  end;

  if Utiles.FieldExists('FIND_DVRCAM', 'sysdb_config') then
  begin
    SqlCmd := '';
    SqlCmd := SqlCmd +
      'ALTER TABLE `sysdb_config`  CHANGE COLUMN `FIND_DVRCAM` `ACTIVE_SRVCAM` TINYINT(1) NOT NULL DEFAULT "0" AFTER `ACTIVE_TRIGGER`; ';
    Utiles.Execute_SQL_Command(SqlCmd);
  end;
end;

{ --------------------------------------------------------------------------------------------
  // Esta función muestra el numero de dia que desde enero hasta la fecha x de un año
  //o de una fecha.
  // [Meeus91, p. 65]
  // DayOfYear(1978, 11, 14) = 318
  // DayOfYear(2000, 11, 14) = 319
  ---------------------------------------------------------------------------------------------- }

function DayOfYear(const Year, Month, Day: Word): integer;
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

function LastDayInMonth(const Year, Month: Word): TDateTime;
begin
  if Month = 12 then
    Result := EncodeDate(Year + 1, 1, 1) - 1
  else
    Result := EncodeDate(Year, Month + 1, 1) - 1;
end;

{ --------------------------------------------------------------------------------------------
  Esta función encripta y desencripta una cadena.
  ---------------------------------------------------------------------------------------------- }

function ASCIIEncrypt(Data, Cipher: string): string;
var
  i, Z: integer;
  c: Char;
  Code: Byte;
begin
  Result := '';
  if Length(Data) > 0 then
  begin
    Z := Length(Cipher);
    for i := 1 to Length(Data) do
    begin
      Code := Ord(Cipher[(i - 1) mod Z + 1]);
      if Data[i] >= #128 then
        c := Chr(Ord(Data[i]) xor (Code and $7F))
      else if Data[i] >= #64 then
        c := Chr(Ord(Data[i]) xor (Code and $3F))
      else if Data[i] >= #32 then
        c := Chr(Ord(Data[i]) xor (Code and $1F))
      else
        c := Data[i];
      Result := Result + c;
    end;
  end;
end;

{ ---------------------------------------------------------------------------------------------- }
{ Esta función muestra el devuelve el directorio temporal de la carpeta del windows. }
{ ---------------------------------------------------------------------------------------------- }

function GetWindowsTempDirectory: string;
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

procedure FindAllFiles(const Path: string; Attr: integer; List: TStrings);
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

function WaitStart(TheParent: TComponent; sMsg: string): Boolean;
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

      SetWindowLong(handle, GWL_STYLE, GetWindowLong(handle, GWL_STYLE) and
        not WS_CAPTION);
      ClientHeight := Height;

      Show;
      Update;
    end;
    Result := True;
  end;
end;

{ ---------------------------------------------2--------------------------------------------------- }

procedure WaitSetMsg(sMsg: string);
begin
  WaitLabel.Caption := sMsg;
  WaitForm.Refresh;
end;

{ ---------------------------------------------3--------------------------------------------------- }

function WaitEnd: Boolean;
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

function UnformatNumber(Val: string): string;
begin
  Result := Val;
  if ThousandSeparator <> DecimalSeparator then
    Result := StringReplace(Result, ThousandSeparator, '', [rfReplaceAll]);
  Result := StringReplace(Result, DecimalSeparator, '.', [rfReplaceAll]);
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
  Result := StringReplace(Str, '.', DecimalSeparator, [rfReplaceAll]);
  if Thousands then
  begin
    if ((Length(Result) >= 1) and (Result[1] = '0')) or
      ((Length(Result) >= 2) and (Result[1] = '-') and (Result[2] = '0')) then
      exit;
    p := Pos(DecimalSeparator, Result);
    if p = 0 then
      p := Length(Result) + 1;
    Left := 2;
    if (Length(Result) >= 1) and (Result[1] = '-') then
      Left := 3;
    if p > 0 then
      for i := p - 1 downto Left do
      begin
        if (p - i) mod 3 = 0 then
          Insert(ThousandSeparator, Result, i);
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
  Return a formatted number from a float This function is called by two overloaded functions
  @param double Number to format
  @param integer Number of decimals
  @return string
  ---------------------------------------------------------------------------------------------- }

function FormatNumber(flt: Double; decimals: integer = 0;
  Thousands: Boolean = True): string; overload;
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

function IsNumber(const c: Char): Boolean;
var
  b: Word;
begin
  b := Ord(c);
  Result := (b >= 48) and (b <= 57);
end;

function Product_Unpacking(pPrCodigo: string; pCant_Solic: integer): integer;
var
  nFactC, nNivel: integer;
  nExisCal, nExisTot: integer;
  oQry_Cmd2: Tzquery;
  cSql_Str: string;
begin
  oQry_Cmd2 := Tzquery.Create(nil);
  nNivel := 1;
  nFactC := 1;
  nExisTot := 0;
  nExisCal := 0;

  cSql_Str := '';
  cSql_Str := cSql_Str + 'SELECT ';
  cSql_Str := cSql_Str + '  a.pr_Id         as Codigo, ';
  cSql_Str := cSql_Str + '  a.pr_id_enlace  as CodigoS, ';
  cSql_Str := cSql_Str + '  e1.p_existencia as Exist ';
  cSql_Str := cSql_Str + 'FROM productos a ';
  cSql_Str := cSql_Str +
    '  LEFT OUTER JOIN prod_existencia e1 ON a.pr_Id  = e1.pr_Id ';
  cSql_Str := cSql_Str + '  WHERE a.pr_Id="' + trim(pPrCodigo) + '"    ';
  cSql_Str := cSql_Str + '  AND e1.p_existencia_dep_id=1 ';
  cSql_Str := cSql_Str + '  ORDER BY  a.pr_Id ';
  if Utiles.Exec_Select_SQL(oQry_Cmd2, cSql_Str, True, True) = False then
  begin
    Result := 0;
    exit;
  end;
  if oQry_Cmd2.FieldByName('CodigoS').text = '' then
  begin
    Result := oQry_Cmd2.FieldByName('Exist').AsInteger;
    exit;
  end;
  while pPrCodigo <> '' do
  begin
    Product_Unpacking_Level(pPrCodigo, nFactC, nExisCal, pCant_Solic, nNivel);
    nExisTot := nExisTot + nExisCal;
    inc(nNivel);
  end;
  Result := nExisTot;
end;

procedure Product_Unpacking_Level(var pPrCodigo: string;

  var pFactC: integer;

  var pUnid_Dev: integer; pUnid_Ped: integer; pIndex: integer);
var
  cSql_Str: string;
  nExistAc1: integer;
  nExistAc2: integer;
  oQry_Cmd: Tzquery;
begin
  oQry_Cmd := Tzquery.Create(nil);

  cSql_Str := '';
  cSql_Str := cSql_Str + 'SELECT ';
  cSql_Str := cSql_Str + '  a.pr_Id           as CodigoP, ';
  cSql_Str := cSql_Str + '  a.pr_exist_cargar as UnidCargo, ';
  cSql_Str := cSql_Str + '  e1.p_existencia    as Exist_P, ';
  cSql_Str := cSql_Str + '  d1.pr_costo_prom   as CostoP, ';
  cSql_Str := cSql_Str + '  a.pr_id_enlace    as CodigoS, ';
  cSql_Str := cSql_Str + '  a.pr_exist_descar as UnidDesc, ';
  cSql_Str := cSql_Str + '  e2.p_existencia    as Exist_S, ';
  cSql_Str := cSql_Str + '  d2.pr_costo_prom   as CostoS ';
  cSql_Str := cSql_Str + 'FROM productos a ';
  cSql_Str := cSql_Str +
    '  LEFT OUTER JOIN productos_det d1   ON a.pr_Id  = d1.pr_Id ';
  cSql_Str := cSql_Str +
    '  LEFT OUTER JOIN productos_det d2   ON a.pr_id_enlace = d2.pr_Id ';
  cSql_Str := cSql_Str +
    '  LEFT OUTER JOIN prod_existencia e1 ON a.pr_Id  = e1.pr_Id ';
  cSql_Str := cSql_Str +
    '  LEFT OUTER JOIN prod_existencia e2 ON a.pr_id_enlace = e2.pr_Id ';
  cSql_Str := cSql_Str + '  WHERE a.pr_Id="' + trim(pPrCodigo) + '" ';
  cSql_Str := cSql_Str + '  AND e1.p_existencia_dep_id=1 ';
  cSql_Str := cSql_Str + '  AND e2.p_existencia_dep_id=1 ';
  cSql_Str := cSql_Str + '  AND d1.pr_activo=1 ';
  cSql_Str := cSql_Str + '  AND d2.pr_activo=1 ';
  cSql_Str := cSql_Str + '  AND d1.suc_Id=1 ';
  cSql_Str := cSql_Str + '  AND d2.suc_Id=1 ';
  cSql_Str := cSql_Str + '  ORDER BY  a.pr_Id ';
  if Utiles.Exec_Select_SQL(oQry_Cmd, cSql_Str, True, True) = False then
  begin
    pPrCodigo := '';
    exit;
  end;
  if not Utiles.isEmpty(oQry_Cmd.FieldByName('CodigoS').AsString) then
  begin
    if pIndex = 1 then
      nExistAc1 := (pFactC * oQry_Cmd.FieldByName('Exist_P').AsInteger)
    else
      nExistAc1 := 0;
    pFactC := (pFactC * oQry_Cmd.FieldByName('UnidCargo').AsInteger);
    nExistAc2 := nExistAc1 + (pFactC * oQry_Cmd.FieldByName('Exist_S')
      .AsInteger);
    if (pUnid_Ped > nExistAc1) then
    begin
      if pUnid_Ped > nExistAc2 then
        pPrCodigo := oQry_Cmd.FieldByName('CodigoS').AsString
      else
        pPrCodigo := '';
    end
    else
      pPrCodigo := '';
    pUnid_Dev := pUnid_Dev + nExistAc2;
  end
  else
  begin
    pPrCodigo := '';
  end;
end;

{ --------------------------------------------------------------------------------------------
  // Devuelve -1, 0 o 1 de acuerdo al signo del argumento
  -------------------------------------------------------------------------------------------- }

function Sgn(X: Single): integer;
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

function RoundUp(X: Single): Single;
begin
  Result := int(X) + Sgn(Frac(X));
end;

{ --------------------------------------------------------------------------------------------
  // Devuelve el primer entero menor que o igual al número dado en valor absoluto
  // (se preserva el signo).
  //   RoundDn(3.7) = 3    RoundDn(-3.7) = -3
  -------------------------------------------------------------------------------------------- }

function RoundDn(X: Single): Single;
begin
  Result := int(X);
end;

function Aplly_Unpacking(pid_Op: integer; pPrCodigo: string;
  pId_DepInve: integer; pCant_Solic: Single;

  var oVTable: TVirtualTable): Single;
var
  nExisCal, nExisTot, nFx: Single;
  nFactC, nNivel: integer;
  cSql_Str: string;
  oQry_Cmd2: Tzquery;
  oTable: TVirtualTable;
begin
  oTable := TVirtualTable.Create(nil);
  with oTable do
  begin
    Active := False;
    FieldDefs.Add('CodigoP', ftString, 20);
    FieldDefs.Add('UnidCargo', ftfloat, 0);
    FieldDefs.Add('Exist_P', ftfloat, 0);
    FieldDefs.Add('Exist_FinalP', ftfloat, 0);
    FieldDefs.Add('CostoP', ftfloat, 0);
    FieldDefs.Add('Carga_Inv', ftfloat, 0);
    FieldDefs.Add('CodigoS', ftString, 20);
    FieldDefs.Add('UnidDesc', ftfloat, 0);
    FieldDefs.Add('Exist_S', ftfloat, 0);
    FieldDefs.Add('Exist_FinalS', ftfloat, 0);
    FieldDefs.Add('CostoS', ftfloat, 0);
    FieldDefs.Add('Desc_Inv', ftfloat, 0);
    FieldDefs.Add('fx_1', ftfloat, 0);
    FieldDefs.Add('nivel', ftInteger, 0);
    Active := True;
    Clear
  end;
  oQry_Cmd2 := Tzquery.Create(nil);
  nNivel := 1;
  nFactC := 1;
  nExisTot := 0;
  nExisCal := 0;
  nFx := 0;
  cSql_Str := '';
  cSql_Str := cSql_Str + 'SELECT ';
  cSql_Str := cSql_Str + '  a.pr_Id         as Codigo, ';
  cSql_Str := cSql_Str + '  a.pr_id_enlace  as CodigoS, ';
  cSql_Str := cSql_Str + '  e1.p_existencia as Exist ';
  cSql_Str := cSql_Str + 'FROM productos a ';
  cSql_Str := cSql_Str +
    '  LEFT OUTER JOIN prod_existencia e1 ON a.pr_Id  = e1.pr_Id ';
  cSql_Str := cSql_Str + '  WHERE a.pr_Id="' + trim(pPrCodigo) + '"    ';
  cSql_Str := cSql_Str + '  AND e1.p_existencia_dep_id=1 ';
  cSql_Str := cSql_Str + '  ORDER BY  a.pr_Id ';
  if Utiles.Exec_Select_SQL(oQry_Cmd2, cSql_Str, True, True) = False then
  begin
    Result := 0;
    exit;
  end;
  if oQry_Cmd2.FieldByName('CodigoS').text = '' then
  begin
    Result := oQry_Cmd2.FieldByName('Exist').AsFloat;
    exit;
  end;
  while pPrCodigo <> '' do
  begin
    Utiles.Aplly_Unpacking_Level(oTable, pPrCodigo, pId_DepInve, nFactC,
      nExisCal, pCant_Solic, nFx, nNivel, 1, 1);
    nExisTot := nExisTot + nExisCal;
    inc(nNivel);
  end;
  Result := nExisTot;
  if oVTable <> nil then
    oVTable := oTable
  else
    freeandnil(oTable);
end;

procedure Aplly_Unpacking_Level(var oTable: TVirtualTable;

  var pPrCodigo: string;

  const pId_Deposito: integer;

  var pFactC: integer;

  var pUnid_Dev: Single; pUnid_Ped: Single;

  var pFx1: Single; pIndex: integer; pTotCarg: Single; pTotDesc: Single);
var
  nExistAc1, nExistAc2, iTmp1, iTmp2: Single;
  cSql_Str: string;
  oQry_Cmd: Tzquery;
begin
  oQry_Cmd := Tzquery.Create(nil);

  cSql_Str := '';
  cSql_Str := cSql_Str + 'SELECT ';
  cSql_Str := cSql_Str + '  a.pr_Id           AS CodigoP, ';
  cSql_Str := cSql_Str + '  a.pr_exist_cargar AS UnidCargo, ';
  cSql_Str := cSql_Str + '  a.pr_Id AS Tipo, ';
  cSql_Str := cSql_Str + '  e1.p_existencia    AS Exist_P, ';
  cSql_Str := cSql_Str + '  d1.pr_costo_prom   AS CostoP, ';
  cSql_Str := cSql_Str + '  a.pr_id_enlace    AS CodigoS, ';
  cSql_Str := cSql_Str + '  a.pr_exist_descar AS UnidDesc, ';
  cSql_Str := cSql_Str + '  e2.p_existencia    AS Exist_S, ';
  cSql_Str := cSql_Str + '  d2.pr_costo_prom   AS CostoS ';
  cSql_Str := cSql_Str + 'FROM productos a ';
  cSql_Str := cSql_Str +
    '  LEFT OUTER JOIN productos_det d1   ON a.pr_Id  = d1.pr_Id ';
  cSql_Str := cSql_Str +
    '  LEFT OUTER JOIN productos_det d2   ON a.pr_id_enlace = d2.pr_Id ';
  cSql_Str := cSql_Str +
    '  LEFT OUTER JOIN prod_existencia e1 ON a.pr_Id  = e1.pr_Id ';
  cSql_Str := cSql_Str +
    '  LEFT OUTER JOIN prod_existencia e2 ON a.pr_id_enlace = e2.pr_Id ';
  cSql_Str := cSql_Str + '  WHERE a.pr_Id="' + trim(pPrCodigo) + '" ';
  cSql_Str := cSql_Str + '  AND e1.p_existencia_dep_id="' +
    trim(IntToStr(pId_Deposito)) + '" ';
  cSql_Str := cSql_Str + '  AND e2.p_existencia_dep_id="' +
    trim(IntToStr(pId_Deposito)) + '" ';
  cSql_Str := cSql_Str + '  AND d1.pr_activo=1 ';
  cSql_Str := cSql_Str + '  AND d2.pr_activo=1 ';
  cSql_Str := cSql_Str + '  AND d1.suc_Id="' +
    trim(IntToStr(Utiles.iId_Empresa)) + '" ';
  cSql_Str := cSql_Str + '  AND d2.suc_Id="' +
    trim(IntToStr(Utiles.iId_Empresa)) + '" ';
  cSql_Str := cSql_Str + '  AND a.pr_tipo=2 '; // Sólo productos de desempaque
  cSql_Str := cSql_Str + '  ORDER BY  a.pr_Id ';

  if Utiles.Exec_Select_SQL(oQry_Cmd, cSql_Str, True, True) = False then
  begin
    pPrCodigo := '';
    exit;
  end;
  {
    if oQry_Cmd.FieldByName('Tipo').AsInteger<>2 then
    begin
    pPrCodigo := '';
    exit;
    end;
  }
  oTable.Insert;
  oTable.FieldByName('CodigoP').AsString :=
    oQry_Cmd.FieldByName('CodigoP').AsString;
  oTable.FieldByName('UnidCargo').AsFloat :=
    oQry_Cmd.FieldByName('UnidCargo').AsFloat;
  oTable.FieldByName('Exist_P').AsFloat :=
    oQry_Cmd.FieldByName('Exist_P').AsFloat;
  oTable.FieldByName('CostoP').AsFloat :=
    oQry_Cmd.FieldByName('CostoP').AsFloat;
  oTable.FieldByName('CodigoS').AsString :=
    oQry_Cmd.FieldByName('CodigoS').AsString;
  oTable.FieldByName('UnidDesc').AsFloat :=
    oQry_Cmd.FieldByName('UnidDesc').AsFloat;
  oTable.FieldByName('Exist_S').AsFloat :=
    oQry_Cmd.FieldByName('Exist_S').AsFloat;
  oTable.FieldByName('CostoS').AsFloat :=
    oQry_Cmd.FieldByName('CostoS').AsFloat;

  if pIndex = 1 then
    iTmp2 := oQry_Cmd.FieldByName('Exist_P').AsFloat - pUnid_Ped
  else
    iTmp2 := (oQry_Cmd.FieldByName('Exist_P').AsFloat) - pFx1;

  iTmp1 := Utiles.RoundUp((iTmp2 * -1) / oQry_Cmd.FieldByName
    ('UnidCargo').AsFloat);
  oTable.FieldByName('fx_1').AsFloat := iTmp2;
  oTable.FieldByName('Desc_Inv').AsFloat := iTmp1;
  oTable.FieldByName('Carga_Inv').AsFloat := oQry_Cmd.FieldByName('UnidCargo')
    .AsFloat * iTmp1;
  oTable.FieldByName('nivel').AsInteger := pIndex;
  oTable.Post;
  pTotCarg := pTotCarg + oTable.FieldByName('Carga_Inv').AsFloat;
  pTotDesc := pTotDesc + oTable.FieldByName('Desc_Inv').AsFloat;
  pFx1 := oTable.FieldByName('Desc_Inv').AsFloat;

  if not Utiles.isEmpty(oQry_Cmd.FieldByName('CodigoS').AsString) then
  begin
    if pIndex = 1 then
      nExistAc1 := (pFactC * oQry_Cmd.FieldByName('Exist_P').AsFloat)
    else
      nExistAc1 := 0;
    pFactC := (pFactC * oQry_Cmd.FieldByName('UnidCargo').AsInteger);
    nExistAc2 := nExistAc1 + (pFactC * oQry_Cmd.FieldByName('Exist_P').AsFloat);
    if (pUnid_Ped > nExistAc1) then
    begin
      if pUnid_Ped > nExistAc2 then
        pPrCodigo := oQry_Cmd.FieldByName('CodigoS').AsString
      else
        pPrCodigo := '';
    end
    else
      pPrCodigo := '';
    pUnid_Dev := pUnid_Dev + nExistAc2;
  end
  else
    pPrCodigo := '';
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

function DateTimeAdd(SrcDate: TDateTime; DatePart: TDateTimePart;
  DiffValue: integer): TDateTime;
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

function IsWinNT: Boolean;
var
  OSV: OSVERSIONINFO;
begin
  OSV.dwOSVersionInfoSize := SizeOf(OSV);
  GetVersionEx(OSV);
  Result := OSV.dwPlatformId = VER_PLATFORM_WIN32_NT;
end;

function EjecutarComando(comando: string): string;
var
  Buffer: array [0 .. 4096] of Char;
  si: StartupInfo;
  sa: SECURITY_ATTRIBUTES;
  sd: SECURITY_DESCRIPTOR;
  pi: PROCESS_INFORMATION;
  newstdin, newstdout, read_stdout, write_stdin: THandle;
  exitcod, bread, avail: Cardinal;
  sSym: string;
begin

  Application.CreateForm(TTSplashForm, tSplashForm);
  tSplashForm.ProgressBar1.Visible := False;
  tSplashForm.ProgressBar1.Min := 0;
  tSplashForm.ProgressBar1.Max := 0;
  tSplashForm.olMensage.Visible := False;
  sSym := '/';
  Result := '';
  if IsWinNT then
  begin
    InitializeSecurityDescriptor(@sd, SECURITY_DESCRIPTOR_REVISION);
    SetSecurityDescriptorDacl(@sd, True, nil, False);
    sa.lpSecurityDescriptor := @sd;
  end
  else
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
      if CreateProcess(nil, @Buffer, nil, nil, True, CREATE_NEW_CONSOLE, nil,
        nil, si, pi) then
      begin
        tSplashForm.Show;
        tSplashForm.olMensage.Visible := True;
        repeat
          PeekNamedPipe(read_stdout, @Buffer, SizeOf(Buffer) - 1, @bread,
            @avail, nil);
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
          tSplashForm.olMensage.Caption := sSym +
            'Espere un momento por favor, mientras se ejecuta el comando:..';
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

function buscarTexto(textoBuscar: string; textoCompleto: string): Boolean;
var
  posicion: integer;
begin
  Result := False;
  posicion := Pos(AnsiUpperCase(textoBuscar), AnsiUpperCase(textoCompleto));
  if (posicion <> 0) then
  begin
    if (Length(textoCompleto) >= posicion + 1) then
    begin
      if (textoCompleto[posicion + Length(textoBuscar)] = ' ') then
        Result := True
      else
        Result := False;
    end
    else
      Result := False;
  end;
end;

function InstallINF(const PathName: string; hParent: HWND): Boolean;
var
  instance: HINST;
begin { InstallINF }
  instance := ShellExecute(hParent, PChar('open'), PChar('rundll32.exe'),
    PChar('setupapi,InstallHinfSection DefaultInstall 132 ' + PathName),
    nil, SW_HIDE);

  Result := instance > 32
end; { InstallINF }

{ -----------------------------Working S.O. enviroment variables-----------------------------------
  Este juego de funciones se utiliza para leer y escribir las variables de usuario o de seystema
  del sistema operativo, estas variables son las que ves cuando escrives en la la caja de comandos
  del DOS "path" y te devuelve las variables del sistemas con sus respectivos valores actuales.
  Este juego de funciones se utilisa para añadir o alterar esos valores.
  -------------------------------------------------------------------------------------------------- }

function GetUserEnvironmentVariable(const name: string): string;
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

procedure SetUserEnvironmentVariable(const name, Value: string);
var
  rv: DWORD;
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('Environment', False);
      writeString(name, Value);
      SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, 0,
        LParam(PChar('Environment')), SMTO_ABORTIFHUNG, 5000, rv);
    finally
      Free
    end
end;

{
  The next two procedures read and write environment variables for the
  system and thus affect all users.
}

function GetSystemEnvironmentVariable(const name: string): string;
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('SYSTEM\CurrentControlSet\Control\Session ' +
        'Manager\Environment', False);
      Result := ReadString(name);
    finally
      Free
    end
end;

// Modified from
// http://www.delphiabc.com/TipNo.asp?ID=117
// The original article did not include the space in
// "Session Manager" which caused the procedure to fail.

procedure SetSystemEnvironmentVariable(const name, Value: string);
var
  rv: DWORD;
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('SYSTEM\CurrentControlSet\Control\Session ' +
        'Manager\Environment', False);
      writeString(name, Value);
      SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, 0,
        LParam(PChar('Environment')), SMTO_ABORTIFHUNG, 5000, rv);
    finally
      Free
    end
end;

{ ********************************************* }
{ Set Global Environment Function }
{ Coder : Kingron,2002.8.6 }
{ Bug Report : Kingron@163.net }
{ Test OK For Windows 2000 Advance Server }
{ Parameter: }
{ Name : environment variable name }
{ Value: environment variable Value }
{ Ex: SetGlobalEnvironment('MyVar','OK') }
{ ********************************************* }

function SetGlobalEnvironment(const name, Value: string;

  const User: Boolean = True): Boolean;
resourcestring
  REG_MACHINE_LOCATION =
    'System\CurrentControlSet\Control\Session Manager\Environment';
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
        SendMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0,
          integer(PChar('Environment')));
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

function IsAdmin: Boolean;
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
  bSuccess := OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True,
    hAccessToken);
  if not bSuccess then
    if GetLastError = ERROR_NO_TOKEN then
      bSuccess := OpenProcessToken(GetCurrentProcess, TOKEN_QUERY,
        hAccessToken);
  if bSuccess then
  begin
    GetTokenInformation(hAccessToken, TokenGroups, nil, 0, dwInfoBufferSize);
    ptgGroups := GetMemory(dwInfoBufferSize);
    bSuccess := GetTokenInformation(hAccessToken, TokenGroups, ptgGroups,
      dwInfoBufferSize, dwInfoBufferSize);
    CloseHandle(hAccessToken);
    if bSuccess then
    begin
      AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
        SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0,
        psidAdministrators);
{$R-}
      for X := 0 to ptgGroups.GroupCount - 1 do
      begin
        if (SE_GROUP_ENABLED = (ptgGroups.Groups[X].Attributes and
          SE_GROUP_ENABLED)) and EqualSid(psidAdministrators,
          ptgGroups.Groups[X].Sid) then
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

function Set_Tmp_Database(): Boolean;
begin
  Result := Utiles.Execute_SQL_Command('CREATE DATABASE IF NOT EXISTS `' +
    trim(cTMP_Database) +
    '` /*!40100 CHARACTER SET utf8 COLLATE utf8_general_ci */;');
end;

{ -----------------------------------------------------------------------------------------------
  Esta función permite borrar o limpiar las tablas de una bases de datos dependiendo el comodin
  que se especifique en cPattern, lo hace para la bases de dato en curso, o se puede especificar
  otra base de datos.
  implementación:
  call drop_tables_like (0,'ika%');  /* para borra todas las tablas que inicien con ika
  call drop_tables_like (0,'ika%','TMP');  /* para borra todas las tablas que inicien con ika
  en la base de datos TMP
  opciones
  0: eliminar contenido
  1: eliminar tablas
  ------------------------------------------------------------------------------------------------ }

function Opt_Database(iOpt: integer = 0; cPattern: string = '%';
  cDBName: string = ''): Boolean;
begin
  Result := False;
  case iOpt of
    0:
      begin
        Result := Utiles.Execute_SQL_Command('CALL trunc_tables_like("' +
          cDBName + '","' + cPattern + '") ');
      end;
    1:
      begin
        Result := Utiles.Execute_SQL_Command('CALL drop_tables_like("' + cDBName
          + '","' + cPattern + '") ');
      end;
    2:
      begin
        Result := Utiles.Execute_SQL_Command('CALL del_tables_like("' + cDBName
          + '","' + cPattern + '") ');
      end;
  end;
end;

{ -----------------------------------------------------------------------------------------------
  Esta función el mandas el archivo y escribe la vesión de FACIL en él.
  ------------------------------------------------------------------------------------------------ }

procedure TxtFile_Write_version(FileName: string; cFull_AppName: string);
begin
end;

{ -----------------------------------------------------------------------------------------------
  Esta función determina si una cadena contiene sólo números
  ------------------------------------------------------------------------------------------------ }

function IsStrANumber(const S: string): Boolean;
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

{ -----------------------------------------------------------------------------------------------
  Esta función esta diseñada especificamente para trabajar con el objeto DBGridEh, si tu formulario
  contiene un objeto DBGridEh y quieres que el mismos tenga la opcion de rezice y tienes instalado
  el vcl ResizeKit2 entonces.
  colacas el objeto  ResizeKit en el formulario sino lo tienes, en el evento ResizeKit1ExitResize
  colocas la siguiente orden "utiles.ResizeKit_DBGridEh(self.DBGridEh1, XScale, YScale);"
  y además debes solocar    "utiles.ResizeKit_DBGridEh_Prepare(self.DBGridEh1);" en el create
  y listo. Ya tugrid cuenta con rezise
  ResizeKit_DBGridEh_Prepare en el create recuarda los valores iniciales con los cuales se creo el
  formulario para luego ResizeKit_DBGridEh hace el trabajo de redimension del grid.
  todos los demás objetos los redimensiona el VCL por si solo.
  ------------------------------------------------------------------------------------------------ }
{
  Procedure ResizeKit_DBGridEh_Prepare(oDBGridEh: TDBGridEh); overload;
  var
  i: integer;
  begin
  npMAXCOL_DG := oDBGridEh.Columns.Count;
  npMAXROW_DG := oDBGridEh.RowCount;
  for i := 0 to npMAXCOL_DG - 1 do
  npOrg_Width_DG[i] := oDBGridEh.Columns[i].Width;
  end;

  Procedure ResizeKit_DBGridEh(oDBGridEh: TDBGridEh; pXScale: double; pYScale: double); overload;
  var
  i: integer;
  begin
  for i := 0 to oDBGridEh.Columns.Count - 1 do
  oDBGridEh.Columns[i].Width := Round(npOrg_Width_DG[i] * pXScale);

  //oDBGridEh.RowHeight := Round(npOrg_Height_DG * pYScale);
  end;
  {------------------------------------------------------------------------------------------------ }

function strTran(cText, cfor, cwith: string): string;
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

function between(nval, nmin, nmax: Longint): Boolean;
begin
  Result := False;
  if (nval >= nmin) and (nval <= nmax) then
    Result := True;
end;

procedure DeleteArrayItem(var X: TStringArray;

  const Index: integer);
begin
  if Index > High(X) then
    exit;
  if Index < Low(X) then
    exit;
  if Index = High(X) then
  begin
    SetLength(X, Length(X) - 1);
    exit;
  end;
  Finalize(X[Index]);
  System.Move(X[Index + 1], X[Index], (Length(X) - Index - 1) *
    SizeOf(string) + 1);
  SetLength(X, Length(X) - 1);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion hace una búsqueda binaria en un array.
  ------------------------------------------------------------------------------------------------ }

function BinSearchArray(Strings: TStringArray; SubStr: string): integer;
var
  First: integer;
  Last: integer;
  Pivot: integer;
  Found: Boolean;
begin
  First := Low(Strings);
  // Sets the first item of the range
  Last := High(Strings); // Sets the last item of the range
  Found := False; // Initializes the Found flag (Not found yet)
  Result := -1; // Initializes the Result
  Pivot := 0;
  while (First <= Last) and (not Found) do
  begin
    if Strings[Pivot] = SubStr then
    begin
      Found := True;
      Result := Pivot;
      exit;
    end
    else
    begin
      Pivot := Pivot + 1;
      First := Pivot;
    end;
  end;
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion ordena un array.
  ------------------------------------------------------------------------------------------------ }

procedure QuickSortArray(var Strings: TStringArray; Start, Stop: integer);
var
  Left: integer;
  Right: integer;
  Mid: integer;
  Pivot: string;
  Temp: string;
begin
  Left := Start;
  Right := Stop;
  Mid := (Start + Stop) div 2;

  Pivot := Strings[Mid];
  repeat
    while Strings[Left] < Pivot do
      inc(Left);
    while Pivot < Strings[Right] do
      Dec(Right);
    if Left <= Right then
    begin
      Temp := Strings[Left];
      Strings[Left] := Strings[Right]; // Swops the two Strings
      Strings[Right] := Temp;
      inc(Left);
      Dec(Right);
    end;
  until Left > Right;

  if Start < Right then
  begin
    QuickSortArray(Strings, Start, Right); // Uses
  end;
  if Left < Stop then
  begin
    QuickSortArray(Strings, Left, Stop); // Recursion
  end;
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion busca un elemento contenido dentro de un array.
  ------------------------------------------------------------------------------------------------ }

function SearchInArray(PNames: TStringArray; PName: string): integer;
var
  i: integer;
begin
  for i := 0 to high(PNames) do
    if Pos(PName, PNames[i]) > -1 then
      Result := i;
end;

function ClearArray(var PNames: TStringArray): integer;
var
  i: integer;
begin
  for i := 0 to high(PNames) do
    PNames[i] := '';
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion convierte de segundos a horas en formato 'hh:mm:ss'.
  ------------------------------------------------------------------------------------------------ }

function SecToTime(Sec: integer): string;
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

function TimeADD(cTime: string; nInterval: integer; nValue: integer)
  : string; overload;
var
  oQry_Gen: Tzquery;
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
  cSql_Line := 'SELECT DATE_FORMAT(DATE_ADD("2000-01-01 ' + cTime +
    '",INTERVAL ' + IntToStr(nValue) + ' ' + cInterval + '),"%T") AS xTime ';
  Utiles.Utiles.Exec_Select_SQL(oQry_Gen, cSql_Line, True, True);
  Result := oQry_Gen.FieldByName('xTime').AsString;
  freeandnil(oQry_Gen);
end;

function TimeADD(TDateTime: TDateTime; nInterval: integer; nValue: integer)
  : string; overload;
var
  oQry_Gen: Tzquery;
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
  cSql_Line := 'SELECT DATE_FORMAT(DATE_ADD("' + cDateTime + '",INTERVAL ' +
    IntToStr(nValue) + ' ' + cInterval + '),"%T") AS xTime ';
  if Utiles.Utiles.Exec_Select_SQL(oQry_Gen, cSql_Line, True, True) = True then
    Result := oQry_Gen.FieldByName('xTime').AsString;
  freeandnil(oQry_Gen);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion le entregas la hora inicial y final en formato 'hh:mm:ss' y te devuelve la diferencia en
  el mismo formato.
  ------------------------------------------------------------------------------------------------ }

function TimeDiff(cTime_Ult: string; cTime_Ant: string): string;
var
  oQry_Gen: Tzquery;
  cSql_Line: string;
begin
  cSql_Line := 'SELECT TIMEDIFF(IFNULL("' + cTime_Ult + '","01:00:00"),IFNULL("'
    + cTime_Ant + '","00:00:00")) as xTime ';
  Utiles.Utiles.Exec_Select_SQL(oQry_Gen, cSql_Line, True, True);
  Result := oQry_Gen.FieldByName('xTime').AsString;
  freeandnil(oQry_Gen);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion le entregas una cadena 'hh:mm:ss' y te devuelve el equivalente en segundos.
  ------------------------------------------------------------------------------------------------ }

function TimeToSecs(cTime: string): integer;
var
  oQry_Gen: Tzquery;
  cSql_Line: string;
begin
  cSql_Line := 'SELECT TIME_TO_SEC("' + cTime + '") as xTime ';
  Utiles.Utiles.Exec_Select_SQL(oQry_Gen, cSql_Line, True, True);
  Result := oQry_Gen.FieldByName('xTime').AsInteger;
  freeandnil(oQry_Gen);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion le entregas los segundos y te los devuelve en formato 'hh:mm:ss'
  ------------------------------------------------------------------------------------------------ }

function SecsToTime(nSeconds: integer): string;
var
  oQry_Gen: Tzquery;
  cSql_Line: string;
begin
  cSql_Line := 'SELECT SEC_TO_TIME("' + IntToStr(nSeconds) + '") as xTime ';
  Utiles.Utiles.Exec_Select_SQL(oQry_Gen, cSql_Line, True, True);
  Result := oQry_Gen.FieldByName('xTime').AsString;
  freeandnil(oQry_Gen);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion calcula y actualiza los precios de ventas con impuestos.
  hasta ahora se toma en cuenta el ipuesto normal del sistema y el impuesto adicional.
  ------------------------------------------------------------------------------------------------ }

function Producto_Recalcula_PreciosVta_Con_Imp(pCodigo: string;
  pFull_TableName: string = 'productos_det'): Boolean;
var
  cSqlLn: string;
begin
  cSqlLn := '';
  cSqlLn := cSqlLn + 'UPDATE ' + pFull_TableName + ' SET ';
  cSqlLn := cSqlLn +
    'pr_precio1_imp = (ifnull(pr_venta1,0) + ifnull(pr_imp1,0) + ifnull(pr_imp1_adic,0)), ';
  cSqlLn := cSqlLn +
    'pr_precio2_imp = (ifnull(pr_venta2,0) + ifnull(pr_imp2,0) + ifnull(pr_imp2_adic,0)), ';
  cSqlLn := cSqlLn +
    'pr_precio3_imp = (ifnull(pr_venta3,0) + ifnull(pr_imp3,0) + ifnull(pr_imp3_adic,0)) ';
  if Utiles.isEmpty(pCodigo) = False then
    cSqlLn := cSqlLn + 'WHERE pr_id = "' + pCodigo + '"';
  Result := Utiles.Execute_SQL_Command(cSqlLn);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion calcula y actualiza los montos de la utilidad del producto basandose en lso margenes %
  que el producto tenga configurado.
  ------------------------------------------------------------------------------------------------ }

function Producto_Recalcula_Utilidad_Monto(pCodigo: string;
  pFull_TableName: string = 'productos_det'): Boolean;
var
  cSqlLn: string;
begin
  cSqlLn := '';
  cSqlLn := cSqlLn + 'UPDATE ' + pFull_TableName + ' SET ';
  cSqlLn := cSqlLn +
    'pr_util1 = ifnull(pr_venta1,0) * (ifnull(pr_margen1,0) / 100), ';
  cSqlLn := cSqlLn +
    'pr_util2 = ifnull(pr_venta2,0) * (ifnull(pr_margen2,0) / 100), ';
  cSqlLn := cSqlLn +
    'pr_util3 = ifnull(pr_venta3,0) * (ifnull(pr_margen3,0) / 100) ';
  if Utiles.isEmpty(pCodigo) = False then
    cSqlLn := cSqlLn + 'WHERE pr_id = "' + pCodigo + '"';
  Result := Utiles.Execute_SQL_Command(cSqlLn);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion calcula y actualiza los precios de ventas del producto basandose en el costo
  del producto y los margenes establecidos, si los margenes establecidos es 0 entonces el precio
  de venta sera el mismos del costo.
  ------------------------------------------------------------------------------------------------ }

function Producto_Recalcula_PreciosVta_Con_Costos(pCodigo: string;
  pFull_TableName: string = 'productos_det'): Boolean;
var
  cSqlLn: string;
  Result1, Result2: Boolean;
begin
  cSqlLn := '';
  cSqlLn := cSqlLn + 'UPDATE ' + pFull_TableName + ' SET ';
  cSqlLn := cSqlLn + 'pr_margen1 = 99.99 ';
  cSqlLn := cSqlLn + 'WHERE (pr_costo_prom>0) and (pr_margen1 = 100) ';
  if Utiles.isEmpty(pCodigo) = False then
    cSqlLn := cSqlLn + 'AND (pr_id = "' + pCodigo + '") ';
  Result1 := Utiles.Execute_SQL_Command(cSqlLn);

  cSqlLn := '';
  cSqlLn := cSqlLn + 'UPDATE ' + pFull_TableName + ' SET ';
  cSqlLn := cSqlLn +
    'pr_venta1 = ifnull(pr_costo_prom,0) / ((100 - ifnull(pr_margen1,0)) / 100), ';
  cSqlLn := cSqlLn +
    'pr_venta2 = ifnull(pr_costo_prom,0) / ((100 - ifnull(pr_margen2,0)) / 100), ';
  cSqlLn := cSqlLn +
    'pr_venta3 = ifnull(pr_costo_prom,0) / ((100 - ifnull(pr_margen3,0)) / 100)  ';
  cSqlLn := cSqlLn + 'WHERE (pr_costo_prom <> 0) ';
  if Utiles.isEmpty(pCodigo) = False then
    cSqlLn := cSqlLn + 'AND (pr_id = "' + pCodigo + '") ';
  Result2 := Utiles.Execute_SQL_Command(cSqlLn);
  Result := (Result1 and Result2);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion calcula y actualiza los margenes % de ganacia a partir del costo y el precio de venta
  ------------------------------------------------------------------------------------------------ }

function Producto_Recalcula_Margenes(pCodigo: string;
  pFull_TableName: string = 'productos_det'): Boolean;
var
  cSqlLn: string;
begin
  cSqlLn := '';
  cSqlLn := cSqlLn + 'UPDATE ' + pFull_TableName + ' SET ';
  cSqlLn := cSqlLn +
    'pr_margen1 = CASE WHEN pr_venta1<>0 THEN (((ifnull(pr_venta1,0) - ifnull(pr_costo_prom,0)) / ifnull(pr_venta1,0))) * 100 ELSE 0 END, ';
  cSqlLn := cSqlLn +
    'pr_margen2 = CASE WHEN pr_venta2<>0 THEN (((ifnull(pr_venta2,0) - ifnull(pr_costo_prom,0)) / ifnull(pr_venta2,0))) * 100 ELSE 0 END, ';
  cSqlLn := cSqlLn +
    'pr_margen3 = CASE WHEN pr_venta3<>0 THEN (((ifnull(pr_venta3,0) - ifnull(pr_costo_prom,0)) / ifnull(pr_venta3,0))) * 100 ELSE 0 END ';
  cSqlLn := cSqlLn + 'WHERE (pr_venta1 <> 0) ';
  if Utiles.isEmpty(pCodigo) = False then
    cSqlLn := cSqlLn + 'AND (pr_id = "' + pCodigo + '") ';
  Result := Utiles.Execute_SQL_Command(cSqlLn);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion calcula y actualiza el monto del impuesto a partir del precio de venta gravado
  ------------------------------------------------------------------------------------------------ }

function Producto_Recalcula_Montos_Imp(pCodigo: string;
  pFull_TableName: string = 'productos_det'): Boolean;
var
  cSqlLn: string;
begin
  cSqlLn := '';
  cSqlLn := cSqlLn + 'UPDATE ' + pFull_TableName + ' SET ';
  cSqlLn := cSqlLn +
    'pr_imp1 =  IF(ifnull(pr_itbms,0) = 0,0,(ifnull(pr_venta1,0) * ifnull(pr_itbms,0) / 100)), ';
  cSqlLn := cSqlLn +
    'pr_imp2 =  IF(ifnull(pr_itbms,0) = 0,0,(ifnull(pr_venta2,0) * ifnull(pr_itbms,0) / 100)), ';
  cSqlLn := cSqlLn +
    'pr_imp3 =  IF(ifnull(pr_itbms,0) = 0,0,(ifnull(pr_venta3,0) * ifnull(pr_itbms,0) / 100)),  ';
  cSqlLn := cSqlLn +
    'pr_imp1_adic =  IF(ifnull(pr_imp_adic,0) = 0,0,(ifnull(pr_venta1,0) * ifnull(pr_imp_adic,0) / 100)), ';
  cSqlLn := cSqlLn +
    'pr_imp2_adic =  IF(ifnull(pr_imp_adic,0) = 0,0,(ifnull(pr_venta2,0) * ifnull(pr_imp_adic,0) / 100)), ';
  cSqlLn := cSqlLn +
    'pr_imp3_adic =  IF(ifnull(pr_imp_adic,0) = 0,0,(ifnull(pr_venta3,0) * ifnull(pr_imp_adic,0) / 100))  ';
  if Utiles.isEmpty(pCodigo) = False then
    cSqlLn := cSqlLn + 'WHERE pr_id = "' + pCodigo + '"';
  Result := Utiles.Execute_SQL_Command(cSqlLn);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion toma el precio con impuesto de un producto determinado y recalcula/actualiza
  el valor del precio sin impuesto para el producto determinado.
  ------------------------------------------------------------------------------------------------ }

function Producto_Recalcula_PreciosVta_Con_PreciosVtaImp(pCodigo: string;
  pFull_TableName: string = 'productos_det'): Boolean;
var
  cSqlLn: string;
begin
  cSqlLn := '';
  cSqlLn := cSqlLn + 'UPDATE ' + pFull_TableName + ' SET ';
  cSqlLn := cSqlLn +
    'pr_venta1 = IF((ifnull(pr_itbms,0)+ifnull(pr_imp_adic,0))=0,ifnull(pr_precio1_imp,0),(ifnull(pr_precio1_imp,0) / (1+((ifnull(pr_itbms,0)+ifnull(pr_imp_adic,0)) / 100)))), ';
  cSqlLn := cSqlLn +
    'pr_venta2 = IF((ifnull(pr_itbms,0)+ifnull(pr_imp_adic,0))=0,ifnull(pr_precio2_imp,0),(ifnull(pr_precio2_imp,0) / (1+((ifnull(pr_itbms,0)+ifnull(pr_imp_adic,0)) / 100)))), ';
  cSqlLn := cSqlLn +
    'pr_venta3 = IF((ifnull(pr_itbms,0)+ifnull(pr_imp_adic,0))=0,ifnull(pr_precio3_imp,0),(ifnull(pr_precio3_imp,0) / (1+((ifnull(pr_itbms,0)+ifnull(pr_imp_adic,0)) / 100))))  ';
  if Utiles.isEmpty(pCodigo) = False then
    cSqlLn := cSqlLn + 'WHERE pr_id = "' + pCodigo + '"';
  Result := Utiles.Execute_SQL_Command(cSqlLn);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion busca el número de estación predeterminada en el el sistema y la devuelve
  también automáticamente carga la variable de estación del sistema.
  ------------------------------------------------------------------------------------------------ }

function Get_Station_id: string;
var
  oTab_Sqll: Tztable;
  cOp_est: string;
begin
  if bId_Estacion_Force = True then
    exit;
  if isEmpty(cId_Estacion) = False then
  begin
    Result := cId_Estacion;
    exit;
  end;
  oTab_Sqll := Tztable.Create(nil);
  Utiles.OpenSqlLite();
  oTab_Sqll.Connection := Utiles.oPublicCnnSQLL;
  oTab_Sqll.TableName := 'local_conf';
  oTab_Sqll.Active := True;
  oTab_Sqll.First;
  cOp_est := oTab_Sqll.FieldByName('estacion').AsString;
  oTab_Sqll.Close;
  freeandnil(oTab_Sqll);
  cId_Estacion := cOp_est;
  Result := cOp_est;
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion muestra y actualiza el número de único de secuencia de una operación.
  ------------------------------------------------------------------------------------------------ }

function Operacion_Get_And_Update_Opid: string;
var
  oQry_Sec_CD: Tzquery;
  cOp_idC: string;
  cOp_est: string;
  cSqlLine: string;
begin
  Get_Station_id();
  cOp_est := Utiles.cId_Estacion;
  if Utiles.Exec_Select_SQL(oQry_Sec_CD,
    'SELECT suc_Id,no_estacion,no_operacion FROM  conf_sistema WHERE suc_Id= "'
    + IntToStr(Utiles.iId_Empresa) + '" AND no_estacion= "' +
    Utiles.cId_Estacion + '" ;', True, True) = True then
  begin
    cOp_idC := trim(IntToStr(Utiles.iId_Empresa)) + trim(cOp_est) +
      trim(IntToStr(oQry_Sec_CD.FieldByName('no_operacion').AsInteger + 1));
    oQry_Sec_CD.Close;
    freeandnil(oQry_Sec_CD);
    Result := cOp_idC;
  end
  else
  begin
    Get_Station_id();
    cSqlLine := '';
    cSqlLine := cSqlLine +
      'INSERT INTO conf_sistema (suc_Id,no_estacion,no_operacion) VALUES ';
    cSqlLine := cSqlLine + '("' + IntToStr(iId_Empresa) + '","' +
      Utiles.cId_Estacion + '",0)';
    Utiles.Execute_SQL_Command(cSqlLine);
    cOp_idC := trim(IntToStr(Utiles.iId_Empresa)) + trim(cOp_est) + '1';
    Result := cOp_idC;
  end;
  Utiles.Execute_SQL_Command
    ('UPDATE conf_sistema SET no_operacion = no_operacion + 1 WHERE suc_Id= "' +
    IntToStr(Utiles.iId_Empresa) + '" AND no_estacion= "' +
    Utiles.cId_Estacion + '" ;');

end;

function Operacion_Get_And_Update_CargosId(nOption: integer;
  bAutoSave: Boolean = True): string;
var
  oQry_Sec_CD: Tzquery;
  nOp_Corre: integer;
  cOp_est: string;
  cSqlLine: string;
begin
  Get_Station_id();
  cOp_est := Utiles.cId_Estacion;
  if bAutoSave = True then
  begin
    case nOption of
      1:
        Utiles.Execute_SQL_Command
          ('UPDATE conf_sistema SET no_cargoinv     = no_cargoinv + 1     WHERE suc_Id= "'
          + IntToStr(Utiles.iId_Empresa) + '" AND no_estacion= "' +
          Utiles.cId_Estacion + '" ;');
      2:
        Utiles.Execute_SQL_Command
          ('UPDATE conf_sistema SET no_descargoinv  = no_descargoinv + 1  WHERE suc_Id= "'
          + IntToStr(Utiles.iId_Empresa) + '" AND no_estacion= "' +
          Utiles.cId_Estacion + '" ;');
      3:
        Utiles.Execute_SQL_Command
          ('UPDATE conf_sistema SET no_ordenprod    = no_ordenprod + 1    WHERE suc_Id= "'
          + IntToStr(Utiles.iId_Empresa) + '" AND no_estacion= "' +
          Utiles.cId_Estacion + '" ;');
      4:
        Utiles.Execute_SQL_Command
          ('UPDATE conf_sistema SET no_cargoprod    = no_cargoprod + 1    WHERE suc_Id= "'
          + IntToStr(Utiles.iId_Empresa) + '" AND no_estacion= "' +
          Utiles.cId_Estacion + '" ;');
      5:
        Utiles.Execute_SQL_Command
          ('UPDATE conf_sistema SET no_descargoprod = no_descargoprod + 1 WHERE suc_Id= "'
          + IntToStr(Utiles.iId_Empresa) + '" AND no_estacion= "' +
          Utiles.cId_Estacion + '" ;');
      6:
        Utiles.Execute_SQL_Command
          ('UPDATE conf_sistema SET no_tomainv      = no_tomainv + 1      WHERE suc_Id= "'
          + IntToStr(Utiles.iId_Empresa) + '" AND no_estacion= "' +
          Utiles.cId_Estacion + '" ;');
    end;
    if Utiles.Exec_Select_SQL(oQry_Sec_CD,
      'SELECT * FROM  conf_sistema WHERE suc_Id= "' +
      IntToStr(Utiles.iId_Empresa) + '" AND no_estacion= "' +
      Utiles.cId_Estacion + '" ;', True, True) = True then
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
    if Utiles.Exec_Select_SQL(oQry_Sec_CD,
      'SELECT * FROM  conf_sistema WHERE suc_Id= "' +
      IntToStr(Utiles.iId_Empresa) + '" AND no_estacion= "' +
      Utiles.cId_Estacion + '" ;', True, True) = True then
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
      cSqlLine := cSqlLine +
        'INSERT INTO conf_sistema (suc_Id,no_estacion) VALUES ';
      cSqlLine := cSqlLine + '("' + IntToStr(iId_Empresa) + '","' +
        cId_Estacion + '")';
      Utiles.Execute_SQL_Command(cSqlLine);
      nOp_Corre := 1;
    end;
  end;
  Result := IntToStr(nOp_Corre);
  freeandnil(oQry_Sec_CD);
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion toma un producto de dempaque y arma su arbos con los item subordinados a el,
  presenta los productos hijos por decirlos e informacion de costos, ventas y otros detalles.
  ------------------------------------------------------------------------------------------------ }

function Actualiza_Exist_Deps(tipo_op: string): Boolean;
var
  sqlstr, sqlstr2, dep: string;
  sql_dep: Tzquery;
  op_tipo: integer;
begin
end;

{ -----------------------------------------------------------------------------------------------
  Esta funcion toma un producto de dempaque y arma su arbos con los item subordinados a el,
  presenta los productos hijos por decirlos e informacion de costos, ventas y otros detalles.
  ------------------------------------------------------------------------------------------------ }

function Muestra_Producto_Presentaciones(var oVTable: TVirtualTable;
  pCodigo: string; nPrtecio: integer): Boolean;
var
  nIndex: integer;
  oQry: Tzquery;
  cCod_Lnk: string;
  cSqlLine: string;
  nCnt: integer;
begin
  oVTable := TVirtualTable.Create(nil);
  with oVTable do
  begin
    Active := False;
    FieldDefs.Add('pr_id', ftString, 20);
    FieldDefs.Add('pr_descripcion', ftString, 80);
    FieldDefs.Add('pr_tipo', ftInteger, 0);
    FieldDefs.Add('pr_costo', ftfloat, 0);
    FieldDefs.Add('pr_venta', ftfloat, 0);
    FieldDefs.Add('CodigoS', ftString, 20);
    Active := True;
    Clear
  end;

  cSqlLine := 'SELECT ';
  cSqlLine := cSqlLine +
    'productos.pr_id          , productos.pr_descripcion ,productos.pr_id_enlace , ';
  cSqlLine := cSqlLine +
    'productos.pr_exist_cargar, productos_det.pr_costo   ,productos_det.pr_venta1, ';
  cSqlLine := cSqlLine + 'productos_det.pr_venta2  , productos_det.pr_venta3  ';
  cSqlLine := cSqlLine + 'FROM productos ';
  cSqlLine := cSqlLine +
    'LEFT OUTER JOIN productos_det ON (productos.pr_Id = productos_det.pr_Id) ';
  cSqlLine := cSqlLine + 'WHERE productos.pr_id="' + pCodigo + '" ';
  if Utiles.Exec_Select_SQL(oQry, cSqlLine, True, True) = True then
  begin
    oVTable.Insert;
    oVTable.FieldByName('pr_id').AsString := oQry.FieldByName('pr_id').AsString;
    oVTable.FieldByName('pr_descripcion').AsString :=
      oQry.FieldByName('pr_descripcion').AsString;
    oVTable.FieldByName('pr_costo').AsFloat :=
      oQry.FieldByName('pr_costo').AsFloat;
    case nPrtecio of
      1:
        oVTable.FieldByName('pr_venta').AsFloat :=
          oQry.FieldByName('pr_venta1').AsFloat;
      2:
        oVTable.FieldByName('pr_venta').AsFloat :=
          oQry.FieldByName('pr_venta2').AsFloat;
      3:
        oVTable.FieldByName('pr_venta').AsFloat :=
          oQry.FieldByName('pr_venta3').AsFloat;
    end;
    oVTable.FieldByName('CodigoS').AsString :=
      oQry.FieldByName('pr_id_enlace').AsString;
    oVTable.Post;
    cCod_Lnk := oQry.FieldByName('pr_id').AsString;
    oQry.Close;
    freeandnil(oQry);
  end;

  cCod_Lnk := pCodigo;
  for nIndex := 1 to 5 do
  begin
    cSqlLine := 'SELECT ';
    cSqlLine := cSqlLine +
      'productos.pr_id          , productos.pr_descripcion ,productos.pr_id_enlace , ';
    cSqlLine := cSqlLine +
      'productos.pr_exist_cargar, productos_det.pr_costo   ,productos_det.pr_venta1, ';
    cSqlLine := cSqlLine +
      'productos_det.pr_venta2  , productos_det.pr_venta3  ';
    cSqlLine := cSqlLine + 'FROM productos ';
    cSqlLine := cSqlLine +
      'LEFT OUTER JOIN productos_det ON (productos.pr_Id = productos_det.pr_Id) ';
    cSqlLine := cSqlLine + 'WHERE productos.pr_id_enlace="' + cCod_Lnk + '" ';
    if Utiles.Exec_Select_SQL(oQry, cSqlLine, True, True) = True then
    begin
      oVTable.Insert;
      oVTable.FieldByName('pr_id').AsString :=
        oQry.FieldByName('pr_id').AsString;
      oVTable.FieldByName('pr_descripcion').AsString :=
        oQry.FieldByName('pr_descripcion').AsString;
      oVTable.FieldByName('pr_costo').AsFloat :=
        oQry.FieldByName('pr_costo').AsFloat;
      case nPrtecio of
        1:
          oVTable.FieldByName('pr_venta').AsFloat :=
            oQry.FieldByName('pr_venta1').AsFloat;
        2:
          oVTable.FieldByName('pr_venta').AsFloat :=
            oQry.FieldByName('pr_venta2').AsFloat;
        3:
          oVTable.FieldByName('pr_venta').AsFloat :=
            oQry.FieldByName('pr_venta3').AsFloat;
      end;
      oVTable.FieldByName('CodigoS').AsString :=
        oQry.FieldByName('pr_id_enlace').AsString;
      oVTable.Post;
      cCod_Lnk := oQry.FieldByName('pr_id').AsString;
      oQry.Close;
      freeandnil(oQry);
      inc(nCnt);
    end
  end;
  if nCnt > 0 then
    Result := True
  else
    Result := False;
end;

{ -------------------------------------------------------------------------------------------
  Esta función toma la configuración de la computadora y setea en el sistema las variables
  de separador de decimales y miles para a partir de ahi el sistema la tome y las uses.
  J.G.G. junio 2010.
  -------------------------------------------------------------------------------------------- }

procedure GetDefault_Decinal_Thousand_Separator;
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
  DecimalSeparator := tmp[1];
  cpDecimales := tmp[1];

  Thousand := StrAlloc(10);
  GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_STHOUSAND, Thousand, 10);
  tmp := Thousand;
  ThousandSeparator := tmp[1];
  cpThousand := tmp[1];
end;

{ -----------------------------------------------------------------------------------------------------
  El sistema contiene en una de sus tablas almacenada la notación de separador de miles y decimales
  esta información cuando el sistema inicia se carga en dos variables.
  en esta funcion se toma el valor de esas variables y se les asigna al la configuracion del software.
  J.G.G. junio 2010.
  ------------------------------------------------------------------------------------------------------ }

procedure Set_Decinal_Thousand_Separator;
begin
  DecimalSeparator := cpDecimales;
  ThousandSeparator := cpThousand;
end;

{ -------------------------------------------------------------------------------------------
  Esta función se aplica en tmp_producto_op o en producto_op, luego de haver procesado las
  ordenes normales sobre lso items se invoca esta función las busca en tre lso items del detalle
  todos los item que sean compuestos o combos y añaden al detalle todos estos items al detalle
  de la factura con atributos de oculto.
  J.G.G. junio 2010.
  -------------------------------------------------------------------------------------------- }

function Inserta_compuestos_poperacion(pPo_op_id: integer;
  bAllItems: Boolean = True; pMPr_id: string = ''): Boolean;
var
  cSqlLine: string;
  nCanTot: Single;
  oQry_PComp: Tzquery;
  oQry_PMast: Tzquery;
  sMPr_id: string;
  nPrecio: Single;
  nMontoI: Single;
  nItbm: Single;
  npr_util: Single;
begin
  try
    cSqlLine := '';
    cSqlLine := cSqlLine + 'SELECT * ';
    cSqlLine := cSqlLine + 'FROM   tmp_producto_op ';
    cSqlLine := cSqlLine + 'WHERE  po_op_id = "' + IntToStr(pPo_op_id) + '" ';
    if bAllItems = False then
      cSqlLine := cSqlLine + '       AND po_id_prod = "' + pMPr_id + '" ';
    cSqlLine := cSqlLine + 'ORDER  BY po_id_prod ';
    if Utiles.Exec_Select_SQL(oQry_PMast, cSqlLine, True, True) = False then
      exit;

    while not oQry_PMast.eof do
    begin
      sMPr_id := oQry_PMast.FieldByName('po_id_prod').AsString;
      cSqlLine := '';
      cSqlLine := cSqlLine + 'SELECT productos.pr_id, ';
      cSqlLine := cSqlLine + '       productos.pr_descripcion, ';
      cSqlLine := cSqlLine + '       productos.pr_detalle, ';
      cSqlLine := cSqlLine + '       productos_det.pr_itbms, ';
      cSqlLine := cSqlLine + '       productos.pr_tipo, ';
      cSqlLine := cSqlLine + '       productos_det.pr_costo_prom, ';
      cSqlLine := cSqlLine + '       compuestos.cant_equi, ';
      cSqlLine := cSqlLine + '       compuestos.comp_id ';
      cSqlLine := cSqlLine + 'FROM   productos ';
      cSqlLine := cSqlLine + '       INNER JOIN compuestos ';
      cSqlLine := cSqlLine + '         ON productos.pr_id = compuestos.pr_id ';
      cSqlLine := cSqlLine + '       INNER JOIN productos_det ';
      cSqlLine := cSqlLine +
        '         ON productos.pr_id = productos_det.pr_id ';
      cSqlLine := cSqlLine + 'WHERE  productos_det.suc_id = ' +
        IntToStr(Utiles.iId_Empresa) + ' ';
      cSqlLine := cSqlLine + '       AND compuestos.comp_id = "' +
        sMPr_id + '" ';
      cSqlLine := cSqlLine + 'ORDER  BY productos.pr_descripcion ASC ';
      if Utiles.Exec_Select_SQL(oQry_PComp, cSqlLine, True, True) = False then
      begin
        oQry_PMast.Next;
        continue;
        { Exit }
      end;

      while not oQry_PComp.eof do
      begin
        nCanTot := oQry_PMast.FieldByName('po_cant').AsFloat *
          oQry_PComp.FieldByName('cant_equi').AsFloat;
        nPrecio := oQry_PComp.FieldByName('pr_costo_prom').AsFloat /
          ((100 - oQry_PMast.FieldByName('po_utilidad_porc').AsFloat) / 100);
        nItbm := oQry_PComp.FieldByName('pr_itbms').AsFloat;
        nMontoI := Utiles.iif(nItbm = 0, 0, (nPrecio * nItbm / 100));
        npr_util := nPrecio * (oQry_PMast.FieldByName('po_utilidad_porc')
          .AsFloat / 100);

        cSqlLine := '';
        cSqlLine := cSqlLine + 'INSERT INTO tmp_producto_op (';
        cSqlLine := cSqlLine + 'po_op_id   , po_costo, ';
        cSqlLine := cSqlLine + 'po_utilidad_porc, po_itbms  ,po_id_prod, ';
        cSqlLine := cSqlLine + 'po_cant    , po_v_id   ,po_dep_id, ';
        cSqlLine := cSqlLine + 'po_pr_tipo , po_visible_grid  , po_signo, ';
        cSqlLine := cSqlLine + 'po_desc1   , po_desc2         , ubicacion, ';
        cSqlLine := cSqlLine + 'po_dep_id_tras , ubic_id      , ';
        cSqlLine := cSqlLine + 'po_pr_detalle  , po_comp_id   , suc_Id, ';
        cSqlLine := cSqlLine +
          'po_precio      , po_precioneto, po_montoimp,po_utilidad) VALUES (';
        cSqlLine := cSqlLine + '"' + IntToStr(pPo_op_id) + '",';
        cSqlLine := cSqlLine + '"' + oQry_PComp.FieldByName('pr_costo_prom')
          .AsString + '",';
        cSqlLine := cSqlLine + '"' + oQry_PMast.FieldByName('po_utilidad_porc')
          .AsString + '",';
        cSqlLine := cSqlLine + '"' + oQry_PMast.FieldByName('po_itbms')
          .AsString + '",';
        cSqlLine := cSqlLine + '"' + oQry_PComp.FieldByName('pr_id')
          .AsString + '",';
        cSqlLine := cSqlLine + '"' + FloatToStr2(nCanTot) + '",';
        cSqlLine := cSqlLine + '"' + oQry_PMast.FieldByName('po_v_id')
          .AsString + '",';
        cSqlLine := cSqlLine + '"' + oQry_PMast.FieldByName('po_dep_id')
          .AsString + '",';
        cSqlLine := cSqlLine + '"' + oQry_PComp.FieldByName('pr_tipo')
          .AsString + '",';
        cSqlLine := cSqlLine + '"N",';
        cSqlLine := cSqlLine + '"' + oQry_PMast.FieldByName('po_signo')
          .AsString + '",';
        cSqlLine := cSqlLine + '"0",';
        cSqlLine := cSqlLine + '"0",';
        cSqlLine := cSqlLine + '"' + oQry_PMast.FieldByName('ubicacion')
          .AsString + '",';
        cSqlLine := cSqlLine + '"' + oQry_PMast.FieldByName('po_dep_id_tras')
          .AsString + '",';
        cSqlLine := cSqlLine + '"' + oQry_PMast.FieldByName('ubic_id')
          .AsString + '",';
        cSqlLine := cSqlLine + '"' + oQry_PComp.FieldByName('pr_detalle')
          .AsString + '",';
        cSqlLine := cSqlLine + '"' + sMPr_id + '",';
        cSqlLine := cSqlLine + '"' + oQry_PMast.FieldByName('suc_Id')
          .AsString + '",';
        cSqlLine := cSqlLine + '"' + FloatToStr2(nPrecio) + '",';
        cSqlLine := cSqlLine + '"' + FloatToStr2(nPrecio) + '",';
        cSqlLine := cSqlLine + '"' + FloatToStr2(nMontoI) + '",';
        cSqlLine := cSqlLine + '"' + FloatToStr2(npr_util) + '") ';
        Utiles.Execute_SQL_Command(cSqlLine);
        oQry_PComp.Next;
      end;
      oQry_PMast.Next;
    end;
    freeandnil(oQry_PMast);
    freeandnil(oQry_PComp);
    Result := True;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
end;

{ ------------------------------------------------------------------------------------------------
  Este segmento de código localiza en el temporal de compras, todos los items que son tipo 3
  es decir Unicos y que posiblemente esten contenidos en un producto compuesto.
  Si consigue uno o dos o los que sea, el busca los demás compañeros en la tabla de compuestos
  y lista todos los productos  cmpuestos resultantes con el costo sumado correspondiente y
  actualiza el costo del producto principal.
  ------------------------------------------------------------------------------------------------- }

function Productos_Compuestos_Actualiza_Costos_Precios(pPo_op_id: integer;
  bAllItems: Boolean = True; pMPr_id: string = ''): Boolean;
var
  cSqlLine: string;
  oQry_PMast: Tzquery;
  sMPr_id: string;
  nMCosto: Single;
begin
  Result := False;
  try
    cSqlLine := '';
    cSqlLine := cSqlLine + 'SELECT c.comp_id, ';
    cSqlLine := cSqlLine +
      '       SUM(c.cant_equi * e.pr_costo_prom) AS costotot ';
    cSqlLine := cSqlLine + 'FROM   compuestos c ';
    cSqlLine := cSqlLine + '       INNER JOIN productos_det e ';
    cSqlLine := cSqlLine + '         ON c.pr_id = e.pr_id ';
    cSqlLine := cSqlLine + 'WHERE  c.comp_id IN (SELECT a.comp_id ';
    cSqlLine := cSqlLine + '                     FROM   compuestos a ';
    cSqlLine := cSqlLine +
      '                     WHERE  a.pr_id IN (SELECT b.po_id_prod ';
    cSqlLine := cSqlLine +
      '                                        FROM   producto_op b ';
    cSqlLine := cSqlLine +
      '                                        WHERE  b.po_op_id = "' +
      IntToStr(pPo_op_id) + '" ';
    if bAllItems = False then
      cSqlLine := cSqlLine +
        '                                            AND b.po_id_prod = "' +
        pMPr_id + '" ';
    cSqlLine := cSqlLine +
      '                                               AND b.po_pr_tipo IN ( "3", "0" ) ';
    cSqlLine := cSqlLine +
      '                                        ORDER  BY b.po_id_prod) ';
    cSqlLine := cSqlLine + '                     ORDER  BY a.comp_id ASC) ';
    cSqlLine := cSqlLine + 'GROUP  BY c.comp_id ';
    cSqlLine := cSqlLine + 'ORDER  BY c.comp_id ASC ';

    if Utiles.Exec_Select_SQL(oQry_PMast, cSqlLine, True, True) = False then
    begin
      Result := False;
      exit;
    end;
    while not oQry_PMast.eof do
    begin
      sMPr_id := oQry_PMast.FieldByName('comp_id').AsString;
      nMCosto := oQry_PMast.FieldByName('costoTot').AsFloat;
      if (nMCosto = 0) then
      begin
        oQry_PMast.Next;
        continue;
      end;
      cSqlLine := '';
      cSqlLine := cSqlLine + 'UPDATE productos_det SET ';
      cSqlLine := cSqlLine + 'pr_costo_prom = ' + FloatToStr2(nMCosto) + ' ';
      cSqlLine := cSqlLine + 'WHERE pr_id = ' + sMPr_id + ' ';
      cSqlLine := cSqlLine + '      AND   suc_Id = ' +
        IntToStr(Utiles.iId_Empresa) + ' ';

      Utiles.Execute_SQL_Command(cSqlLine);

      Utiles.Producto_Recalcula_PreciosVta_Con_PreciosVtaImp(sMPr_id);
      Utiles.Producto_Recalcula_Montos_Imp(sMPr_id);
      Utiles.Producto_Recalcula_Margenes(sMPr_id);
      Utiles.Producto_Recalcula_Utilidad_Monto(sMPr_id);

      oQry_PMast.Next;
      Result := True;

    end;
    freeandnil(oQry_PMast);
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
end;

{ -------------------------------------------------------------------------------------------
  Devido a que esta funciona manda error cuando la totacion de decimales es coma ",", hemos
  creado esta funcion que lo que hace es colocar en punto '.' la notacion de decimales, hacer
  la operación y luego lo vuelve a colocar como estab en el sistema anteriormente
  J.G.G. julio 2010.
  -------------------------------------------------------------------------------------------- }

function FloatToStr2(Value: extended): string;
begin
  DecimalSeparator := '.';
  Result := floattostr(Value);
  Set_Decinal_Thousand_Separator;
end;

function Calcular_Costo_Promedio(pr_id: string; cost_New: Single;
  exist_new: Single): Single;
var
  nCosto_Ant: Single;
  nExist_Ant: Single;
  cSqlLine: string;
  oQry_Prod: Tzquery;
begin
  Result := 0;
  cSqlLine := '';
  cSqlLine := cSqlLine + 'SELECT productos.pr_id, ';
  cSqlLine := cSqlLine + '       productos_det.pr_costo_prom   AS costo_ant, ';
  cSqlLine := cSqlLine + '       xprod_existencia.p_existencia AS exist_ant ';
  cSqlLine := cSqlLine + 'FROM   productos ';
  cSqlLine := cSqlLine + '       INNER JOIN productos_det ';
  cSqlLine := cSqlLine + '         ON productos.pr_id = productos_det.pr_id ';
  cSqlLine := cSqlLine + '       INNER JOIN xprod_existencia ';
  cSqlLine := cSqlLine +
    '         ON productos.pr_id = xprod_existencia.pr_id ';
  cSqlLine := cSqlLine + 'WHERE  productos_det.suc_id = ' +
    IntToStr(Utiles.iId_Empresa) + ' ';
  cSqlLine := cSqlLine + '       AND productos.pr_id = "' + trim(pr_id) + '" ';
  if Utiles.Exec_Select_SQL(oQry_Prod, cSqlLine, True, True) = False then
  begin
    nCosto_Ant := oQry_Prod.FieldByName('Costo_Ant').AsFloat;
    nExist_Ant := oQry_Prod.FieldByName('Exist_Ant').AsFloat;
    if nCosto_Ant = 0 then
    begin
      Result := cost_New;
      exit;
    end;
    try
      Result := ((nExist_Ant * nCosto_Ant) + (exist_new * cost_New)) /
        (nExist_Ant + exist_new);
    except
      Result := 0;
    end;
  end;
end;

{ -------------------------------------------------------------------------------------------
  Esta función busca el código de un producto 'pCod_Buscar', en la tabla de articulos dependiendo del parametro
  'bBusca_Enlace'; si es true busca en la columna 'pr_id_enlace' y si existe devuelve pr_id en 'pCod_Result',
  de los contrarios busca en la columna 'pr_id' y devuelve pr_id_enlace si existe en 'pCod_Result'.
  egeneralmente este tipo de búsquedas es secuencial sobre todo en productos desempaque de tal manera
  que no se crea 'oQry' dentro de la funcion para agilizar el proceso de busqueda/respuesta.
  J.G.G. julio 2010.
  -------------------------------------------------------------------------------------------- }

function Busca_Enlace_Desempaque(var oQry: Tzquery;

  var pCod_Buscar: string;

  var pCod_Result: string; bBusca_Enlace: Boolean = True): Boolean;
var
  cSqlLine: string;
  bCreate: Boolean;
begin
  if oQry <> nil then
    bCreate := False;

  cSqlLine := '';
  cSqlLine := cSqlLine + 'SELECT ';
  cSqlLine := cSqlLine + '       productos.pr_id,productos.pr_id_enlace ';
  cSqlLine := cSqlLine + 'FROM productos ';
  if bBusca_Enlace = True then
    cSqlLine := cSqlLine + 'WHERE productos.pr_id_enlace="' + pCod_Buscar + '" '
  else
    cSqlLine := cSqlLine + 'WHERE productos.pr_id="' + pCod_Buscar + '" ';
  if Utiles.Exec_Select_SQL(oQry, cSqlLine, True, bCreate) = True then
  begin
    if bBusca_Enlace = True then
      pCod_Result := oQry.FieldByName('pr_id').AsString
    else
      pCod_Result := oQry.FieldByName('pr_id_enlace').AsString;
    Result := True;
  end
  else
  begin
    pCod_Result := '';
    Result := False;
  end;
  oQry.Close;
end;

{ -------------------------------------------------------------------------------------------
  Esta función crea una ista tipo string de todos los miembros del cual se componen la cadena
  de desempaque incluyendo el articulo buscado.
  J.G.G. julio 2010.
  -------------------------------------------------------------------------------------------- }

function Listas_Familia_un_Desempaque(pCodigo: string): string;
var
  cResult: string;
  cLstRes: string;
  cCod_Tmp: string;
  nIndex: integer;
  oQry: Tzquery;
begin
  cResult := '';
  oQry := Tzquery.Create(nil);
  cLstRes := '';
  cCod_Tmp := pCodigo;
  cLstRes := cLstRes + '"' + cCod_Tmp + '", ';
  for nIndex := 1 to 6 do
  begin
    if Busca_Enlace_Desempaque(oQry, cCod_Tmp, cResult, True) = True then
    begin
      cCod_Tmp := cResult;
      cLstRes := cLstRes + '"' + cCod_Tmp + '", ';
    end
  end;
  cLstRes := cLstRes + '"<END>"';
  freeandnil(oQry);
  Result := cLstRes;
end;

{ -------------------------------------------------------------------------------------------
  Esta función se aplica en tmp_producto_op o en producto_op, luego de haver procesado las
  ordenes normales sobre lso utilems se invoca esta función las cual identifica cueles de los
  productos que estan en tmp_producto_op/producto_op son desempacadas por alguien más creando
  uan lista en la cual el costo del producto del ivel superior en la lsita de desempaque se toma
  el costo y dependiendo las pr_exist_cargar saca el nuevo costo por cada articulo mas abajo del
  nivel del desempaque y los actualiza.
  J.G.G. julio 2010.
  -------------------------------------------------------------------------------------------- }

function Productos_Desempaque_Actualiza_Costos_Precios(pPo_op_id: integer;
  bAllItems: Boolean = True; pMPr_id: string = ''): Boolean;
var
  oQry_PMast, oQry_PDese: Tzquery;
  cSqlLine: string;
  cMPr_id: string;
  cList: string;
  nMCosto, nMCostoP, nCantCmp: Single;
  nFact: Single;
begin
  try
    cSqlLine := '';
    cSqlLine := cSqlLine + 'SELECT * ';
    cSqlLine := cSqlLine + 'FROM   producto_op ';
    cSqlLine := cSqlLine + 'WHERE  po_op_id  ="' + IntToStr(pPo_op_id) + '" ';
    if bAllItems = False then
      cSqlLine := cSqlLine + 'AND   po_id_prod="' + pMPr_id + '" ';
    cSqlLine := cSqlLine + 'AND   po_pr_tipo=2 ';
    cSqlLine := cSqlLine + 'ORDER BY po_id_prod ';
    if Utiles.Exec_Select_SQL(oQry_PMast, cSqlLine, True, True) = False then
      exit;

    nFact := 1;
    while not oQry_PMast.eof do
    begin
      cMPr_id := oQry_PMast.FieldByName('po_id_prod').AsString;
      nCantCmp := oQry_PMast.FieldByName('po_cant').AsFloat;
      cList := Listas_Familia_un_Desempaque(cMPr_id);

      cSqlLine := '';
      cSqlLine := cSqlLine + 'SELECT ';
      cSqlLine := cSqlLine +
        'productos.pr_id           , productos.pr_descripcion  , ';
      cSqlLine := cSqlLine +
        'productos.pr_tipo         , productos_det.pr_costo_prom,  ';
      cSqlLine := cSqlLine +
        'productos.pr_exist_descar , productos.pr_exist_cargar, ';
      cSqlLine := cSqlLine + 'productos.pr_en_enlace ';
      cSqlLine := cSqlLine + 'FROM productos ';
      cSqlLine := cSqlLine +
        'INNER JOIN productos_det   ON productos.pr_Id = productos_det.pr_Id ';
      cSqlLine := cSqlLine + 'WHERE productos_det.suc_id=' +
        IntToStr(Utiles.iId_Empresa) + ' ';
      cSqlLine := cSqlLine + 'AND   productos.pr_id IN (' + cList + ') ';
      cSqlLine := cSqlLine + 'ORDER BY productos.pr_descripcion ASC ';
      if Utiles.Exec_Select_SQL(oQry_PDese, cSqlLine, True, True) = False then
      begin
        oQry_PMast.Next;
        continue;
        { exit }
      end;

      while not oQry_PDese.eof do
      begin

        cMPr_id := oQry_PDese.FieldByName('pr_id').AsString;
        nMCosto := oQry_PMast.FieldByName('po_precio').AsFloat / nFact;
        nMCostoP := Calcular_Costo_Promedio(cMPr_id, nMCosto, nCantCmp);

        cSqlLine := '';
        cSqlLine := cSqlLine + 'UPDATE productos_det SET ';
        cSqlLine := cSqlLine + 'pr_costo_prom = ' + FloatToStr2(nMCostoP) + ' ';
        cSqlLine := cSqlLine + 'WHERE pr_id = ' + cMPr_id + ' ';
        cSqlLine := cSqlLine + 'AND   suc_Id = ' +
          IntToStr(Utiles.iId_Empresa) + ' ';
        Utiles.Execute_SQL_Command(cSqlLine);

        Utiles.Producto_Recalcula_PreciosVta_Con_Costos(trim(cMPr_id));
        Utiles.Producto_Recalcula_Montos_Imp(trim(cMPr_id));
        Utiles.Producto_Recalcula_PreciosVta_Con_Imp(trim(cMPr_id));
        Utiles.Producto_Recalcula_Utilidad_Monto(trim(cMPr_id));
        nFact := (nFact * oQry_PDese.FieldByName('pr_exist_cargar').AsFloat);
        oQry_PDese.Next;
      end;
      oQry_PMast.Next;
    end;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      Result := False;
    end;
  end;
end;

{ -------------------------------------------------------------------------------------------------
  Estas funciones que acabamos de presentar siempre redondean el último dígito entero, pero a veces
  necesitamos redondear por ejemplo la segunda cifra decimal o los miles, millones y billones. La siguiente función realiza un "redondeo normal" tomando un parámetro adicional para indicar el dígito a ser redondeado:
  // RoundD(123.456, 0) = 123.00
  // RoundD(123.456, 2) = 123.46
  // RoundD(123456, -3) = 123000
}

function RoundD(X: extended; d: integer): extended;
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

function Inlist(aCadena: string; aLista: array of string): Boolean;
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

{ -------------------------------------------------------------------------------------------------
  esta funcion actualiza los item en el maestro de existencias, permite lotes o un producto en particular.
  este procedimiento trabaja sobre producto_op ó tmp_producto_op
  -------------------------------------------------------------------------------------------------- }

procedure Actualiza_Exist_Online(pTipo: string; pPo_op_id: integer;
  Sign: integer = 1; bAllItems: Boolean = True; pMPr_id: string = '');
var
  cSqlLine: string;
  cSetLine: string;
begin

  if trim(pTipo) = '1' then
  begin
    cSetLine := ' a.p_compras    =  (a.p_compras  +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '19' then
  begin
    cSetLine := ' a.p_dcompras =  (a.p_dcompras +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '11' then
  begin
    cSetLine := ' a.p_ncompras =  (a.p_ncompras +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '2' then
  begin
    cSetLine := ' a.p_ventas   =  (a.p_ventas  +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '16' then
  begin
    cSetLine := ' a.p_dventas  =  (a.p_dventas  +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '7' then
  begin
    cSetLine := ' a.p_nventas  =  (a.p_nventas  +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '9' then
  begin
    cSetLine := ' a.p_pventas  =  (a.p_pventas  +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '30' then
  begin
    cSetLine := ' a.p_cargos     =  (a.p_cargos  +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '31' then
  begin
    cSetLine := ' a.p_descargos  =  (a.p_descargos  +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '12' then
  begin
    cSetLine := ' a.p_ajustes     =  (a.p_ajustes  +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '36' then
  begin
    cSetLine := ' a.p_trasl_sal   =  (a.p_trasl_sal  +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '37' then
  begin
    cSetLine := ' a.p_trasl_ent   =  (a.p_trasl_ent  +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '40' then
  begin
    cSetLine := ' a.p_cargo_prod   =  (a.p_cargo_prod  +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '41' then
  begin
    cSetLine := ' a.p_descargo_prod=  (a.p_descargo_prod  +  ABS(b.po_cant)) ';
  end
  else if trim(pTipo) = '3' then
  begin
    cSetLine := ' a.p_apartado    =  (a.p_apartado  +  ABS(b.po_cant)) ';
  end;

  cSqlLine := '';
  cSqlLine := cSqlLine + 'UPDATE prod_existencia a, ';
  cSqlLine := cSqlLine + '(SELECT ';
  cSqlLine := cSqlLine + ' o.po_id, ';
  cSqlLine := cSqlLine + ' o.po_op_id, ';
  cSqlLine := cSqlLine + ' o.po_id_prod, ';
  cSqlLine := cSqlLine + ' SUM(o.po_cant*po_signo) AS po_cant, ';
  cSqlLine := cSqlLine + ' o.po_dep_id, ';
  cSqlLine := cSqlLine + ' o.suc_Id ';
  cSqlLine := cSqlLine + 'FROM producto_op o ';
  cSqlLine := cSqlLine +
    '   INNER JOIN productos_det ON o.po_id_prod = productos_det.pr_Id ';
  cSqlLine := cSqlLine + 'WHERE productos_det.suc_id=' +
    IntToStr(Utiles.iId_Empresa) + ' ';
  cSqlLine := cSqlLine + '   AND   productos_det.pr_man_exist = 1 ';
  cSqlLine := cSqlLine + '   AND   o.po_op_id = "' + IntToStr(pPo_op_id) + '" ';
  cSqlLine := cSqlLine + 'GROUP BY o.po_id_prod ';
  cSqlLine := cSqlLine + 'ORDER BY o.po_id_prod) b SET';
  cSqlLine := cSqlLine + cSetLine + ' ';
  cSqlLine := cSqlLine + ',a.p_existencia = (a.p_existencia + (' +
    IntToStr(Sign) + ' * b.po_cant)) ';
  cSqlLine := cSqlLine + 'WHERE a.pr_id = b.po_id_prod ';
  cSqlLine := cSqlLine + 'AND   a.p_existencia_dep_id = b.po_dep_id ';
  if bAllItems = False then
    cSqlLine := cSqlLine + 'AND   b.po_id_prod = "' + pMPr_id + '" ';
  Utiles.Execute_SQL_Command(cSqlLine);
end;

procedure SaveStringToFile(const Path, Data: string);
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

function Ctrl_Resize: Boolean;
begin
  if oSetting_Fac.ResizeScrn = 0 then
    Result := False
  else
    Result := True
end;

procedure PrintLineToGeneric(const line: string);
// Uses WinSpool;
var
  BytesWritten: DWORD;
  hPrinter: THandle;
  DocInfo: TDocInfo1;
const
  GenericPrinter: PChar = 'Factura';
  // Change to systems generic drivers name
begin
  if not WinSpool.OpenPrinter(GenericPrinter, hPrinter, nil) then
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
    WinSpool.ClosePrinter(hPrinter);
  end;
end;

function CadLongitudFija(cadena: string; longitud: integer;
  posicionIzquierda: Boolean; valorRelleno: string): string;
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

function CenterText(nWidth: integer; sText: string): string;
var
  nSpaces: integer;
begin
  nSpaces := (nWidth - Length(sText)) div 2;
  Result := Replicate(' ', nSpaces) + sText;
end;

procedure PrintLineOnDotMatrix(cPrinterName: string; cDocName: string;
  cString: string; bDobleCarr: Boolean; bTest: Boolean = False);
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
    cText := CadLongitudFija(cString, 40, False, ' ') + ' ' +
      CadLongitudFija(cString, 39, False, ' ') + #13 + #10;

  WritePrinter(handle, PChar(cText), Length(cText), n);

  EndPagePrinter(handle);
  EndDocPrinter(handle);

  ClosePrinter(handle);
end;

procedure ResizeKit_DBGridEh_Prepare(oDBGridEh: TDBGridEh;

  var pReziseVars: TReziseCntl); overload;
var
  i: integer;
begin
  pReziseVars.nMAXCOL_DG := oDBGridEh.Columns.Count;
  pReziseVars.nMAXROW_DG := oDBGridEh.RowCount;
  for i := 0 to pReziseVars.nMAXCOL_DG - 1 do
    pReziseVars.aOrg_Width_DG[i] := oDBGridEh.Columns[i].Width;
end;

procedure ResizeKit_DBGridEh(oDBGridEh: TDBGridEh; pXScale: Double;
  pYScale: Double; pReziseVars: TReziseCntl); overload;
var
  i: integer;
begin
  for i := 0 to oDBGridEh.Columns.Count - 1 do
    oDBGridEh.Columns[i].Width := Round(pReziseVars.aOrg_Width_DG[i] * pXScale);

  // oDBGridEh.RowHeight := Round(pReziseVars.nOrg_Height_DG * pYScale);
end;

function SeEjecutaEnInicio(NombreEjecutable: string;
  SoloUnaVez, SoloUsuario: Boolean): Boolean;
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
      raise Exception.Create('Error: No se pudo abrir la clave ' + clave +
        ' del registro de windows');

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
            if Lowercase(NombreEjecutable)
              = Lowercase(Registro.ReadString(Valores[n])) then
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

procedure EjecutarEnInicio(NombrePrograma, NombreEjecutable: string;
  SoloUnaVez, SoloUsuario: Boolean);
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
      raise Exception.Create('Error: No se pudo abrir la clave ' + clave +
        ' del registro de windows');
    // Escribimos el valor para que se arranque el programa especificado:
    Registro.writeString(NombrePrograma, NombreEjecutable);
  finally
    Registro.Free;
  end;
end;
// procedure EjecutarEnInicio

procedure QuitarEjecutarEnInicio(NombreEjecutable: string;
  SoloUnaVez, SoloUsuario: Boolean);
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
      raise Exception.Create('Error: No se pudo abrir la clave ' + clave +
        ' del registro de windows');

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
            if Lowercase(NombreEjecutable)
              = Lowercase(Registro.ReadString(Valores[n])) then
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
end; // procedure QuitarEjecutarEnInicio
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

procedure OpcionesApagarWindows(Sender: TObject);
var
  Shell: OleVariant;

begin
  Shell := ComObj.CreateOleObject('shell.application');
  Shell.ShutDownWindows;
end;

procedure CierraSessionWindows;
begin
  ExitWindowsEx(0, 0);
  { EWX_LOGOFF - Cierra los procesos y la sesión del usuario. }
end;

procedure ReiniciaWindows;
begin
  ExitWindowsEx(2, 0);
  { EWX_REBOOT - Reboot. Debes tener privilegio SE_SHUTDOWN_NAME }
end;

procedure ApagaWindows;
begin
  ExitWindowsEx(8, 0);
  { EWX_POWEROFF - Apagar. Debes tener privilegio SE_SHUTDOWN_NAME }
end;

procedure Quita_Facil_De_Inicio_Windows(pCierraSession: Boolean = True);
begin
  if SeEjecutaEnInicio(UpperCase(Application.ExeName), False, True) = True then
  begin
    QuitarEjecutarEnInicio(UpperCase(Application.ExeName), False, True);
    if pCierraSession = True then
      CierraSessionWindows;
  end;
end;

procedure Poner_Facil_De_Inicio_Windows(pCierraSession: Boolean = True);
var
  cApp_Name: string;
begin
  cApp_Name := UpperCase(ExtractFileName(Application.ExeName));
  EjecutarEnInicio('RCTECH ' + cApp_Name, UpperCase(Application.ExeName),
    False, True);
  if pCierraSession = True then
    CierraSessionWindows;
end;

{ ********************************************************************* }
{ Strip('L',' ',' bob') returns 'bob' }
{ Strip('R','5','56345') returns '5634' }
{ Strip('B','H','HASH') returns 'as' }
{ strip('A','E','fleetless') returns fltlss }
{ ********************************************************************* }

function Strip(L, c: Char; Str: string): string;
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

function fields_info(var oQryFlds: Tzquery; field: string = '*';
  DBName: string = ''; TableName: string = ''): Boolean; overload;
var
  cSqlCmdl: string;
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
  if Utiles.Exec_Select_SQL(oQryFlds, cSqlCmdl, True, False, False) = True then
    Result := True
  else
    Result := False;
end;

function fields_info(oConn_Tmp: TZConnection;

  var oQryFlds: Tzquery; field: string = '*'; DBName: string = '';
  TableName: string = ''): Boolean; overload;
var
  cSqlCmdl: string;
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
  if Utiles.Exec_Select_SQL(oConn_Tmp, oQryFlds, cSqlCmdl, True, False, False) = True
  then
    Result := True
  else
    Result := False;
end;

procedure DataRefresh(var oDataset: Tdataset; pfield_Name: string);
var
  oldKey: integer;
begin
  oldKey := oDataset.FieldByName(pfield_Name).AsInteger;
  oDataset.Refresh;
  oDataset.Locate(pfield_Name, oldKey, []);
end;

{ ************************************************
  // procedure AppendCurrent
  // Written By: Steve Zimmelman
  //
  // Will append an exact copy of the current
  // record of the dataset that is passed into
  // the procedure and will return the dataset
  // in edit state with the record pointer on
  // the currently appended record.
  ************************************************ }

procedure AppendCurrent(Dataset: Tdataset);
var
  aField: variant;
  i: integer;
begin
  // Create a variant Array
  aField := VarArrayCreate([0, Dataset.Fieldcount - 1], VarVariant);
  // read values into the array
  for i := 0 to (Dataset.Fieldcount - 1) do
  begin
    aField[i] := Dataset.Fields[i].Value;
  end;
  Dataset.Append;
  // Put array values into new the record
  for i := 0 to (Dataset.Fieldcount - 1) do
  begin
    Dataset.Fields[i].Value := aField[i];
  end;
end;

// Save a TStringGrid to a file

procedure SaveStringGrid(StringGrid: TStringGrid;

  const FileName: TFileName);
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

procedure LoadStringGrid(StringGrid: TStringGrid;

  const FileName: TFileName);
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

function ReplaceDatePart(pDateTime: TDateTime; pDateReplace: TDateTime)
  : TDateTime;
var
  oDay, oMonth, oYear, oHour, oMinute, oSecond, oMilli: Word;
  rDay, rMonth, rYear: Word;
begin
  DecodeDateTime(pDateTime, oYear, oMonth, oDay, oHour, oMinute,
    oSecond, oMilli);
  DecodeDate(pDateReplace, rYear, rMonth, rDay);
  Result := EncodeDateTime(rYear, rMonth, rDay, oHour, oMinute,
    oSecond, oMilli);
end;

function TimeToDateTime(pTime: Ttime): TDateTime;
begin
  Result := StrToDateTime(FormatDateTime('yyyy-mm-dd', Now) + ' ' +
    TimeToStr(pTime));
end;

function esPrimo(X: integer): Boolean;
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

function Par2(Num: integer): Boolean;
begin
  if Num mod 2 = 0 then
    Result := True
  else
    Result := False;
end;

function par(n: integer): Boolean;
asm
  and ax,1
  dec ax
end;

function GetProgramFilesDir2: string;
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

function tiempo_Transcurrido(pStartTime: DWORD; pEndTime: DWORD): string;
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
    Result := 'Tiempo Transcurrido: ' + IntToStr(Estimated_seconds) +
      ' Segundos. '
  else
    Result := 'Tiempo Transcurrido: ' + IntToStr(Estimated_hours) + ':' +
      IntToStr(Estimated_Minutes) + ':' + IntToStr(Estimated_seconds);
end;

function MapNetworkDriveDLG(const handle: THandle;

  const uncPath: string): string;
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

function Get_File_Size2(sFileToExamine: string): integer;
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
    SysUtils.FindClose(SearchRec);
  end;
  Result := I1;
end;

function isValidPath(Value: string): Boolean;
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

function DoAutologin(var bStartApp1: Boolean; var bStartApp2: Boolean;
  var bIsServer: Boolean; bCheckPassword: Boolean = False): Boolean;
var
  oFileIni: Tinifile;
  cServerName, cUsername, cPassword, cStation, cUserPass: string;
  nAutolog, nStartProc1, nStartProc2, nStartProc3, nStartProc4, iTmp,
    iDelay: integer;
  oQryUser: Tzquery;
  cGetDir: string;
begin
  { -----------Johnn G. Gutierrez A. 03-05-2011 RCTECH SOFTWARE HOUSE.---------------------------- }
  { ------------------------Última modificasión: 19-04-2012--------------------------------------- }
  bId_Estacion_Force := False;
  cId_Estacion := '';

  cGetDir := ExtractFilePath(Application.ExeName);
  oQryUser := Tzquery.Create(nil);
  oFileIni := Tinifile.Create(cGetDir + 'Data\Config.ini');

  if (bId_Estacion_Force = False) then
    oFileIni.DeleteKey('AUTOLOGIN', 'STATION');
  {
    oFileIni.DeleteKey('AUTOLOGIN', 'PROC_ENVIA');
    oFileIni.DeleteKey('AUTOLOGIN', 'PROC_EMPAC');
  }
  cServerName := oFileIni.ReadString('AUTOLOGIN', 'SERVIDOR', '');
  if (bCheckPassword = True) then
  begin
    cUsername := oFileIni.ReadString('AUTOLOGIN', 'USERNAME', '');
    cUserPass := oFileIni.ReadString('AUTOLOGIN', 'PASSWORD', '');
  end
  else
  begin
    cUsername := 'SUPER';
    cUserPass := '';
  end;
  nAutolog := oFileIni.ReadInteger('AUTOLOGIN', 'AUTOLOG', 0);
  nStartProc1 := oFileIni.ReadInteger(ExtractFileName(Application.ExeName),
    'STARTPROC1', 0);
  nStartProc2 := oFileIni.ReadInteger(ExtractFileName(Application.ExeName),
    'STARTPROC2', 0);
  iTmp := oFileIni.ReadInteger('AUTOLOGIN', 'ISSERVER', 0);
  bIsServer := iif(iTmp = 0, False, True);
  iDelay := oFileIni.ReadInteger('AUTOLOGIN', 'DELAYSTART', 0);
  cPassword := Utiles.iif(trim(cUserPass) = '', '',
    Base64.Base64Decode(cUserPass));

  { Guarda la configuracion que leyo! }
  oFileIni.writeString('AUTOLOGIN', 'SERVIDOR',
    Utiles.iif(trim(cServerName) = '', Utiles.sSlectedHost, cServerName));
  if (bCheckPassword = True) then
  begin
    oFileIni.writeString('AUTOLOGIN', 'USERNAME', cUsername);
    oFileIni.writeString('AUTOLOGIN', 'PASSWORD', cUserPass);
  end;
  oFileIni.WriteInteger('AUTOLOGIN', 'ISSERVER', iTmp);
  oFileIni.WriteInteger('AUTOLOGIN', 'AUTOLOG', nAutolog);
  oFileIni.WriteInteger('AUTOLOGIN', 'DELAYSTART', iDelay);
  oFileIni.WriteInteger(ExtractFileName(Application.ExeName), 'STARTPROC1',
    nStartProc1);
  oFileIni.WriteInteger(ExtractFileName(Application.ExeName), 'STARTPROC2',
    nStartProc2);
  cStation := Utiles.Get_Station_id;

  { }

  { El Autologin esta desactivado }
  if ((nAutolog = 0) or Utiles.isEmpty(cServerName) or Utiles.isEmpty(cUsername)
    or Utiles.isEmpty(cStation)) then
  begin
    Utiles.oSetting_Fac.nAutoLogin := 0;
    Utiles.bId_Estacion_Force := False;
    bStartApp1 := False;
    bStartApp2 := False;
    Result := False;
    exit;
  end;
  Utiles.cId_Estacion := cStation;
  if ((iDelay > 0) and (iDelay <= 120)) then
    Utiles.Delay(iDelay * 1000);

  Utiles.bConnectionOk := False;

  if Utiles.oPublicCnn <> nil then
    Utiles.oPublicCnn.Connected := False;

  if Utiles.oPublicCnnProc <> nil then
    Utiles.oPublicCnnProc.Connected := False;

  if Utiles.oMyPublicCnn <> nil then
    Utiles.oMyPublicCnn.Connected := False;

  { Trata de conectarse con el servidor que se esta leyendo }
  Utiles.ConnectServer(trim(cServerName));

  { Si el servidor lo logra conectarse se sale }
  if Utiles.oPublicCnn.Connected = False then
  begin
    Utiles.oSetting_Fac.nAutoLogin := 0;
    Utiles.bId_Estacion_Force := False;
    bStartApp1 := False;
    bStartApp2 := False;
    Result := False;
    exit;
  end;

  if Utiles.BuscarUsuario(oQryUser, cUsername, False) <= 0 then
  begin
    Utiles.bId_Estacion_Force := False;
    Utiles.oSetting_Fac.nAutoLogin := 0;
    bStartApp1 := False;
    bStartApp2 := False;
    Result := False;
    exit;
  end
  else
  begin
    { El Usuario no existe }
    if bCheckPassword = True then
    begin
      if not( (oQryUser.FieldByName('u_clave').AsString = Utiles.Encrypt(cPassword)) and (oQryUser.FieldByName('u_acceso1').AsInteger = 1))
      then
      begin
        Utiles.bId_Estacion_Force := False;
        Utiles.oSetting_Fac.nAutoLogin := 0;
        bStartApp1 := False;
        bStartApp2 := False;
        Result := False;
        exit;
      end;
    end;

    Utiles.sUserName := trim(oQryUser.FieldByName('u_usuario').AsString);
    Utiles.sUserPass := trim(oQryUser.FieldByName('u_clave').AsString);
    Utiles.iUser_Logged := oQryUser.FieldByName('u_Id').AsInteger;
    Utiles.iUserID := oQryUser.FieldByName('u_Id').AsInteger;
    Utiles.sPathReports := trim(oQryUser.FieldByName('u_ruta_reportes')
      .AsString);
    Utiles.sSlectedHost := trim(cServerName);
    Utiles.iId_Empresa := 1;
    Utiles.bId_Estacion_Force := True;
    Utiles.oSetting_Fac.nAutoLogin := 1;
    // cId_Estacion := BuscarEstacion(cStation, False);
    bStartApp1 := iif(nStartProc1 = 1, True, False);
    bStartApp2 := iif(nStartProc2 = 1, True, False);
    Result := True;
  end;
  freeandnil(oFileIni);
  freeandnil(oQryUser);
end;

procedure FormTransparence(oForm: Tform; iLimit: integer = 0);
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
    Utiles.Delay(10);
    Application.ProcessMessages;
  end;
end;

procedure FormDegrade(oForm: Tform);
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

function GetUNCName(const LocalPath: string): string;
var
  BufferSize: DWORD;
  DummyBuffer: Byte;
  Buffer: Pointer;
  error: DWORD;
begin
  BufferSize := 1;
  WNetGetUniversalName(PChar(LocalPath), UNIVERSAL_NAME_INFO_LEVEL,
    @DummyBuffer, BufferSize);
  Buffer := AllocMem(BufferSize);
  try
    error := WNetGetUniversalName(PChar(LocalPath), UNIVERSAL_NAME_INFO_LEVEL,
      Buffer, BufferSize);
    if error <> NO_ERROR then
    begin
      SetLastError(error);
      RaiseLastWin32Error;
    end;
    Result := PUniversalNameInfo(Buffer)^.lpUniversalName
  finally
    FreeMem(Buffer);
  end;
end;

function GetIPFromHost(HostName: string): string;
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

{
  function GetIPFromHost(var HostName, IPaddr, WSAErr: string): Boolean;
  type
  Name = AnsiString;
  PName = ^Name;
  var
  HEnt: pHostEnt;
  HName: PName;
  WSAData: TWSAData;
  i: integer;
  begin

  Result := False;
  if WSAStartup($0101, WSAData) <> 0 then
  begin
  WSAErr := 'Winsock is not responding."';
  exit;
  end;
  IPaddr := '';
  New(HName);
  if GetHostName(PAnsiChar(HName), SizeOf(Name)) = 0 then
  begin
  HostName := StrPas(PAnsiChar(HName^));
  HEnt := GetHostByName(PAnsiChar(HName));
  for i := 0 to HEnt^.h_length - 1 do
  IPaddr := Concat(IPaddr, IntToStr(Ord(HEnt^.h_addr_list^[i])) + '.');
  SetLength(IPaddr, Length(IPaddr) - 1);
  Result := True;
  end
  else
  begin
  case WSAGetLastError of
  WSANOTINITIALISED:
  WSAErr := 'WSANotInitialised';
  WSAENETDOWN:
  WSAErr := 'WSAENetDown';
  WSAEINPROGRESS:
  WSAErr := 'WSAEInProgress';
  end;
  end;
  Dispose(HName);
  WSACleanup;

  end;
}
function CornerForm(form: TCustomForm; corner: TCorner): Boolean;
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

function Ftp_Is_Alive(cHost: string; cUsername: string = 'remoto';
  cPassword: string = '1234'; nPort: integer = 21): Boolean;
var
  FTP: TIdFTP;
begin
  try
    begin
      FTP := TIdFTP.Create(nil);
      FTP.Username := cUsername;
      FTP.Password := cPassword;
      FTP.host := cHost;
      FTP.Port := nPort;
      FTP.Connect;
      Result := True;
      exit;
    end;
  except
    Result := False;
    exit;
  end;
end;

function Check_Host_IsAlive(cHost: string; nPort: integer): Boolean;
var
  IdTCPClient1: TIdTCPClient;
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
  oFileIni := Tinifile.Create(ExtractFilePath(Application.ExeName) +
    'Data\Config.ini');
  nPING_ON_CONNECTION := oFileIni.ReadInteger('GENERAL',
    'PING_ON_CONNECTION', 0);
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
  {
    IdTCPClient1 := TIdTCPClient.Create(nil);
    IdTCPClient1.host := cIpAdress;
    IdTCPClient1.Port := nPort;
    IdTCPClient1.ConnectTimeout := 1;
    try
    begin
    IdTCPClient1.Connect;
    Result := True;
    freeandnil(IdTCPClient1);
    exit;
    end;
    except
    Result := False;
    freeandnil(IdTCPClient1);
    exit;
    end;
  }
end;

procedure InitCheckConnection;
begin
  if IdIPWatch1 = nil then
    IdIPWatch1 := TIdIPWatch.Create(nil);

  if (IdIPWatch1.Active = False) then
    IdIPWatch1.Active := True;
end;

procedure Split(const Delimiter: Char; Input: string;

  const Strings: TStrings);
begin
  Assert(Assigned(Strings));
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

function BuscarEstacion(sEstacion: string;
  bCheckActive: Boolean = True): string;
var
  cSql: string;
  oQry1: Tzquery;
begin
  if bCheckActive = False then
    cSql := 'SELECT * FROM estaciones WHERE UCASE(TRIM(e_descripcion)) = "' + ''
      + UpperCase(trim(sEstacion)) + '' + '"'
  else
    cSql := 'SELECT * FROM estaciones WHERE e_activo = 1 AND UCASE(TRIM(e_descripcion)) = "'
      + '' + UpperCase(trim(sEstacion)) + '' + '"';

  if Utiles.Exec_Select_SQL(oQry1, cSql, True, True, False) = True then
    Result := oQry1.FieldByName('e_id').AsString
  else
    Result := '0';
end;

function HKA_ShowStatusByName(pShowMessage: Boolean;

  var pStringStatus: string): Boolean;
var
  nChoice: integer;
  cStatus: string;
  bResult: Boolean;
begin
  bResult := Utiles.ReadFpStatus(@HKA_FP_Status, @HKA_FP_Error);
  nChoice := integer(HKA_FP_Status);
  case nChoice of
    0:
      cStatus := 'Status Desconocido.';
    1:
      cStatus := 'En modo prueba y en espera.';
    2:
      cStatus := 'En modo prueba y emisión de documentos fiscales.';
    3:
      cStatus := 'En modo prueba y emisión de documentos no fiscales.';
    4:
      cStatus := 'En modo fiscal y en espera.';
    5:
      cStatus := 'En modo fiscal y emisión de documentos fiscales.';
    6:
      cStatus := 'En modo fiscal y emisión de documentos no fiscales.';
    7:
      cStatus :=
        'En modo fiscal y cercana carga completa de la memoria fiscal y en espera.';
    8:
      cStatus :=
        'En modo fiscal y cercana carga completa de la memoria fiscal y en emisión de doscumentos fiscales.';
    9:
      cStatus :=
        'En modo fiscal y cercana carga completa de la memoria fiscal y en emisión de doscumentos no fiscales.';
    10:
      cStatus :=
        'En modo fiscal y carga completa de la memoria fiscal y en espera.';
    11:
      cStatus :=
        'En modo fiscal y carga completa de la memoria fiscal y en emisión de documentos fiscales.';
    12:
      cStatus :=
        'En modo fiscal y carga completa de la memoria fiscal y en emisión de documentos no fiscales.';
  else
    cStatus := 'Status Desconocido.';
  end;

  pStringStatus := cStatus;
  if pShowMessage = True then
    showmessage(cStatus);

  if ((nChoice = 4) or (nChoice = 7)) then
    Result := True
  else
    Result := False;
end;

function HKA_ShowErrorByName(pShowMessage: Boolean;

  var pStringStatus: string): Boolean;
var
  nChoice: integer;
  cError: string;
  bResult: Boolean;
begin
  bResult := Utiles.ReadFpStatus(@HKA_FP_Status, @HKA_FP_Error);
  nChoice := integer(HKA_FP_Error);
  case nChoice of
    0:
      cError := 'No hay error.';
    1:
      cError := 'Fin de la entrega del papel.';
    2:
      cError := 'Error mecánico en la entrega del papel.';
    3:
      cError := 'Fin de la entrega del papel y error mecánico.';
    80:
      cError := 'Comando inálido, valor inválido.';
    84:
      cError := 'Tasa inválida.';
    88:
      cError := 'No hay asignadas directivas.';
    92:
      cError := 'Comando inválido.';
    96:
      cError := 'Error fiscal.';
    100:
      cError := 'Error de la memoria fiscal.';
    108:
      cError := 'Memoria fiscal llena.';
    112:
      cError := 'Buffer completo. (Debe enviar comando de reinicio.';
    128:
      cError := 'Error de comunicación.';
    137:
      cError := 'No hay respuesta.';
    144:
      cError := 'Error LRC.';
    145:
      cError := 'Error Interno API.';
    153:
      cError := 'Error en la apertura del archivo.';
  else
    cError := 'Error desconocido.';
  end;

  if nChoice <> 0 then
  begin
    pStringStatus := cError;
    if pShowMessage = True then
      showmessage(cError);
    Result := True;
  end
  else
  begin
    pStringStatus := '';
    Result := False;
  end;
end;

function query_selectgen_result(text: string): string;
var
  query_sel: Tzquery;
begin
  try
    query_sel := Tzquery.Create(nil);
    query_sel.Connection := Utiles.oPublicCnn;
    query_sel.Active := False;
    query_sel.SQL.Clear;
    query_sel.SQL.text := text;
    query_sel.Open;
    if query_sel.Fields[0].text <> '' then
      Result := query_sel.Fields[0].text
    else
      Result := query_sel.Fields[0].text;
  except
    Result := '';
  end;
  query_sel.Free;
end;

function GetIPAddress(name: AnsiString): string;
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

function GetHostByAddr(IP: string): string;
var
  WSData: TWSAData;
  SockAddrIn: TSockAddrIn;
  HostEnt: PHostEnt;
begin
  Result := '';
  // Tente inicializar uma seçao winsock
  if WSAStartup($101, WSData) = 0 then
  begin
    // Converta a string IP em bytes, na ordem correta do endereço IP
    SockAddrIn.sin_addr.S_addr := inet_addr(PAnsiChar(IP));
    // Chame GetHostByAddr
    HostEnt := Winsock.GetHostByAddr(@SockAddrIn.sin_addr.S_addr,
      SizeOf(SockAddrIn.sin_addr.S_addr), AF_INET);
    // Se bem sucedido...
    if HostEnt <> nil then
      // ...recupere o nome do host (valor de retorno)
      Result := StrPas(HostEnt^.h_name);
    // Feche a seção winsock
    WSACleanup;
  end;

end;

function GetComputerNetName: string;
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

function removeLeadingZeros(const Value: string): string;
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
  if (oPub_Qry = NIL) then
    oPub_Qry := TMyQuery.Create(nil);

  if isEmpty(pSQL) = True then
  begin
    Result := '';
    exit;
  end;

  Result := '';
  if (bConnectionOk = False) then
    Carga_Setting_Conn2();

  if Check_Host_IsAlive(Utiles.oMyPublicCnn.server, Utiles.oMyPublicCnn.Port) = False
  then
  begin
    Result := '';
    exit;
  end;

  oPub_Qry.Connection := Utiles.oMyPublicCnn;
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
  oPub_Qry.Close;
end;

function Execute_SQL_Result(oConn_Tmp: TMyConnection; pSQL: string)
  : string; overload;
begin
  if (oPub_Qry = NIL) then
    oPub_Qry := TMyQuery.Create(nil);

  if isEmpty(pSQL) = True then
  begin
    Result := '';
    exit;
  end;

  if Check_Host_IsAlive(oConn_Tmp.server, oConn_Tmp.Port) = False then
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
  oPub_Qry.Close;
end;

function Execute_SQL_Query(var oQry: TMyQuery; sSql: TStringList;
  oQryExec: Boolean = False): Boolean; overload;
begin
  Carga_Setting_Conn2();

  if oQry = nil then
    oQry := TMyQuery.Create(nil);

  Carga_Setting_Conn2();
  if Check_Host_IsAlive(oMyPublicCnn.server, oMyPublicCnn.Port) = False then
  begin
    Result := False;
    exit;
  end;

  oQry.Connection := Utiles.oMyPublicCnn;
  oQry.Close;
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

function Execute_SQL_Query(oConn_Tmp: TMyConnection; var oQry: TMyQuery;
  sSql: string; oQryExec: Boolean = False): Boolean; overload;
begin

  if oQry = nil then
    oQry := TMyQuery.Create(nil);

  Carga_Setting_Conn2();

  if Check_Host_IsAlive(oConn_Tmp.server, oConn_Tmp.Port) = False then
  begin
    Result := False;
    exit;
  end;

  oQry.Close;
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

function Execute_SQL_Query(var oQry: TMyQuery; sSql: string;
  oQryExec: Boolean = False): Boolean; overload;
begin
  if oQry = nil then
    oQry := TMyQuery.Create(nil);

  if Check_Host_IsAlive(Utiles.oMyPublicCnn.server, Utiles.oMyPublicCnn.Port) = False
  then
  begin
    Result := False;
    exit;
  end;

  Carga_Setting_Conn2();

  oQry.Connection := Utiles.oMyPublicCnn;
  oQry.Close;
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

(*
  Busca y lista los archivos que cumplan con determinada
  máscara y que se encuentren en un determinado directorio
  y/o dentro de los subdirectorios del mismo.

  Parámetros:

  directorio: en el que buscar, por ejemplo: C:\
  mascara: de archivo, por ejemplo: *.txt
  atributos: de los archivos, por ejemplo: faAnyFile
  listado: donde guardar los posibles resultados (1)

  (1) Rutas completas de los archivos encontrados
*)
procedure BuscarArchivos(const directorio, mascara: string; atributos: integer;
  var listado: TStringList);

// Procedimiento anidado
//
  procedure Buscar(const subdirectorio: string);
  var
    regBusqueda: TSearchRec;
  begin
    // Buscar en el directorio
    if FindFirst(subdirectorio + mascara, atributos, regBusqueda) = 0 then
    begin
      try
        repeat
          Application.ProcessMessages;
          if (regBusqueda.Attr and faDirectory = 0) or (regBusqueda.name <> '.')
            and (regBusqueda.name <> '..') then
            listado.Add(subdirectorio + regBusqueda.name);
        until FindNext(regBusqueda) <> 0;
      except
        FindClose(regBusqueda);
      end;
      FindClose(regBusqueda);
    end;
    // Buscar en los subdirectorios
    if FindFirst(subdirectorio + '*', atributos or faDirectory, regBusqueda) = 0
    then
    begin
      try
        repeat
          Application.ProcessMessages;
          if ((regBusqueda.Attr and faDirectory) <> 0) and
            (regBusqueda.name <> '.') and (regBusqueda.name <> '..') then
            Buscar(subdirectorio + regBusqueda.name + '\');
        until FindNext(regBusqueda) <> 0;
      except
        FindClose(regBusqueda);
      end;
      FindClose(regBusqueda);
    end;
  end;

//
// Fin del procedimiento anidado:
// Comienza "BuscarArchivos(...)"
//
begin
  Buscar(IncludeTrailingPathDelimiter(directorio));
end;

end.
