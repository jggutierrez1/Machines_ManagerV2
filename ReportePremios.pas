unit ReportePremios;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB,
  StdCtrls, Buttons, Mask, DBCtrlsEh,
  XPMan, ComCtrls, ExtCtrls,
  frxClass, frxDBSet, ShellApi,
  frxDesgn, frxExportPDF, frxRich, frxChart,
  frxDMPExport, frxBarcode, ADODB;

type
  TfReportePremios = class(TForm)
    oBtn_Preview: TBitBtn;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    oFecha01: TDBDateTimeEditEh;
    Label4: TLabel;
    oFecha02: TDBDateTimeEditEh;
    oBtn_Print: TBitBtn;
    oBtn_Salir: TBitBtn;
    oSqlStr: TMemo;
    Label5: TLabel;
    oChapa: TEdit;
    oFecha2: TDateTimePicker;
    oFecha1: TDateTimePicker;
    Label10: TLabel;
    Label9: TLabel;
    oBtn_PDF: TBitBtn;
    frxReport1: TfrxReport;
    procedure FormCreate(Sender: TObject);
    procedure oFecha02Exit(Sender: TObject);
    procedure Make_Reporte(sSqlFac: string; iOptcion: integer);
    procedure Print_Report(iOptcion: integer);
    procedure oBtn_CloseClick(Sender: TObject);
    procedure oBtn_PreviewClick(Sender: TObject);
    procedure oBtn_PrintClick(Sender: TObject);
    procedure oBtn_SalirClick(Sender: TObject);
    procedure oBtn_DesignClick(Sender: TObject);
    procedure oBtn_PreviewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure oFecha01Exit(Sender: TObject);
    procedure oBtn_PDFClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fReportePremios: TfReportePremios;
  sFecha1: string;
  sFecha2: string;

  sFechaRep1: string;
  sFechaRep2: string;
  sFiltro_Cte: string;
  bSwitchPrev: boolean;
  bPrintToFile: boolean;
  cFilePDF: string;
  cDB_file: string;
  nRep_Option: integer;

implementation

uses utilesV20, BuscargenM2, edita_reporte, SplashForm, Reportes;

{$R *.dfm}

procedure TfReportePremios.FormCreate(Sender: TObject);
begin
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  FormatSettings.shortdateformat := 'dd-mm-yyyy';
  self.oFecha01.Value := date;
  self.oFecha01.OnExit(self);
  self.oFecha02.Value := date;
  self.oFecha02.OnExit(self);
  self.oFecha1.Time := StrToTime('00:00:00');
  self.oFecha2.Time := StrToTime('23:59:00');

  cFilePDF := '';

  cDB_file := TRIM(futilesV20.RandomPassword(8));

  self.PageControl1.TabIndex := 0;
  bSwitchPrev := true;
  Reportes.Report.SilentMode := false;
end;

procedure TfReportePremios.oBtn_CloseClick(Sender: TObject);
begin
  exit;
end;

procedure TfReportePremios.oBtn_DesignClick(Sender: TObject);
begin
  self.Print_Report(0);
end;

procedure TfReportePremios.oBtn_PDFClick(Sender: TObject);
begin
  bPrintToFile := true;
  self.Print_Report(4);
  ShellExecute(Handle, 'open', PWideChar(cFilePDF), nil, nil, SW_SHOWNORMAL);
  bPrintToFile := false;
end;

procedure TfReportePremios.oBtn_PreviewClick(Sender: TObject);
begin
  self.PageControl1.Enabled := false;
  self.oBtn_Preview.Enabled := false;
  self.oBtn_Print.Enabled := false;
  self.oBtn_Salir.Enabled := true;

  if bSwitchPrev = true then
    self.Print_Report(1)
  else
    self.Print_Report(0);

  self.oBtn_Preview.Enabled := true;
  self.oBtn_Print.Enabled := true;
  self.oBtn_Salir.Enabled := true;
  self.PageControl1.Enabled := true;
end;

procedure TfReportePremios.oBtn_PreviewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if bSwitchPrev = true then
    self.Print_Report(1)
  else
    self.Print_Report(0);
end;

procedure TfReportePremios.oBtn_PrintClick(Sender: TObject);
begin
  self.oBtn_Preview.Enabled := false;
  self.oBtn_Print.Enabled := false;
  self.oBtn_Salir.Enabled := false;
  self.Print_Report(2);
  self.oBtn_Preview.Enabled := true;
  self.oBtn_Print.Enabled := true;
  self.oBtn_Salir.Enabled := true;
