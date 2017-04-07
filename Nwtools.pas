
unit Nwtools;

interface

uses
   SysUtils,
   Messages,
   WinProcs,
   WinTypes,
   Controls,
   graphics,
   Forms,
   Classes,
   dialogs,
   grids;
   
   {$IFDEF Ver110}
   {$ObjExportAll On}
   {$ENDIF}
   
   type
      TNWError = longint;
      
      function maxLong(nVal1, nVal2: Longint): longint;
      function minLong(nstart, nend: longint): longint;
      function timeTextInc(ctime: string; nway: integer): string;
      function datetextInc(cdate: string; nway: integer): string;
      function charCount(const ctext: string; ctoken: char): integer;
      function allTrim(const ctext: string): string;
      function lTrim(ctext: string): string;
      function rTrim(ctext: string): string;
      function strExtract(ctext: string; const ctoken: char; const npos: integer): string;
      function canOpen(cfile: string): boolean;
      function leftString(ctext: string; nlen: integer): string;
      function rightString(ctext: string; nlen: integer): string;
      function setPath(cpath: string): string;
      function fUnique(cpath: string): string;
      function padC(ctext: string; nlen: integer; cchar: char): string;
      function padL(ctext: string; nlen: integer; cchar: char): string;
      function padR(ctext: string; nlen: integer; cchar: char): string;
      function proper(ctext: string): string;
      function iif(const lvalue: boolean; cret1: string; cret2: string): string;
      function between(nval, nmin, nmax: longint): Boolean;
      function strEmpty(ctext: string): Boolean;
      function yesNoBox(cText: string): Boolean;
      function noYesBox(cText: string): Boolean;
      function YNCBox(ctext: string): integer;
      procedure okBox(cText: string);
      procedure alertBox(cText: string);
      function strTran(ctext, cfor, cwith: string): string;
      function delim2StrList(ctext: string): TStringList;
      function rat(const ctoken: char; const ctext: string): integer;
      function formDate(cdate: TDateTime): string;
      function formTime(cdate: TDateTime): string;
      function day(cdate: TDateTime): byte;
      function month(cdate: TDateTime): byte;
      function hour(cTime: TDateTime): byte;
      function minute(cTime: TDateTime): byte;
      function second(cTime: TDateTime): byte;
      function year(cdate: TDateTime): word;
      function aSub(atemp: array of char; nstart, nend: word): string;
      function stringListPos(strList: TStringList; cFind: string; var nindex: word ): boolean;
      function space(nLen:  word): string;
      function sizeofFile(cfile: string): longint;
      function lastDay(datein: TDateTime): byte;  {1.4}
      procedure autoGridLineHeight(gridName: TDrawGrid); {1.5}
      function Occurs( SubString, StringToSearch: string ): integer;

      {2.10 additions}
      function delphiDateToNWDate(delphiDate: TDateTime): longint;
      function NWDateToDelphiDate(NWDate: longint): TDateTime;
      function power(value: longint; exp: integer): longint;
      function NWHexToLong(byteArray: array of byte): longint;
      
      {4.5x additions}
      function strReplace(inString, outText, inText: string): string;
      function fromXChar(value: string; token: char; pos: integer): string;
      
      
   type
   TNWTools = class(TObject)
   end;
      
implementation

{ Left Trim }
function LTrim(ctext: string): string;
var
   nloop: integer;
   ctemp: string;
begin
   ctemp  := '';
   if (length(ctext) > 0) then
   begin
      for nloop := 1 to length(ctext) do begin
         if (ord(ctext[nloop]) <> 32) then
         begin
            ctemp := ctemp + copy(ctext, nloop, length(ctext));
            break;
         end;
      end;
   end;
   result := ctemp;
end;

{ Right Trim }
function RTrim(ctext: string): string;
var
   nloop: integer;
begin
   if (length(ctext) > 0) then
   begin
      for nloop := length(ctext) downto 1 do begin
         if (not (ord(ctext[nloop]) in [0, 1, 2, 32])) then
         begin
            ctext := copy(ctext, 1, nloop);
            break;
         end;
      end;
   end;
   result := ctext;
end;

{ All Trim }
function allTrim(const ctext: string): string;
begin
   result := lTrim(rTrim(ctext));
end;

