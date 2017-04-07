unit SrvConf;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls,
  Buttons, ComCtrls, XPMan, Mask,
  inifiles, DBCtrlsEh, filectrl,
  OleCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet;

type
  TfSrvCnf = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label24: TLabel;
    oHost1: TEdit;
    oPort1: TEdit;
    oUser1: TEdit;
    oClave1: TEdit;
    oPathRep1: TEdit;
    oBtn_TestCnn1: TBitBtn;
    oNombre1: TEdit;
    TabSheet2: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label25: TLabel;
    oHost2: TEdit;
    oPort2: TEdit;
    oUser2: TEdit;
    oClave2: TEdit;
    oPathRep2: TEdit;
    oBtn_TestCnn2: TBitBtn;
    oNombre2: TEdit;
    TabSheet3: TTabSheet;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    oHost3: TEdit;
    oPort3: TEdit;
    oUser3: TEdit;
    oClave3: TEdit;
    oPathRep3: TEdit;
    oBtn_TestCnn3: TBitBtn;
    oNombre3: TEdit;
    XPManifest1: TXPManifest;
    oLstSrvs: TComboBox;
    oBtn_FindDB1: TBitBtn;
    oLst_Bases1: TDBComboBoxEh;
    oBtn_FindDB2: TBitBtn;
    oLst_Bases2: TDBComboBoxEh;
    oBtn_FindDB3: TBitBtn;
    oLst_Bases3: TDBComboBoxEh;
    oBtn_FindREP1: TBitBtn;
    oBtn_FindREP2: TBitBtn;
    oBtn_FindREP3: TBitBtn;
    obtnCancel: TBitBtn;
    obtnOK: TBitBtn;
    oStatus1: TEdit;
    oStatus2: TEdit;
    oStatus3: TEdit;
    oLTestConnectionResult1: TLabel;
    oLTestConnectionResult2: TLabel;
    oLTestConnectionResult3: TLabel;
    Label23: TLabel;
    oOldNombre1: TEdit;
    oOldNombre2: TEdit;
    oOldNombre3: TEdit;
    oNoServer1: TCheckBox;
    oNoServer2: TCheckBox;
    oNoServer3: TCheckBox;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure Cargar_Valores;
    procedure Blank_Screen;
    procedure oBtn_FindDB1Click(Sender: TObject);
    procedure oBtn_FindDB2Click(Sender: TObject);
    procedure oBtn_FindDB3Click(Sender: TObject);
    function Load_Databases(var oLst_Database: TDBComboBoxEh;
      pTab: integer): boolean;
    function Chek_Nomb_Repetidos: boolean;
    procedure oBtn_FindREP1Click(Sender: TObject);
    procedure oBtn_FindREP2Click(Sender: TObject);
    procedure oBtn_FindREP3Click(Sender: TObject);
    procedure oNombre1Exit(Sender: TObject);
    procedure oNombre2Exit(Sender: TObject);
    procedure oNombre3Exit(Sender: TObject);
    procedure obtnCancelClick(Sender: TObject);
    procedure obtnOKClick(Sender: TObject);
    procedure Asigna_Valores(pIndex: integer);
    function Test_Connection(pTab: integer; bFocusTab: boolean = true): boolean;
    procedure oBtn_TestCnn1Click(Sender: TObject);
    procedure oBtn_TestCnn2Click(Sender: TObject);
    procedure oBtn_TestCnn3Click(Sender: TObject);
    procedure Save_Status(pTab: integer; Status: integer);
    procedure Limpiar_Valores(pOption: integer);
    function ChangeServerName(pServerNumber: integer): boolean;
    procedure oNoServer1Click(Sender: TObject);
    procedure oNoServer2Click(Sender: TObject);
    procedure oNoServer3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SetFocus(pTab: integer);
    function CheckConn: boolean;
  private { Private declarations }
  public
    { Public declarations }
  end;

type
  tInfo = object
    SrvNum: integer;
    SrvNam: string;
    SrvHost: string;
  end;

var
  fSrvCnf: TfSrvCnf;
  MyFlag: boolean;
  oLasSrvConn: tInfo;

implementation
uses utilesV20;
{$R *.dfm}

procedure TfSrvCnf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  utilesV20.bConnectionOk := false;
end;

