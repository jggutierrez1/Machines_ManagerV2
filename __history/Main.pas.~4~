unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ToolWin, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  XPMan, Vcl.Imaging.jpeg, math;

type
  TfMain = class(TForm)
    MainMenu1: TMainMenu;
    Mantenimientos1: TMenuItem;
    Operaciones1: TMenuItem;
    Configuacin1: TMenuItem;
    Configuracin1: TMenuItem;
    Ayuda1: TMenuItem;
    Salir1: TMenuItem;
    Empresas1: TMenuItem;
    Clientes1: TMenuItem;
    Municipios1: TMenuItem;
    cHAPAS1: TMenuItem;
    Denominaciones1: TMenuItem;
    Asinacin1: TMenuItem;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Usuarios1: TMenuItem;
    FacturasJCJ1: TMenuItem;
    N5: TMenuItem;
    JCJ2: TMenuItem;
    N8: TMenuItem;
    OperacionesporFecha1: TMenuItem;
    Seguridad1: TMenuItem;
    Acceso1: TMenuItem;
    Privilegios1: TMenuItem;
    N10: TMenuItem;
    Acercade1: TMenuItem;
    StatusBar1: TStatusBar;
    Respaldos2: TMenuItem;
    Crearcopiadeseguridad1: TMenuItem;
    Rutas1: TMenuItem;
    Adelantos1: TMenuItem;
    Premios1: TMenuItem;
    N7: TMenuItem;
    Premios2: TMenuItem;
    N6: TMenuItem;
    N9: TMenuItem;
    c1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure Acercade1Click(Sender: TObject);
    procedure Empresas1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Municipios1Click(Sender: TObject);
    procedure Rutas1Click(Sender: TObject);
    procedure cHAPAS1Click(Sender: TObject);
    procedure Denominaciones1Click(Sender: TObject);
    procedure Asinacin1Click(Sender: TObject);
    procedure Usuarios1Click(Sender: TObject);
    procedure FacturasJCJ1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    function CropRect(const Dest: TRect; SrcWidth, SrcHeight: Integer): TRect;
    procedure JCJ2Click(Sender: TObject);
    procedure Adelantos1Click(Sender: TObject);
    procedure Premios1Click(Sender: TObject);
    procedure OperacionesporFecha1Click(Sender: TObject);
    procedure Premios2Click(Sender: TObject);
    procedure Crearcopiadeseguridad1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure c1Click(Sender: TObject);
  private
    { Private declarations }
    FGraphic: TGraphic;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

uses
  acceso, About, Empresa, UtilesV20, Clientes, Municipios, Rutas, Maquinas,
  Denominaciones, AsigMaq, usuarios, Mant_Adelantos, Mant_Premios, Captura1,
  RepJCJ_1, ReporteAdelantos, ReportePremios, Base64, claves_automaticas;
{$R *.dfm}

// Database_Backup_Restore,
procedure TfMain.Acercade1Click(Sender: TObject);
var
  fAbout: TForm;
begin
  Application.CreateForm(TfAbout, fAbout);
  fAbout.showmodal;
  freeandnil(fAbout);
end;

procedure TfMain.Adelantos1Click(Sender: TObject);
begin
  Application.CreateForm(TfMant_Adelantos, fMant_Adelantos);
  fMant_Adelantos.showmodal;
  freeandnil(fMant_Adelantos);
end;

procedure TfMain.Asinacin1Click(Sender: TObject);
begin
  Application.CreateForm(TfAsigMaq, fAsigMaq);
  fAsigMaq.showmodal;
  freeandnil(fAsigMaq);
end;

procedure TfMain.c1Click(Sender: TObject);
begin
  if (UtilesV20.Is_Super_User() = false) then
  begin
    MessageDlg('Acceso restringido a esta sección.', mtConfirmation, [mbOk], 0);
    exit;
  end;

  Application.CreateForm(Tfclaves_automaticas, fclaves_automaticas);
  fclaves_automaticas.showmodal;
  freeandnil(fclaves_automaticas);
end;

procedure TfMain.cHAPAS1Click(Sender: TObject);
begin
  Application.CreateForm(TfMaquinas, fMaquinas);
  fMaquinas.showmodal;
  freeandnil(fMaquinas);
end;

procedure TfMain.Clientes1Click(Sender: TObject);
begin
  Application.CreateForm(TfClientes, fClientes);
  fClientes.showmodal;
  freeandnil(fClientes);
end;

procedure TfMain.Denominaciones1Click(Sender: TObject);
begin
  Application.CreateForm(TfDenom, fDenom);
  fDenom.showmodal;
  freeandnil(fDenom);
end;

procedure TfMain.Empresas1Click(Sender: TObject);
begin
  Application.CreateForm(TfEmpresa, fEmpresa);
  fEmpresa.showmodal;
  freeandnil(fEmpresa);
