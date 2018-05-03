{ ******************************************************* }
{ johnn Gutierrez jg_gutierrez@yahoo.es }
{ Mayo 2010-Febrero 2011 }
{ ******************************************************* }
unit Reportes;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB,

  frxClass, frxDesgn, fs_ipascal, frxExportImage,
  frxExportCSV, FRxExportPDF, frxExportText,
  frxExportXLSX, frxExportXLS,

  frxBarcode, frxDBSet, frxRich,

  edita_reporte,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TpQuery = object
    Zquery: TFDQuery;
    Active: boolean;
    oQry_RegCount: integer;
    Sql_IsProcedure: boolean;
    Sql_ExecNoOpen: boolean;
    Sql_String: widestring;
    DB_DSName: string;
    SortType: string;
    SortedFields: string;
    IndexFieldNames: string;
  end;

  TpPdf = object
    IS_Active: boolean;
    PDF_Name: string;
  end;

  TpTxt = object
    IS_Active: boolean;
    Txt_Name: string;
    Txt_ReportName: string;
  end;

  TpRepVars = object
    Name: string;
    Value: string;
  end;

type
  TpDataLink = object
    Active: boolean;
    QryMaster: integer;
    FldMaster: string;
    QrySlave: integer;
    FldSlave: string;
  end;

  TpReport = object
    File_Name: string;
    ofrxDBDataset: array [1 .. 9] of TfrxDBDataset;
    OutOption: integer;
    MudeActivity: boolean;
    SilentMode: boolean;
    Prepared: boolean;
    AutoFree: boolean;
    Vars: array [1 .. 20] of TpRepVars;
    OnDBDatasetEmptyExit: array [1 .. 9] of boolean;
    OnDBDatasetEmptyMessage: array [1 .. 9] of string;
  end;

var
  oFrom: TForm;

  { ***************************************************************** }
  oReportForm: TfrxReport;
  oPDFExport: TfrxPDFExport;
  oTXTExport: TfrxSimpleTextExport;
  oRepDesign: TfrxDesigner;

  frxPDFExport1: TfrxPDFExport;
  frxCSVExport1: TfrxCSVExport;
  frxTXTExport1: TfrxSimpleTextExport;
  frxSimpleTextExport1: TfrxSimpleTextExport;
  frxXLSExport1: TfrxXLSExport;
  frxXLSXExport1: TfrxXLSXExport;
  frxJPEGExport1: TfrxJPEGExport;

  { ***************************************************************** }
  ExpotrPDF: TpPdf;
  ExpotrTXT: TpTxt;
  Report: TpReport;
  cPrinter_name: string;
  Queries: array [1 .. 9] of TpQuery;
  ofrxDBDataset: array [1 .. 9] of TfrxDBDataset;
  oDS_Fields1: TDataSource;
  oDS_Fields2: TDataSource;
  oLinkData: TpDataLink;

procedure Initialize;
procedure Prepare;
function Make_Report: boolean;
procedure Clear_all;

implementation

uses UtilesV20, SplashForm;

procedure Initialize;
var
  i: integer;
begin
  if Report.Prepared = true then
    exit;
  oLinkData.Active := false;
  for i := 1 to 20 do
  begin
    if i <= 9 then
    begin
      Report.OnDBDatasetEmptyExit[i] := false;
      Report.OnDBDatasetEmptyMessage[i] := '';

      Queries[i].Active := false;
      Queries[i].oQry_RegCount := 0;
      Queries[i].Sql_IsProcedure := false;
      Queries[i].Sql_ExecNoOpen := false;
      Queries[i].Sql_String := '';
      Queries[i].DB_DSName := '';
      Queries[i].SortType := ':A';
      Queries[i].SortedFields := '';
      Queries[i].IndexFieldNames := '';

      Report.Vars[i].Name := '';
      Report.Vars[i].Value := '';
    end;
    Report.Vars[i].Name := '';
    Report.Vars[i].Value := '';

  end;
  ExpotrPDF.IS_Active := false;
  ExpotrPDF.PDF_Name := '';

  Report.File_Name := '';
  Report.OutOption := 0;
  Report.SilentMode := true;
  Report.Prepared := false;
  Report.AutoFree := true;
end;

procedure Prepare;
var
  i: integer;
