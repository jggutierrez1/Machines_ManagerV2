program MManager;

uses
  Vcl.Forms,
  Main in 'Main.pas' {fMain},
  SplashForm in 'SplashForm.pas' {TSplashForm},
  SplashForm2 in 'SplashForm2.pas' {TSplashForm2},
  sndkey32 in 'sndkey32.pas',
  About in 'About.pas' {fAbout},
  Nwtools in 'Nwtools.pas',
  NetworkFunctions in 'NetworkFunctions.pas',
  BuscarGenM2 in 'BuscarGenM2.pas' {FBuscarGenM2},
  TecladoGen1 in 'TecladoGen1.pas' {fTecladoGen1},
  TecladoGen2 in 'TecladoGen2.pas' {fTecladoGen2},
  AdjustGrid in 'AdjustGrid.pas',
  AdjustGridEh in 'AdjustGridEh.pas',
  acceso in 'acceso.pas' {Facceso},
  Clientes in 'Clientes.pas' {fClientes},
  Municipios in 'Municipios.pas' {fMunicipios},
  Rutas in 'Rutas.pas' {fRutas},
  Maquinas in 'Maquinas.pas' {fMaquinas},
  Denominaciones in 'Denominaciones.pas' {fDenom},
  AsigMaq in 'AsigMaq.pas' {fAsigMaq},
  usuarios in 'usuarios.pas' {Fusuarios},
  Captura1 in 'Captura1.pas' {fCaptura1},
  Captura2 in 'Captura2.pas' {fCaptura2},
  UTEval in 'UTEval.pas',
  RepJCJ_1 in 'RepJCJ_1.pas' {FRepJCJ_1},
  Reportes in 'Reportes.pas',
  Empresa in 'Empresa.pas' {fEmpresa},
  Mant_Adelantos in 'Mant_Adelantos.pas' {fMant_Adelantos},
  Mant_Premios in 'Mant_Premios.pas' {fMant_Premios},
  ReporteAdelantos in 'ReporteAdelantos.pas' {fReporteAdelantos},
  ReportePremios in 'ReportePremios.pas' {fReportePremios},
  Base64 in 'Base64.pas',
  UtilesV20 in 'UtilesV20.pas' {fUtilesV20},
  acceso1 in 'acceso1.pas' {facceso1},
  claves_automaticas in 'claves_automaticas.pas' {fclaves_automaticas};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfUtilesV20, fUtilesV20);
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
