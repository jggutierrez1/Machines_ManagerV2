unit networkFunctions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinInet, WinSock;

type
  PNetResourceArray = ^TNetResourceArray;
  TNetResourceArray = array[0..100] of TNetResource;

type
  IPAddr = DWORD;

  PICMP_ECHO_REPLY = ^ICMP_ECHO_REPLY;
  ICMP_ECHO_REPLY = packed record
    Address: ULONG;
    Status: ULONG;
    RoundTripTime: ULONG;
    DataSize: WORD;
    Reserved: WORD;
    Data: Pointer;
  end;

  PIP_OPTION_INFORMATION = ^IP_OPTION_INFORMATION;
  IP_OPTION_INFORMATION = packed record
    Ttl: byte;
    Tos: byte;
    Flags: byte;
    OptionsSize: byte;
    OptionsData: Pointer;
  end;

procedure GetComputerList(List: TStrings);
function InternetAvailable: Boolean; // Only DFÜ / RAS
function Ping(IP: string; TimeOut: Cardinal): Boolean; // TimeOut ~1000
function GetNetworkName(IPAddr: string): string;
function GetIp(const HostName: string): string;

implementation

function IcmpCreateFile: DWORD; stdcall; external 'icmp.dll';

function IcmpCloseHandle(const IcmpHandle: DWORD): longbool; stdcall; external 'icmp.dll';

function IcmpSendEcho(const IcmpHandle: DWORD; const DestinationAddress: IPAddr; const RequestData: Pointer; const RequestSize: WORD; const RequestOptions: PIP_OPTION_INFORMATION; const ReplyBuffer: Pointer; const ReplySize: DWORD; const TimeOut: DWORD): DWORD; stdcall; external 'icmp.dll';

function GetNetworkName(IPAddr: string): string;
var SockAddrIn: TSockAddrIn;
  HostEnt: PHostEnt;
  WSAData: TWSAData;
begin
  WSAStartup($101, WSAData);
  SockAddrIn.sin_addr.s_addr := inet_addr(PAnsiChar(IPAddr));
  HostEnt := GetHostByAddr(@SockAddrIn.sin_addr.S_addr, 4, AF_INET);
  if HostEnt <> nil then
    Result := StrPas(Hostent^.h_name)
  else
    Result := '';
end;

function GetIp(const HostName: string): string;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  i: Integer;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := '';
  phe := GetHostByName(PAnsiChar(HostName));
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  i := 0;
  while pPtr^[i] <> nil do begin
    Result := inet_ntoa(pptr^[i]^);
    Inc(i);
  end;
  WSACleanup;

end;

function Ping(IP: string; TimeOut: Cardinal): Boolean;
var hICMP: DWORD;
  pierWork: PICMP_ECHO_REPLY;
  dwSize: DWORD;
  Class1, Class2, Class3, Class4: string;
  i, j: Byte;
begin
  Result := False;
  j := 1;
  for i := 1 to Length(IP) do begin
    if IP[i] <> '.' then begin
      case j of
        1: Class1 := Class1 + IP[i];
        2: Class2 := Class2 + IP[i];
        3: Class3 := Class3 + IP[i];
        4: Class4 := Class4 + IP[i];
      end;
    end else
      Inc(j);
  end;
  hICMP := IcmpCreateFile;
  if hICMP = INVALID_HANDLE_VALUE then exit;
  try
    dwSize := SizeOf(ICMP_ECHO_REPLY) + 8;
    pierWork := AllocMem(dwSize);
    try
      if IcmpSendEcho(hICMP, MAKELONG(MAKEWORD(StrToInt(Class1), StrToInt(Class2)), MAKEWORD(StrToInt(Class3), StrToInt(Class4))), nil, 0, nil, pierWork, dwSize, TimeOut) = 0 then
        Result := False
      else
        Result := True;
    finally
      FreeMem(pierWork, dwSize);
    end;
  finally
    IcmpCloseHandle(hIcmp);
  end;
end;

  // Nur für DFÜ / RAS

function InternetAvailable: Boolean;
begin
  Result := InternetCheckConnection(nil, 0, 0);
end;

function CreateNetResourceList(ResourceType: DWord;
  NetResource: PNetResource;
  out Entries: DWord;
  out List: PNetResourceArray): Boolean;
var
  EnumHandle: THandle;
  BufSize: DWord;
  Res: DWord;
begin
  Result := False;
  List := nil;
  Entries := 0;
  if WNetOpenEnum(RESOURCE_GLOBALNET, ResourceType, 0, NetResource, EnumHandle) = NO_ERROR then begin
    try
      BufSize := $4000; // 16 kByte
      GetMem(List, BufSize);
      try
        repeat
          Entries := DWord(-1);
          FillChar(List^, BufSize, 0);
          Res := WNetEnumResource(EnumHandle, Entries, List, BufSize);
          if Res = ERROR_MORE_DATA then begin
            ReAllocMem(List, BufSize);
          end;
        until Res <> ERROR_MORE_DATA;

        Result := Res = NO_ERROR;
        if not Result then begin
          FreeMem(List);
          List := nil;
          Entries := 0;
        end;
      except
        FreeMem(List);
        raise;
      end;
    finally
      WNetCloseEnum(EnumHandle);
    end;
  end;
end;

procedure GetComputerList(List: TStrings);
  procedure ScanLevel(ResourceType, DisplayType: DWord; NetResource: PNetResource);
  var
    Entries: DWord;
    NetResourceList: PNetResourceArray;
    i: Integer;
  begin
    if CreateNetResourceList(ResourceType, NetResource, Entries, NetResourceList) then try
      for i := 0 to Integer(Entries) - 1 do begin
        if (DisplayType = RESOURCEDISPLAYTYPE_GENERIC) or
          (NetResourceList[i].dwDisplayType = DisplayType) then begin
          List.AddObject(NetResourceList[i].lpRemoteName,
            Pointer(NetResourceList[i].dwDisplayType));
        end;
        if (NetResourceList[i].dwUsage and RESOURCEUSAGE_CONTAINER) <> 0 then
          ScanLevel(RESOURCETYPE_DISK, RESOURCEDISPLAYTYPE_SERVER, @NetResourceList[i]);
      end;
    finally
      FreeMem(NetResourceList);
    end;
  end;
begin
  ScanLevel(RESOURCETYPE_DISK, RESOURCEDISPLAYTYPE_SERVER, nil);
end;

end.