begin
  if Report.Prepared = true then
    exit;

  frxPDFExport1 := TfrxPDFExport.Create(nil);
  frxCSVExport1 := TfrxCSVExport.Create(nil);
  frxTXTExport1 := TfrxSimpleTextExport.Create(nil);
  frxSimpleTextExport1 := TfrxSimpleTextExport.Create(nil);
  frxXLSExport1 := TfrxXLSExport.Create(nil);
  frxXLSXExport1 := TfrxXLSXExport.Create(nil);
  frxJPEGExport1 := TfrxJPEGExport.Create(nil);

  oDS_Fields1 := TDataSource.Create(nil);
  oDS_Fields2 := TDataSource.Create(nil);

  for i := 1 to 9 do
  begin
    if Queries[i].Active = true then
    begin
      Queries[i].Zquery := TFDQuery.Create(oFrom);
      Report.ofrxDBDataset[i] := TfrxDBDataset.Create(nil);
    end;
  end;

  if ExpotrPDF.IS_Active = true then
    oPDFExport := TfrxPDFExport.Create(oFrom);

  if ExpotrTXT.IS_Active = true then
    oTXTExport := TfrxSimpleTextExport.Create(oFrom);

  oReportForm := TfrxReport.Create(oFrom);
  oRepDesign := TfrxDesigner.Create(oFrom);
  Report.Prepared := true;
end;

function Make_Report: boolean;
var
  i: integer;