end;

procedure TfReportePremios.Print_Report(iOptcion: integer);
var
  sSql2: string;
  sCodCte: string;
  sHora1: string;
  sHora2: string;
begin
  sFecha1 := FormatDateTime('yyyy-mm-dd HH:mm:ss', self.oFecha1.DateTime);
  sFecha2 := FormatDateTime('yyyy-mm-dd HH:mm:ss', self.oFecha2.DateTime);
  sFecha2 := Copy(sFecha2, 1, 17) + '59';

  sFechaRep1 := FormatDateTime('dd/mm/yyyy hh:mm AM/PM', self.oFecha1.date);
  sFechaRep2 := FormatDateTime('dd/mm/yyyy hh:mm AM/PM', self.oFecha2.date);

  sSql2 := '';

  sSql2 := sSql2 + 'SELECT * ';
  sSql2 := sSql2 + 'FROM premios ';
  sSql2 := sSql2 + 'WHERE 1=1 ';
  sSql2 := sSql2 + 'AND  1=1 ';
  sSql2 := sSql2 + 'AND ( Fecha_Pago >= "' + sFecha1 + '" AND Fecha_Pago <= "' + sFecha2 + '") ';

  if TRIM(self.oChapa.Text) <> '' then
    sSql2 := sSql2 + 'AND Chapa=' + QuotedStr(TRIM(self.oChapa.Text));

  self.Make_Reporte(sSql2, iOptcion);
end;

procedure TfReportePremios.oBtn_SalirClick(Sender: TObject);
begin
  close;
end;

procedure TfReportePremios.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F11 then
  begin
    if bSwitchPrev = true then
    begin
      self.oBtn_Preview.Caption := 'Diseño';
      self.oBtn_PDF.Visible := true;
      bSwitchPrev := false;
    end
    else
    begin
      self.oBtn_Preview.Caption := 'Visualizar';
      self.oBtn_PDF.Visible := false;
      bSwitchPrev := true;
    end;
  end;
end;

procedure TfReportePremios.FormShow(Sender: TObject);
begin
  bSwitchPrev := true;
end;

procedure TfReportePremios.oFecha01Exit(Sender: TObject);
begin
  self.oFecha1.date := self.oFecha01.Value;
end;

procedure TfReportePremios.oFecha02Exit(Sender: TObject);
begin
  if oFecha02.Value < oFecha01.Value then
  begin
    oFecha02.Value := oFecha01.Value;
  end;
  self.oFecha2.date := self.oFecha02.Value;
end;

procedure TfReportePremios.Make_Reporte(sSqlFac: string; iOptcion: integer);
var
  sFileRep, cPath: string;
begin
  sFileRep := utilesV20.sPathReports + '\Rep_Premios1.fr3';

  Reportes.Initialize;

  if bPrintToFile = true then
  begin
    cPath := ExtractFilePath(Application.ExeName);
    cFilePDF := cPath + 'Adjuntos\' + futilesV20.CreateUniqueFileName(cPath + 'Adjuntos') + '.PDF';
    Reportes.ExpotrPDF.IS_Active := true;
    Reportes.ExpotrPDF.PDF_Name := cFilePDF;
  end;

  Reportes.Queries[1].Active := true;
  Reportes.Queries[1].Sql_IsProcedure := false;
  Reportes.Queries[1].Sql_String := sSqlFac;
  Reportes.Queries[1].DB_DSName := 'oQryPremios';
  {
    Reportes.Report.OnDBDatasetEmptyExit[2] := true;
    Reportes.Report.OnDBDatasetEmptyMessage[2] :=
    'No hay datos que procesar para su selección.';
  }

  Reportes.Report.File_Name := sFileRep;

  Reportes.Report.Vars[1].Name := 'Fecha_desde';
  Reportes.Report.Vars[1].Value := sFechaRep1;

  Reportes.Report.Vars[2].Name := 'Fecha_hasta';
  Reportes.Report.Vars[2].Value := sFechaRep2;

  Reportes.Report.Vars[3].Name := 'Filtro_Cte';
  Reportes.Report.Vars[3].Value := sFiltro_Cte;

  Reportes.Report.OutOption := iOptcion;

  Reportes.Prepare;
  Reportes.Make_Report;
end;

end.