{ Extract Delimited Field from String }
function strExtract(ctext       : string;
const ctoken: char;
const npos  : integer): string;
var
   nloop: integer;
   ntemp: integer;
begin
   result := allTrim(ctext);
   if (npos > 1) then
   begin
      if ((charCount(ctext, ctoken) + 1) < nPos) then
      begin
         result := '';
         exit;
      end;
      for nloop := 1 to (npos - 1) do begin
         ctext := allTrim(copy(ctext, Pos(ctoken, ctext) + 1, length(ctext)));
         ntemp := pos(ctoken, ctext);
         if (ntemp < 1) then
            break;
      end;
      begin
         ntemp := pos(ctoken, ctext);
         if (ntemp > 0) then
         begin
            if (length(ctext) = 1) then
               result := ''
            else
               result := allTrim(copy(ctext, 1, ntemp - 1));
         end
         else
            result := allTrim(ctext);
      end;
   end
   else if (pos(ctoken, ctext) > 0) then
   begin
      ntemp  := pos(ctoken, ctext);
      result := allTrim(copy(ctext, 1, ntemp - 1));
   end;
end;


{ Count Occurences of Char.Token in String }
function CharCount(const ctext: string; ctoken: char): integer;
var
   nreturn: integer;
   ntemp  : integer;
   nmax   : integer;
begin
   nmax := Length(ctext);
   ctoken := UpCase(ctoken);
   nreturn := 0;
   for ntemp := 1 to nmax do begin
      if upCase(ctext[ntemp]) = ctoken then
         Inc(nreturn);
   end;
   result := nReturn;
end;

function leftString(ctext: string; nlen: integer): string;
begin
   result := copy(ctext, 1, nlen)
end;

function rightString(ctext: string; nlen: integer): string;
var
   ntemp: word;
begin
   result := ctext;
   if (length(ctext) > nlen)  then
   begin
      ntemp := (length(ctext) - nlen) + 1;
      result := copy(ctext, ntemp, nlen);
   end;
end;

{ Fixup Path String }
function setPath(cpath: string): string;
var
   ntemp: integer;