begin
  try
    if Report.MudeActivity = true then
      Report.SilentMode := true;

    if Report.MudeActivity = false then
      fUtilesV20.WaitStart(oFrom, 'Inicializando reporte:..');

    if FileExists(Report.File_Name) = false then
    begin
      application.MessageBox(Pchar('El Reporte [' + trim(Report.File_Name) +
        '], no existe.'), '', 0);
      fUtilesV20.WaitEnd;
      exit;
    end;

    oReportForm.DataSets.Clear();
    oReportForm.DataSets.BeginUpdate;
    for i := 1 to 9 do
    begin
      if Queries[i].Active = true then
      begin
        if Report.MudeActivity = false then
          fUtilesV20.WaitSetMsg('Espere mientras se procesa la consulta [' +
            IntToStr(i) + ']:..');

        if UtilesV20.Exec_Select_SQL(Queries[i].Zquery, Queries[i].Sql_String,
          true, true, Queries[i].Sql_IsProcedure, Queries[i].Sql_ExecNoOpen) = true
        then
          Queries[i].oQry_RegCount := Queries[i].Zquery.RecordCount;

        if Queries[i].oQry_RegCount <= 0 then
        begin
          if (Report.OnDBDatasetEmptyExit[i] = true) then
          begin
            if Report.SilentMode = false then
            begin
              if (Report.OnDBDatasetEmptyMessage[i] = '') then
              begin
                if Report.MudeActivity = false then
                  Report.OnDBDatasetEmptyMessage[i] :=
                    'No hay datos que correspondan a los parametros especificados';
              end;

              fUtilesV20.delay(3 * 1000);
              if Report.SilentMode = false then
              begin
                fUtilesV20.WaitSetMsg(Report.OnDBDatasetEmptyMessage[i]);
                fUtilesV20.WaitEnd;
              end;
            end;
            Clear_all;
            exit;
          end;
        end;

        if fUtilesV20.isEmpty(Queries[1].SortedFields) = false then
        begin
          // Queries[i].Zquery.SortType := Queries[i].SortType;
          // Queries[i].Zquery.SortedFields := Queries[i].SortedFields;
          Queries[i].Zquery.IndexFieldNames := Queries[i].IndexFieldNames +
            Queries[i].SortType;
          Queries[i].Zquery.Active := true;
        end;

        Report.ofrxDBDataset[i].Clear();
        Report.ofrxDBDataset[i].CloseDataSource := true;
        Report.ofrxDBDataset[i].DataSet := Queries[i].Zquery;
        Report.ofrxDBDataset[i].OpenDataSource := false;
        Report.ofrxDBDataset[i].UserName := Queries[i].DB_DSName;
        Report.ofrxDBDataset[i].Enabled := true;
        oReportForm.DataSets.Add(Report.ofrxDBDataset[i]);
      end;
    end;
    fUtilesV20.WaitSetMsg('');
    oReportForm.DataSets.EndUpdate;

    if oLinkData.Active = true then
    begin
      oDS_Fields1.DataSet := Queries[oLinkData.QryMaster].Zquery;
      oDS_Fields1.Enabled := true;

      oDS_Fields2.DataSet := Queries[oLinkData.QrySlave].Zquery;
      oDS_Fields2.Enabled := true;

      Queries[oLinkData.QrySlave].Zquery.MasterSource := oDS_Fields1;
      Queries[oLinkData.QrySlave].Zquery.MasterFields := oLinkData.FldMaster;
      // Queries[oLinkData.QrySlave].Zquery.LinkedFields := oLinkData.FldSlave;
    end;

    if ExpotrPDF.IS_Active = true then
    begin
      oPDFExport.ShowDialog := false;
      oPDFExport.FileName := ExpotrPDF.PDF_Name;
      oPDFExport.ShowProgress := false;
      oPDFExport.EmbeddedFonts := true;
      Report.OutOption := 4;
    end;

    if ExpotrTXT.IS_Active = true then
    begin
      oTXTExport.ShowDialog := false;
      oTXTExport.FileName := ExpotrTXT.Txt_Name;
      oTXTExport.ShowProgress := false;
    end;

    { Prepara el reporte }
    oReportForm.EngineOptions.SilentMode := true;
    oReportForm.EngineOptions.PrintIfEmpty := true;
    oReportForm.EngineOptions.UseFileCache := true;
    oReportForm.EngineOptions.EnableThreadSafe := false;
    oReportForm.PrintOptions.ShowDialog := true;

    oReportForm.ShowProgress := fUtilesV20.iif(Report.SilentMode = false,
      true, false);

    oReportForm.LoadFromFile(Report.File_Name);

    oReportForm.Variables.Clear;
    oReportForm.Variables.BeginUpdate;
    for i := 1 to 20 do
    begin
      if not fUtilesV20.isEmpty(Report.Vars[i].Name) then
      begin
        oReportForm.Variables.Variables[Report.Vars[i].Name] :=
          '''' + Report.Vars[i].Value + '''';
      end;
    end;
    oReportForm.Variables.EndUpdate;

    if Report.MudeActivity = false then
      fUtilesV20.WaitSetMsg('Espere mientras se prepara el reporte:..');

    oReportForm.PrepareReport(true);

    if fUtilesV20.isEmpty(cPrinter_name) = false then
      oReportForm.PrintOptions.Printer := cPrinter_name;

    if ExpotrTXT.IS_Active = true then
    begin
      if FileExists(ExpotrTXT.Txt_Name) then
        DeleteFile(ExpotrTXT.Txt_Name);
      oReportForm.Export(oTXTExport);
      if (not Report.OutOption in [3, 0, 5]) then
        Report.OutOption := -1;
    end;

    case Report.OutOption of
      0:
        begin
          application.CreateForm(Tfedita_reporte, fedita_reporte);
          fedita_reporte.frxreport1 := oReportForm;
          fedita_reporte.showmodal;
          fedita_reporte.free;
        end;
      1:
        oReportForm.ShowReport();
      2:
        oReportForm.Print;
      3:
        oReportForm.DesignReport();
      4:
        begin
          if FileExists(ExpotrPDF.PDF_Name) then
            DeleteFile(ExpotrPDF.PDF_Name);
          oPDFExport.EmbeddedFonts := true;
          oPDFExport.FitWindow := true;
          oReportForm.Export(oPDFExport);
        end;
      5:
        begin
          oReportForm.PrintOptions.ShowDialog := false;
          oReportForm.Print;
        end;
      6:
        begin
          { frxMail.Subject := 'test attachment ';
            frxMail.FromName := 'Automatic Email Sender...';
            frxMail.FromMail := 'johnn.movil@gmail.com';
            frxMail.Address := 'jg_gutierrez@yahoo.es';
            frxMail.FromCompany := '...';
            frxMail.Login := 'johnn.movil@gmail.com';
            frxMail.Password := 'password';
            frxMail.SmtpHost := 'smtp.gmail.com';
            frxMail.SmtpPort := 465;
            frxMail.useIniFile := false;
            //frxMail.ExportFilter := TfrxSimpleTextExport;
            frxMail.ShowDialog := false;
            oReportForm.Export(frxMail);
          }
        end;
    end;
    oReportForm.Clear;
    Result := true;
  except
    on E: Exception do
    begin
      application.ShowException(E);
      fUtilesV20.WaitEnd;
      Result := false;
      exit;
    end;
  end;
  fUtilesV20.WaitEnd;
  if Report.AutoFree = true then
    Clear_all;
end;

procedure Clear_all;
var
  i: integer;
begin
  for i := 1 to 9 do
  begin
    if Queries[i].Active = true then
    begin
      freeandnil(Queries[i].Zquery);
      freeandnil(Report.ofrxDBDataset[i]);
      freeandnil(oDS_Fields1);
      freeandnil(oDS_Fields2);
    end;
  end;
  if ExpotrPDF.IS_Active = true then
    freeandnil(oPDFExport);

  if ExpotrTXT.IS_Active = true then
    freeandnil(oTXTExport);

  freeandnil(oReportForm);
  freeandnil(oRepDesign);

  freeandnil(frxPDFExport1);
  freeandnil(frxCSVExport1);
  // freeandnil(frxXLSExport1);
  freeandnil(frxTXTExport1);
  freeandnil(frxSimpleTextExport1);

  Report.SilentMode := false;
  Report.Prepared := false;
  Report.AutoFree := true;
  fUtilesV20.WaitEnd;
end;

end.