end;

procedure TfMain.FacturasJCJ1Click(Sender: TObject);
begin
  Application.CreateForm(TfCaptura1, fCaptura1);
  fCaptura1.showmodal;
  fCaptura1.free;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FGraphic.free;
  fUtilesV20.close;
  fUtilesV20.free;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  fUtilesV20.Visible := false;
  Application.CreateForm(Tfacceso, facceso);
  facceso.showmodal;
  if (acceso.iPassOk = false) then
  begin
    facceso.free;
    Application.Terminate;
  end
  else
  begin
    self.StatusBar1.Panels[0].Text := 'Usuario: ' + UtilesV20.sUserName;
    self.StatusBar1.Panels[1].Text := 'Fecha: ' + formatDateTime('dd/mm/yyyy', now());
    self.StatusBar1.Panels[2].Text := 'Empresa: ' + facceso.oLst_emp.Text;
    self.StatusBar1.Panels[3].Text := 'Servidor: ' + fUtilesV20.oPublicCnn.Params.Values['Server'] + '/' +
      fUtilesV20.oPublicCnn.Params.Values['Database'];
    facceso.free;
  end;

  FGraphic := TJPEGImage.Create;
  FGraphic.LoadFromFile(ExtractFilePath(ParamStr(0)) + '/Img_Backg.jpg');
  fUtilesV20.Visible := false;
end;

procedure TfMain.FormPaint(Sender: TObject);
var
  R: TRect;
begin
  R := CropRect(ClientRect, FGraphic.Width, FGraphic.Height);
  Canvas.StretchDraw(R, FGraphic);
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
  FormatSettings.CurrencyDecimals := 2;
  FormatSettings.DateSeparator := '/';
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FormatSettings.LongDateFormat := 'dd/mm/yyyy';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.TimeAMString := 'AM';
  FormatSettings.TimePMString := 'PM';
  FormatSettings.ShortTimeFormat := 'hh:nn';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';
  FormatSettings.CurrencyString := '$';
end;

procedure TfMain.JCJ2Click(Sender: TObject);
begin
  Application.CreateForm(TFRepJCJ_1, FRepJCJ_1);
  FRepJCJ_1.showmodal;
  freeandnil(FRepJCJ_1);
end;

procedure TfMain.Municipios1Click(Sender: TObject);
begin
  Application.CreateForm(TfMunicipios, fMunicipios);
  fMunicipios.showmodal;
  freeandnil(fMunicipios);
end;

procedure TfMain.OperacionesporFecha1Click(Sender: TObject);
begin
  Application.CreateForm(TfReporteAdelantos, fReporteAdelantos);
  fReporteAdelantos.showmodal;
  freeandnil(fReporteAdelantos);
end;

procedure TfMain.Premios1Click(Sender: TObject);
begin
  Application.CreateForm(TfMant_Premios, fMant_Premios);
  fMant_Premios.showmodal;
  freeandnil(fMant_Premios);
end;

procedure TfMain.Premios2Click(Sender: TObject);
begin
  Application.CreateForm(TfReportePremios, fReportePremios);
  fReportePremios.showmodal;
  freeandnil(fReportePremios);
end;

procedure TfMain.Rutas1Click(Sender: TObject);
begin
  Application.CreateForm(TfRutas, fRutas);
  fRutas.showmodal;
  freeandnil(fRutas);
end;

procedure TfMain.Salir1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfMain.Usuarios1Click(Sender: TObject);
begin
  if (trim(UtilesV20.sUserName) <> 'ADMIN') and (trim(UtilesV20.sUserName) <> 'SUPER') then
  begin
    MessageDlg('Usuario no tiene acceso a esta opción.', mtWarning, [mbOk], 0);
    exit;
  end;
  Application.CreateForm(TFusuarios, Fusuarios);
  Fusuarios.showmodal;
  freeandnil(Fusuarios);
end;

procedure TfMain.Crearcopiadeseguridad1Click(Sender: TObject);
begin
  {
    Application.CreateForm(TfDatabase_Backup_Restore, fDatabase_Backup_Restore);
    fDatabase_Backup_Restore.showmodal;
    freeandnil(fDatabase_Backup_Restore);
  }
end;

function TfMain.CropRect(const Dest: TRect; SrcWidth, SrcHeight: Integer): TRect;
var
  W: Integer;
  H: Integer;
  Scale: Single;
  X, Y, Z: Integer;
begin
  W := Dest.Right - Dest.Left;
  H := Dest.Bottom - Dest.Top;
  Scale := Max(W / SrcWidth, H / SrcHeight);
  X := (W - Round(SrcWidth * Scale)) div 2;
  Y := (H - Round(SrcHeight * Scale)) div 2;
  with Dest do
    Result := Rect((Left + X), (Top + Y), (Right - X), (Bottom - Y));
end;

end.