procedure TfSrvCnf.FormCreate(Sender: TObject);
begin
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  self.oLTestConnectionResult1.Caption := '';
  self.oLTestConnectionResult2.Caption := '';
  self.oLTestConnectionResult3.Caption := '';
  self.Blank_Screen;
  self.Cargar_Valores;
  self.PageControl1.ActivePageIndex := 0;
  MyFlag := false;
  oLasSrvConn.SrvNum := 0;
  oLasSrvConn.SrvNam := '';
  oLasSrvConn.SrvHost := '';
  utilesV20.bConnectionOk := false;
end;

procedure TfSrvCnf.oBtn_FindDB1Click(Sender: TObject);
begin
  self.Load_Databases(self.oLst_Bases1, 1)
end;

procedure TfSrvCnf.oBtn_FindDB2Click(Sender: TObject);
begin
  self.Load_Databases(self.oLst_Bases2, 2)
end;

procedure TfSrvCnf.oBtn_FindDB3Click(Sender: TObject);
begin
  self.Load_Databases(self.oLst_Bases3, 3)
end;

procedure TfSrvCnf.oBtn_FindREP1Click(Sender: TObject);
var
  Carpeta: string;
begin
  if SelectDirectory('Seleccione una carpeta', 'c:\documentos', Carpeta) then
    oPathRep1.Text := (Carpeta);
end;

procedure TfSrvCnf.oBtn_FindREP2Click(Sender: TObject);
var
  Carpeta: string;
begin
  if SelectDirectory('Seleccione una carpeta', 'c:\documentos', Carpeta) then
    oPathRep2.Text := (Carpeta);
end;

procedure TfSrvCnf.oBtn_FindREP3Click(Sender: TObject);
var
  Carpeta: string;
begin
  if SelectDirectory('Seleccione una carpeta', 'c:\documentos', Carpeta) then
    oPathRep3.Text := (Carpeta);
end;

procedure TfSrvCnf.oBtn_TestCnn1Click(Sender: TObject);
begin
  if self.Test_Connection(1) = true then
  begin
    oBtn_FindDB1.Enabled := true;
    oLst_Bases1.Enabled := true;
  end
  else
  begin
    oBtn_FindDB1.Enabled := false;
    oLst_Bases1.Enabled := false;
  end
end;

procedure TfSrvCnf.oBtn_TestCnn2Click(Sender: TObject);
begin
  if self.Test_Connection(2) = true then
  begin
    oBtn_FindDB2.Enabled := true;
    oLst_Bases2.Enabled := true;
  end
  else
  begin
    oBtn_FindDB2.Enabled := false;
    oLst_Bases2.Enabled := false;
  end
end;

procedure TfSrvCnf.oBtn_TestCnn3Click(Sender: TObject);
begin
  if self.Test_Connection(3) = true then
  begin
    oBtn_FindDB3.Enabled := true;
    oLst_Bases3.Enabled := true;
  end
  else
  begin
    oBtn_FindDB3.Enabled := false;
    oLst_Bases3.Enabled := false;
  end
end;

procedure TfSrvCnf.oNombre1Exit(Sender: TObject);
begin
  if self.Chek_Nomb_Repetidos() = true then
    self.oNombre1.SetFocus;
end;

procedure TfSrvCnf.oNombre2Exit(Sender: TObject);
begin
  if self.Chek_Nomb_Repetidos() = true then
    self.oNombre2.SetFocus;
end;

procedure TfSrvCnf.oNombre3Exit(Sender: TObject);
begin
  if self.Chek_Nomb_Repetidos() = true then
    self.oNombre3.SetFocus;
end;

procedure TfSrvCnf.oNoServer1Click(Sender: TObject);
begin
  self.Limpiar_Valores(1);
  self.oBtn_TestCnn1Click(self);
end;

procedure TfSrvCnf.oNoServer2Click(Sender: TObject);
begin
  self.Limpiar_Valores(2);
  self.oBtn_TestCnn2Click(self);
end;

procedure TfSrvCnf.oNoServer3Click(Sender: TObject);
begin
  self.Limpiar_Valores(3);
  self.oBtn_TestCnn3Click(self);
end;

function TfSrvCnf.ChangeServerName(pServerNumber: integer): boolean;
var
  sPath: string;
  sPass: string;