begin
   if (length(cPath) < 1) then
   begin
      result := '\';
      exit;
   end;
   cpath := uppercase(allTrim(cpath));
   ntemp := length(cpath);
   if (cpath[ntemp] = '\') then
      result := cpath
   else
      result := cpath + '\';
end;

function fUnique(cpath: string): string;
{ create a unique file }
var
   cfile   : string;
   ncounter: word  ;
   ctextfile: TextFile;
begin
   ncounter := 1;
   while true do begin
      cfile := SetPath(cpath) +
      copy(intToStr(getTickCount), 2, 7) +
      intToStr(ncounter);
      if (not fileExists(cfile)) then
      begin
         result := cfile;
         assignFile(cTextFile, cfile);
         rewrite(cTextFile);
         closeFile(cTextFile);
         break;
      end;
   end;
end;

function PadL(ctext: string; nlen: integer; cchar: char): string;
var
   creturn: string;
   ntemp: integer;
   nmax : integer;
begin
   creturn := AllTrim(ctext);
   nmax    := nlen;
   dec(nmax, length(creturn));
   if nmax > 0 then
   begin
      for ntemp := 1 to nmax do
         creturn := concat(cchar, creturn);
      result := creturn;
   end
   else
      result := rightString(creturn, nlen);
end;

function padR(ctext: string; nlen: integer; cchar: char): string;
var
   creturn: string;
   ntemp: integer;
   nmax : integer;
begin
   creturn := allTrim(ctext);
   nmax := (nlen - length(creturn));
   if (nmax > 0) then
   begin
      for ntemp := 1 to nmax do
         creturn := concat(creturn, cchar);
   end
   else
      creturn := copy(creturn, 1, nlen);
   result := creturn;
end;

function padC(ctext: string; nlen: integer; cchar: char): string;
var
   creturn: string;
   ntemp: integer;
   nmax : integer;
begin
   creturn := allTrim(ctext);
   nmax := nlen - length(creturn) ;
   if (nmax > 0) then
   begin
      for ntemp := 1 to nmax do begin
         if odd(ntemp) then
            creturn := concat(cchar, creturn)
         else
            creturn := concat(creturn, cchar);
      end;
   end
   else
      result := copy(creturn, 1, nlen);
end;

{ Proper-Case a String }
function proper(ctext: string): string;
var
   ntemp  : integer;
   nmax   : integer;
begin
   ctext    := lowerCase(ctext);
   ctext[1] := upCase(ctext[1]);
   nmax     := length(ctext);
   for ntemp := 2 to nmax do
   begin
      case ctext[ntemp - 1] of
         ' ': ctext[ntemp] := UpCase(ctext[ntemp]);
      end;
   end;
   Result := ctext;
end;

{ InLine Boolean/String processing }
function iif(const lvalue: boolean; cret1, cret2: string): string;
begin
   if lvalue then
      result := cret1
   else
      result := cret2;
end;

{ Empty String? }
function strEmpty(ctext: string): boolean;
begin
   result := false;
   if (length(allTrim(ctext)) > 0) then
      result := true;
end;

{ Standard Yes/No Dialog }
function yesNoBox(ctext: string): boolean;
var
   nCursor: TCursor;
begin
   ctext   := strTran(ctext, ';', #10);
   nCursor := screen.Cursor;
   screen.cursor := crDefault;
   result := (MessageDlg(ctext, mtConfirmation, [mbNo, mbYes], 0) = mrYes);
   screen.cursor := nCursor;
end;

{ Standard No/Yes Dialog }
function noYesBox(ctext: string): boolean;
var
   nCursor: TCursor;
   cptext : PChar;
begin
   ctext   := strTran(ctext, ';', #10);
   nCursor := screen.cursor;
   cptext  := strAlloc(length(ctext) + 1);
   strPCopy(cptext, ctext);
   screen.cursor := crDefault;
   result := (application.messageBox(cptext, 'Confirm', mb_yesNo +
   mb_DefButton2 + mb_iconQuestion) = id_yes);
   strDispose(cptext);
   screen.cursor := nCursor;
end;

{ Standard Yes/No/Cancel Dialog }
function YNCBox(ctext: string): integer;
var
   nCursor: TCursor;
begin
   ctext   := strTran(ctext, ';', #10);
   nCursor := screen.cursor;
   Screen.Cursor := crDefault;
   result := messageDlg(ctext, mtConfirmation, mbYesNoCancel, 0);
   screen.cursor := nCursor;
end;

{ Standard OK Dialog }
procedure okBox(ctext: string);
var
   nCursor: TCursor;
begin
   ctext   := strTran(ctext, ';', #10);
   nCursor := screen.cursor;
   screen.cursor := crDefault;
   messageDlg(ctext, mtInformation, [mbOK], 0);
   screen.cursor := nCursor;
end;

{ Standard Alert Dialog }
procedure alertBox(cText: string);
var
   nCursor: TCursor;
begin
   ctext   := strTran(ctext, ';', #10);
   nCursor := screen.cursor;
   screen.Cursor := crDefault;
   messageDlg(ctext, mtError, [mbCancel], 0);
   screen.cursor := nCursor;
end;

{ Character by Character String Replacement }
function strTran(ctext, cfor, cwith: string): string;
var
   ntemp  : word  ;
   nreplen: word  ;
begin
   cfor    := upperCase(cfor)   ;
   nreplen := length(cfor)      ;
   for ntemp := 1 to length(ctext) do begin
      if (upperCase(copy(ctext, ntemp, nreplen)) = cfor) then
      begin
         delete(ctext, ntemp, nreplen);
         insert(cwith, ctext, ntemp);
      end;
   end;
   result := ctext;
end;

{Value in Range?}
function between(nval, nmin, nmax: longint): boolean;
begin
   result := false;
   if (nval >= nmin) and (nval <= nmax) then
      result := true;
end;

function MaxLong(nVal1, nVal2: LongInt): LongInt;
begin
   result := nVal2;
   if (nVal1 > nVal2) then
      result := nVal1;
end;

function MinLong(nstart, nend: longint): longint;
begin
   result := nend;
   if nstart < nend then
      result := nstart;
end;

function delim2StrList(ctext: string): TStringList;
{ Comma-Delimited String to TStringList }
var
   ntemp: word;
   nloop: word;
begin
   result := TStringList.Create;
   if pos(',', ctext)>0 then
   begin
      ntemp := charCount(ctext, ',') + 1;
      for nloop := 1 to ntemp do
         result.add(allTrim(strExtract(ctext, ',', nloop)));
   end
   else
      result.add(ctext);
end;

{ right 'Pos' function }
function rat(const ctoken: char; const ctext: string): integer;
var
   nloop: integer;
begin
   result := 0;
   for nloop := length(ctext) downto 1 do begin
      if ctext[nloop] = ctoken then
      begin
         result := nloop;
         break;
      end;
   end;
end;

function formDate(cdate: TDateTime): string;
begin
   result := formatDateTime(FormatSettings.longDateFormat, cDate)
end;

function formTime(cdate: TDateTime): string;
begin
   result := formatDateTime('hh:mm a/p', cDate)
end;

function day(cdate: TDateTime): byte;
begin
   result := strToInt(formatDateTime('d', cDate));
end;

function month(cdate: TDateTime): byte;
begin
   result := strToInt(formatDateTime('m', cDate));
end;

function year(cdate: TDateTime): word;
begin
   result := strToInt(FormatDateTime('yyyy', cDate));
end;

function Hour(cTime: TDateTime): byte;
begin
   result := strToInt(FormatDateTime('h', cTime));
end;

function minute(cTime: TDateTime): byte;
begin
   result := strToInt(formatDateTime('n', cTime));
end;

function second(cTime: TDateTime): byte;
begin
   result := strToInt(formatDateTime('s', cTime));
end;

function timeTextInc(ctime: string; nway: integer): string;
{ increment or decrement a hh:mm string }
var
   ttemp: TDateTime;
   nmin : word;
   nhour: word;
   nsec : word;
   nmsec: word;
begin
   ctime := padC(ctime, 5, '0');
   tTemp := strToTime(ctime);
   decodeTime(tTemp, nhour, nmin, nsec, nmsec);
   if nway > 0 then
   begin
      inc(nmin, 15);
      if nmin > 45 then
      begin
         nmin := 0;
         if nhour < 12 then
            inc(nhour)
         else
            nHour := 1;
      end;
   end
   else
   begin
      if nmin = 0 then
      begin
         nmin := 45;
         dec(nhour);
      end
      else
         if nmin < 16 then
         nmin := 0
      else
         dec(nmin, 15);
   end;
   nhour := MaxLong(nhour, 0);
   nhour := MinLong(nHour, 12);
   if nHour = 0 then
      nHour := 12;
   Result := PadL(intToStr(nHour), 2, '0') + ':' +
   PadL(intToStr(nMin), 2, '0')
end;


function datetextInc(cdate: string; nway: integer): string;
{ increment or decrement a mm/dd/yy string }
var
   nmonth : word;
   nday   : word;
   nyear: word;
begin
   if nway > 0 then
   begin
      DecodeDate(strToDate(cdate) + 1, nyear, nmonth, nday);
      Result := intToStr(nmonth) + '/' +
      intToStr(nday) + '/' +
      intToStr(nyear);
   end
   else
   begin
      DecodeDate(strToDate(cdate) - 1, nyear, nmonth, nday);
      Result := intToStr(nmonth) + '/' +
      intToStr(nday) + '/' +
      intToStr(nyear);
   end;
end;

function CanOpen(cfile: string): boolean;
var
   ntemp : integer;
   cpfile: PAnsiChar;
begin
{
   cpfile := StrAlloc(length(cfile) + 1);
   strPCopy(cpfile, cfile);
   ntemp := _lopen(cpfile, of_share_deny_none);
   if ntemp > 0  then
   begin
      Result := True;
      _lclose(ntemp);
   end
   else
      Result := False;
   strDispose(cpFile);
}
end;


function StringListPos(strList: TStringList; cFind: string; var nindex: word ): boolean;
{ Return Full-Text Position in TStringList }
var
   nloop : integer;
   nmax  : integer;
begin
   nmax   := strList.Count;
   Result := False;
   if nmax > 0 then begin
      cfind := UpperCase(cFind);
      for nloop := 1 to nmax do begin
         if Pos(cfind, UpperCase(strList[nloop - 1])) > 0 then
         begin
            nindex := (nloop - 1);
            Result := True;
            break;
         end;
      end;
   end;
end;

function aSub(atemp: array of char; nstart, nend: word): string;
{ Return a Subset of character Array }
var
   ctemp: string;
   nloop: word  ;
begin
   ctemp := '';
   nend := (nstart + nend) - 1;
   for nloop := nstart to nend do begin
      ctemp := ctemp + atemp[nloop];
   end;
   Result := ctemp;
end;

function Space(nLen:  word): string;
{ Return String w/ x number of spaces }
var
   nloop: word;
begin
   Result := '';
   for nloop := 1 to nLen do begin
      Result := concat(Result, ' ');
   end;
end;

function sizeofFile(cfile: string): longint;
{ Return Size of File }
var
   nHandle   : longint;
   cpFileName: array[0..255] of char;
begin
   result := 0;
   if fileExists(cfile) then
   begin
      strPCopy(cpFileName, cfile);
      nHandle := _lopen(@cpfileName, OF_READ);
      if (nHandle > 0) then
         try
            result := _llSeek(nHandle, 0, 2) {eof};
      finally
         _lclose(nHandle);
      end;
   end;
end;

function lastDay(datein: TDateTime): byte;
{return last day of month}
var
   nMon: word;
begin
   nMon := month(datein);
   result := day(datein);
   while true do begin
      datein := (datein + 1);
      if (month(datein) <> nMon) then
         break
      else
         inc(result);
   end;
end;

procedure autoGridLineHeight(gridName: TDrawGrid);
{sets grid line height based on current system font/size}
var
   nFont: TFont;
begin
   nfont := TForm(gridname.owner).font;
   with (gridName as TDrawGrid) do begin
      font.name   := nfont.name ;
      font.style  := nfont.style;
      font.size   := nfont.size ;
      defaultRowHeight :=  round(
      (nfont.size / 72) * screen.pixelsPerInch) +
      trunc(nfont.size * 0.36) + 4 ;
   end;
end;

{novell date/time (syn_time) is the number of seconds since 1/1/1970}
function delphiDateToNWDate(delphiDate: TDateTime): longint;
{3600 secs /hour, 86400 secs/day}
var
   dtemp  : TDateTime;    {note:  uses UNC time CST = - 6 hours}
   addTime: double   ;
begin
   dtemp   := encodeDate(1970, 1, 1);
   result  := (trunc(int(delphiDate)) - trunc(int(dtemp))) * 86400;
   addTime := 86400 * frac(delphiDate);
   result  := result + trunc(int(addTime));
end;

{novell date/time (syn_time) is the number of seconds since 1/1/1970}
function NWDateToDelphiDate(nwDate: longint): TDateTime;
var
   addTime: double;
   addDays: longint;      {note:  uses UNC time CST = - 6 hours}
begin
   addDays := (nwDate div 86400);
   addTime := ((nwDate mod 86400) / 86400);
   result  := encodeDate(1970, 1, 1) + addDays + addTime;
end;

function power(value: longint; exp: integer): longint;
var
   i: integer;
begin
   result := value;
   for i := 1 to exp - 1 do
      result := result * value;
end;

function NWHexToLong(byteArray: array of byte): longint;
{convert low-high array of hex bytes to decimal}
var
   i: integer;
begin
   result := 0;
   if (sizeOf(byteArray) < 1) then
      exit;
   for i := 1 to (sizeOf(byteArray) - 1) do
      result := result + (byteArray[i] * power(256, i));
end;

function strReplace(inString, outText, inText: string): string;
var
   i: integer;
begin
   result  := inString;
   outText := upperCase(outText);
   i := pos(outText, upperCase(inString));
   if (i > 0) then
   begin
      delete(result, i, length(outText));
      insert(inText, result, i);
   end
end;

function fromXChar(value: string; token: char; pos: integer): string;
var
   i,
   count: integer;
begin
   if (charCount(value, token) < pos) then
   begin
      result := '';
      exit;
   end;
   result := value;
   count  := 0;
   for i := 1 to length(value) do begin
      if (value[i] = token) then
         inc(count);
      if (count = pos) then
      begin
         result := copy(value, i + 1, length(value));
         break;
      end;
   end;
end;

function Occurs( SubString, StringToSearch: string ): integer;
begin
   Result := 0;
   while Pos(SubString, StringToSearch) > 0 do begin
      inc( Result );
      Delete( StringToSearch, 1, Pos( SubString, StringToSearch ) + Length( SubString ) -1 );
   end;
end;

end.