begin
  sPath := ExtractFilePath(ParamStr(0)) + 'Data\Config.ini';
  oFile := Tinifile.Create(sPath);
  case pServerNumber of
    1:
      begin
        if trim(self.oOldNombre1.Text) <> trim(self.oNombre1.Text) then
        begin
          oFile.EraseSection(trim(self.oOldNombre1.Text));
          oFile.writeString('servidores', 'Configuracion1',
            trim(self.oNombre1.Text));
        end;
      end;
    2:
      begin
        if trim(self.oOldNombre2.Text) <> trim(self.oNombre2.Text) then
        begin
          oFile.EraseSection(trim(self.oOldNombre2.Text));
          oFile.writeString('servidores', 'Configuracion2',
            trim(self.oNombre2.Text));
        end;
      end;
    3:
      begin
        if trim(self.oOldNombre3.Text) <> trim(self.oNombre3.Text) then
        begin
          oFile.EraseSection(trim(self.oOldNombre3.Text));
          oFile.writeString('servidores', 'Configuracion3',
            trim(self.oNombre3.Text));
        end;
      end;
  end;
  oFile.Free;
end;

procedure TfSrvCnf.Limpiar_Valores(pOption: integer);
begin
  if pOption = 1 then
  begin
    self.oNombre1.Text := 'No definido 1';
    self.oHost1.Text := '';
    self.oPort1.Text := '0';
    self.oLst_Bases1.Value := '';
    self.oUser1.Text := '';
    self.oClave1.Text := '';
    self.oPathRep1.Text := '';
    self.oStatus1.Text := 'Conexión fallida!';
    self.oLTestConnectionResult1.Caption := '';
  end;

  if pOption = 2 then
  begin
    self.oNombre2.Text := 'No definido 2';
    self.oHost2.Text := '';
    self.oPort2.Text := '0';
    self.oLst_Bases2.Value := '';
    self.oUser2.Text := '';
    self.oClave2.Text := '';
    self.oPathRep2.Text := '';
    self.oStatus2.Text := 'Conexión fallida!';
    self.oLTestConnectionResult2.Caption := '';
  end;

  if pOption = 3 then
  begin
    self.oNombre3.Text := 'No definido 3';
    self.oHost3.Text := '';
    self.oPort3.Text := '0';
    self.oLst_Bases3.Value := '';
    self.oUser3.Text := '';
    self.oClave3.Text := '';
    self.oPathRep3.Text := '';
    self.oStatus3.Text := 'Conexión fallida!';
    self.oLTestConnectionResult3.Caption := '';
  end;
end;

procedure TfSrvCnf.Cargar_Valores;
var
  i: integer;
  j: Word;
  iCnt: integer;
begin
  oLstSrvs.Clear;

  futilesV20.CargarServidores(oLstSrvs);

  iCnt := oLstSrvs.Items.Count;
  if iCnt = 0 then
  begin
    self.Blank_Screen();
    exit;
  end;

  oLstSrvs.ItemIndex := 0;
  futilesV20.GetSetting2(trim(UpperCase(oLstSrvs.Text)));
  if oSetting_Fac.nombre = 'SinNombre' then
    oSetting_Fac.nombre := 'SinNombre1';

  self.oNombre1.Text := oSetting_Fac.nombre;
  self.oOldNombre1.Text := oSetting_Fac.nombre;
  self.oHost1.Text := oSetting_Fac.host;
  self.oPort1.Text := inttostr(oSetting_Fac.puerto);
  self.oLst_Bases1.Value := oSetting_Fac.database;
  self.oUser1.Text := oSetting_Fac.usuario;
  self.oClave1.Text := oSetting_Fac.clave;
  self.oPathRep1.Text := oSetting_Fac.reportes;
  self.oStatus1.Text := oSetting_Fac.estado;

  oLstSrvs.ItemIndex := 1;
  futilesV20.GetSetting2(trim(UpperCase(oLstSrvs.Text)));
  if oSetting_Fac.nombre = 'SinNombre' then
    oSetting_Fac.nombre := 'SinNombre2';

  self.oNombre2.Text := oSetting_Fac.nombre;
  self.oOldNombre2.Text := oSetting_Fac.nombre;
  self.oHost2.Text := oSetting_Fac.host;
  self.oPort2.Text := inttostr(oSetting_Fac.puerto);
  self.oLst_Bases2.Value := oSetting_Fac.database;
  self.oUser2.Text := oSetting_Fac.usuario;
  self.oClave2.Text := oSetting_Fac.clave;
  self.oPathRep2.Text := oSetting_Fac.reportes;
  self.oStatus2.Text := oSetting_Fac.estado;

  oLstSrvs.ItemIndex := 2;
  futilesV20.GetSetting2(trim(UpperCase(oLstSrvs.Text)));
  if oSetting_Fac.nombre = 'SinNombre' then
    oSetting_Fac.nombre := 'SinNombre3';

  self.oNombre3.Text := oSetting_Fac.nombre;
  self.oOldNombre3.Text := oSetting_Fac.nombre;
  self.oHost3.Text := oSetting_Fac.host;
  self.oPort3.Text := inttostr(oSetting_Fac.puerto);
  self.oLst_Bases3.Value := oSetting_Fac.database;
  self.oUser3.Text := oSetting_Fac.usuario;
  self.oClave3.Text := oSetting_Fac.clave;
  self.oPathRep3.Text := oSetting_Fac.reportes;
  self.oStatus3.Text := oSetting_Fac.estado;
end;

procedure TfSrvCnf.obtnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfSrvCnf.obtnOKClick(Sender: TObject);
begin
  oLstSrvs.ItemIndex := 0;
  self.Asigna_Valores(1);
  self.ChangeServerName(1);
  futilesV20.SaveSetting2(trim(self.oNombre1.Text));

  oLstSrvs.ItemIndex := 1;
  self.Asigna_Valores(2);
  self.ChangeServerName(2);
  futilesV20.SaveSetting2(trim(self.oNombre2.Text));

  oLstSrvs.ItemIndex := 2;
  self.Asigna_Valores(3);
  self.ChangeServerName(3);
  futilesV20.SaveSetting2(trim(self.oNombre3.Text));
  close;
end;

function TfSrvCnf.CheckConn: boolean;
var
  iCnnOk: integer;
begin
  iCnnOk := 0;
  self.StatusBar1.Panels[0].Text := '';
  if oLasSrvConn.SrvNum = 0 then
  begin
    if utilesV20.bConnectionOk = false then
    begin
      if self.Test_Connection(1, false) = true then
      begin
        inc(iCnnOk);
        self.StatusBar1.Panels[0].Text := 'Conectado a [' +
          trim(oLasSrvConn.SrvNam) + '/' + trim(oLasSrvConn.SrvHost) + ']...';
        Result := true;
      end
      else
      begin
        if utilesV20.bConnectionOk = false then
        begin
          if self.Test_Connection(2, false) = true then
          begin
            inc(iCnnOk);
            self.StatusBar1.Panels[0].Text := 'Conectado a [' +
              trim(oLasSrvConn.SrvNam) + '/' +
              trim(oLasSrvConn.SrvHost) + ']...';
            Result := true;
          end
          else
          begin
            if utilesV20.bConnectionOk = false then
            begin
              if self.Test_Connection(3, false) = true then
              begin
                inc(iCnnOk);
                self.StatusBar1.Panels[0].Text := 'Conectado a [' +
                  trim(oLasSrvConn.SrvNam) + '/' +
                  trim(oLasSrvConn.SrvHost) + ']...';
                Result := true;
              end;
            end;
          end;
        end;
      end;
    end;
  end
  else
  begin
    if self.Test_Connection(oLasSrvConn.SrvNum, false) = true then
    begin
      inc(iCnnOk);
      self.StatusBar1.Panels[0].Text := 'Conectado a [' +
        trim(oLasSrvConn.SrvNam) + '/' + trim(oLasSrvConn.SrvHost) + ']...';
      Result := true;
    end;
  end;
  futilesV20.WaitEnd;
  if iCnnOk = 0 then
  begin
    MessageDlg('No hay ninguna conexión disponible para realizar este proceso.',
      mtInformation, [mbOK], 0);
    self.StatusBar1.Panels[0].Text := '';
    Result := false;
    exit;
  end;
end;

procedure TfSrvCnf.Blank_Screen;
var
  i: Word;
begin
  for i := 0 to self.ComponentCount - 1 do
  begin
    if (self.Components[i] is TDBEdit) then
      TDBEdit(self.Components[i]).Text := '';
    if (self.Components[i] is TComboBox) then
      TDbComboBox(self.Components[i]).ItemIndex := 0;
  end;
end;

function TfSrvCnf.Load_Databases(var oLst_Database: TDBComboBoxEh;
  pTab: integer): boolean;
var
  oConn: TFDConnection;
  oQuery: TFDQuery;
  iChoice: integer;
begin
  with utilesV20.oSetting_Fac do
  begin
    case pTab of
      1:
        begin
          nombre := trim(self.oNombre1.Text);
          host := trim(self.oHost1.Text);
          puerto := strtoint(self.oPort1.Text);
          usuario := trim(self.oUser1.Text);
          clave := trim(self.oClave1.Text);
          database := trim(self.oLst_Bases1.Value);
        end;
      2:
        begin
          nombre := trim(self.oNombre2.Text);
          host := trim(self.oHost2.Text);
          puerto := strtoint(self.oPort2.Text);
          usuario := trim(self.oUser2.Text);
          clave := trim(self.oClave2.Text);
          database := trim(self.oLst_Bases2.Value);
        end;
      3:
        begin
          nombre := trim(self.oNombre3.Text);
          host := trim(self.oHost3.Text);
          puerto := strtoint(self.oPort3.Text);
          usuario := trim(self.oUser3.Text);
          clave := trim(self.oClave3.Text);
          database := trim(self.oLst_Bases3.Value);
        end;
    end;
  end;
  oConn := TFDConnection.Create(nil);
  oQuery := TFDQuery.Create(nil);
  try
    oConn.Params.Clear;
    oConn.Params.Add('DriverID=MySQL');
    oConn.Params.Add('Server=' + oSetting_Fac.host);
    oConn.Params.Add('Database=' + oSetting_Fac.database);
    oConn.Params.Add('CharacterSet=utf8');
    oConn.Params.Add('User_Name=' + oSetting_Fac.usuario);
    oConn.Params.Add('Password=' + oSetting_Fac.clave);
    oConn.Params.Add('MetaDefCatalog=' + oSetting_Fac.database);
    oConn.Params.Add('MetaCurCatalog=' + oSetting_Fac.database);
    oConn.Params.Add('Port=' + inttostr(oSetting_Fac.puerto));
    oConn.LoginPrompt := false;
    oConn.Connected := true;
    utilesV20.bConnectionOk := oConn.Connected;
  except
    utilesV20.bConnectionOk := false;
  end;
  if (utilesV20.bConnectionOk = true) then
  begin;

    oQuery.connection := oConn;
    oQuery.sql.Text := 'SHOW DATABASES';
    oQuery.open;

    oLst_Database.Clear;
    oLst_Database.KeyItems.Clear;
    oLst_Database.Items.Clear;

    while not oQuery.Eof do
    begin
      oLst_Database.KeyItems.Add(oQuery.FieldByName('Database').Text);
      oLst_Database.Items.Add(oQuery.FieldByName('Database').Text);
      oQuery.Next;
    end;
    self.Save_Status(pTab, 1);
    // oLst_Database.ItemIndex:=0;
  end
  else
  begin
    oLst_Database.Clear;
    oLst_Database.KeyItems.Clear;
    oLst_Database.Items.Clear;
    oLst_Database.Items.Add('NO HAY CONEXION CON LA BASE DE  DATOS:..');
    // oLst_Database.ItemIndex := 0;
    self.Save_Status(pTab, 2);
  end;
  oConn.Free;
end;

function TfSrvCnf.Test_Connection(pTab: integer;
  bFocusTab: boolean = true): boolean;
var
  oConn: TFDConnection;
  oQuery: TFDQuery;
  iChoice: integer;
begin
  with utilesV20.oSetting_Fac do
  begin
    case pTab of
      1:
        begin
          nombre := trim(self.oNombre1.Text);
          host := trim(self.oHost1.Text);
          puerto := strtoint(self.oPort1.Text);
          usuario := trim(self.oUser1.Text);
          clave := trim(self.oClave1.Text);
          database := trim(self.oLst_Bases1.Value);
          estado := trim(self.oStatus1.Text);
        end;
      2:
        begin
          nombre := trim(self.oNombre2.Text);
          host := trim(self.oHost2.Text);
          puerto := strtoint(self.oPort2.Text);
          usuario := trim(self.oUser2.Text);
          clave := trim(self.oClave2.Text);
          database := trim(self.oLst_Bases2.Value);
          estado := trim(self.oStatus2.Text);
        end;
      3:
        begin
          nombre := trim(self.oNombre3.Text);
          host := trim(self.oHost3.Text);
          puerto := strtoint(self.oPort3.Text);
          usuario := trim(self.oUser3.Text);
          clave := trim(self.oClave3.Text);
          database := trim(self.oLst_Bases3.Value);
          estado := trim(self.oStatus3.Text);
        end;
    end;
  end;

  oConn := TFDConnection.Create(nil);
  oQuery := TFDQuery.Create(nil);
  try
    oConn.Params.Clear;
    oConn.Params.Add('DriverID=MySQL');
    oConn.Params.Add('Server=' + oSetting_Fac.host);
    oConn.Params.Add('Database=' + oSetting_Fac.database);
    oConn.Params.Add('CharacterSet=utf8');
    oConn.Params.Add('User_Name=' + oSetting_Fac.usuario);
    oConn.Params.Add('Password=' + oSetting_Fac.clave);
    oConn.Params.Add('MetaDefCatalog=' + oSetting_Fac.database);
    oConn.Params.Add('MetaCurCatalog=' + oSetting_Fac.database);
    oConn.Params.Add('Port=' + inttostr(oSetting_Fac.puerto));
    oConn.LoginPrompt := false;

    if ((futilesV20.isEmpty(oSetting_Fac.host) = true) or
      (futilesV20.isEmpty(oSetting_Fac.usuario) = true) or
      (oSetting_Fac.puerto <= 0)) then
    begin
      utilesV20.bConnectionOk := false;
      self.Save_Status(pTab, 2);
      if bFocusTab = true then
        self.SetFocus(pTab);
      Result := utilesV20.bConnectionOk;
      exit;
    end;

    oConn.Connected := true;
    utilesV20.bConnectionOk := oConn.Connected;
    if utilesV20.bConnectionOk = true then
    begin
      if bFocusTab = true then
        self.Save_Status(pTab, 1);
      oLasSrvConn.SrvNum := pTab;
      oLasSrvConn.SrvNam := trim(utilesV20.oSetting_Fac.nombre);
      oLasSrvConn.SrvHost := trim(utilesV20.oSetting_Fac.host);
      self.StatusBar1.Panels[0].Text := 'Conectado a [' +
        trim(oLasSrvConn.SrvNam) + '/' + trim(oLasSrvConn.SrvHost) + ']...';
    end
    else
    begin
      if bFocusTab = true then
        self.Save_Status(pTab, 2)
    end;
  except
    begin
      utilesV20.bConnectionOk := false;
      self.Save_Status(pTab, 2);
    end;
  end;
  Result := oConn.Connected;
  oConn.Free;
end;

procedure TfSrvCnf.SetFocus(pTab: integer);
begin
  case pTab of
    1:
      begin
        if (futilesV20.isEmpty(trim(self.oHost1.Text)) = true) then
        begin
          self.oHost1.SetFocus;
        end;
        if (futilesV20.isEmpty(trim(self.oUser1.Text)) = true) then
        begin
          self.oUser1.SetFocus;
        end;
        if (strtoint(self.oPort1.Text) <= 0) then
        begin
          self.oPort1.SetFocus;
        end;
      end;
    2:
      begin
        if (futilesV20.isEmpty(trim(self.oHost2.Text)) = true) then
        begin
          self.oHost2.SetFocus;
        end;
        if (futilesV20.isEmpty(trim(self.oUser2.Text)) = true) then
        begin
          self.oUser2.SetFocus;
        end;
        if (strtoint(self.oPort2.Text) <= 0) then
        begin
          self.oPort2.SetFocus;
        end;
      end;
    3:
      begin
        if (futilesV20.isEmpty(trim(self.oHost3.Text)) = true) then
        begin
          self.oHost3.SetFocus;
        end;
        if (futilesV20.isEmpty(trim(self.oUser3.Text)) = true) then
        begin
          self.oUser3.SetFocus;
        end;
        if (strtoint(self.oPort3.Text) <= 0) then
        begin
          self.oPort3.SetFocus;
        end;
      end;
  end;
end;

procedure TfSrvCnf.Save_Status(pTab: integer; Status: integer);
var
  resp1: string;
  resp2: string;
begin
  case pTab of
    1:
      begin
        if Status = 1 then
          resp1 := 'Conexión Exitosa!!!!'
        else
          resp1 := ' ';
        if Status = 1 then
          resp2 := 'Conexión Exitosa!!!!'
        else
          resp2 := 'Conexión fallida!';
        utilesV20.oSetting_Fac.estado := resp1;
        self.oStatus1.Text := resp2;
        self.oLTestConnectionResult1.Caption := resp2;
        self.oLTestConnectionResult1.Font.Color :=
          futilesV20.iif(Status = 1, clGreen, clRed);
      end;
    2:
      begin
        if Status = 1 then
          resp1 := 'Conexión Exitosa!!!!'
        else
          resp1 := ' ';
        if Status = 1 then
          resp2 := 'Conexión Exitosa!!!!'
        else
          resp2 := 'Conexión fallida!';
        utilesV20.oSetting_Fac.estado := resp1;
        self.oStatus2.Text := resp2;
        self.oLTestConnectionResult2.Caption := resp2;
        self.oLTestConnectionResult2.Font.Color :=
          futilesV20.iif(Status = 1, clGreen, clRed);
      end;
    3:
      begin
        if Status = 1 then
          resp1 := 'Conexión Exitosa!!!!'
        else
          resp1 := ' ';
        if Status = 1 then
          resp2 := 'Conexión Exitosa!!!!'
        else
          resp2 := 'Conexión fallida!';
        utilesV20.oSetting_Fac.estado := resp1;
        self.oStatus3.Text := resp2;
        self.oLTestConnectionResult3.Caption := resp2;
        self.oLTestConnectionResult3.Font.Color :=
          futilesV20.iif(Status = 1, clGreen, clRed);
      end;
  end;
end;

function TfSrvCnf.Chek_Nomb_Repetidos: boolean;
var
  i, j: integer;
  a1, a2: array [1 .. 3] of string;
  iCnt: integer;
begin
  a1[1] := oNombre1.Text;
  a1[2] := oNombre2.Text;
  a1[3] := oNombre3.Text;
  iCnt := 0;
  for i := 1 to High(a1) do
  begin
    for j := 1 to High(a1) do
    begin
      if (((a1[i] = a1[j]) and (i <> j))) then
      begin
        a2[i] := a1[i];
        iCnt := iCnt + 1
      end;
    end;
  end;
  if (iCnt > 0) then
  begin
    Messagebox(0, 'Nombre de conexión duplicado', 'Precausión', 0);
    Result := true;
  end
  else
    Result := false;
end;

procedure TfSrvCnf.Asigna_Valores(pIndex: integer);
begin
  case pIndex of
    1:
      begin
        utilesV20.oSetting_Fac.nombre := trim(self.oNombre1.Text);
        utilesV20.oSetting_Fac.host := trim(self.oHost1.Text);
        utilesV20.oSetting_Fac.puerto := strtoint(self.oPort1.Text);
        utilesV20.oSetting_Fac.database := trim(self.oLst_Bases1.Value);
        utilesV20.oSetting_Fac.usuario := trim(self.oUser1.Text);
        utilesV20.oSetting_Fac.clave := trim(self.oClave1.Text);
        utilesV20.oSetting_Fac.reportes := trim(self.oPathRep1.Text);
        utilesV20.oSetting_Fac.estado := trim(self.oStatus1.Text);
      end;
    2:
      begin
        utilesV20.oSetting_Fac.nombre := trim(self.oNombre2.Text);
        utilesV20.oSetting_Fac.host := trim(self.oHost2.Text);
        utilesV20.oSetting_Fac.puerto := strtoint(self.oPort2.Text);
        utilesV20.oSetting_Fac.database := trim(self.oLst_Bases2.Value);
        utilesV20.oSetting_Fac.usuario := trim(self.oUser2.Text);
        utilesV20.oSetting_Fac.clave := trim(self.oClave2.Text);
        utilesV20.oSetting_Fac.reportes := trim(self.oPathRep2.Text);
        utilesV20.oSetting_Fac.estado := trim(self.oStatus2.Text);
      end;
    3:
      begin
        utilesV20.oSetting_Fac.nombre := trim(self.oNombre3.Text);
        utilesV20.oSetting_Fac.host := trim(self.oHost3.Text);
        utilesV20.oSetting_Fac.puerto := strtoint(self.oPort3.Text);
        utilesV20.oSetting_Fac.database := trim(self.oLst_Bases3.Value);
        utilesV20.oSetting_Fac.usuario := trim(self.oUser3.Text);
        utilesV20.oSetting_Fac.clave := trim(self.oClave3.Text);
        utilesV20.oSetting_Fac.reportes := trim(self.oPathRep3.Text);
        utilesV20.oSetting_Fac.estado := trim(self.oStatus3.Text);
      end;

  end;
end;

end.
