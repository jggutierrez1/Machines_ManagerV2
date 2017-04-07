object fReporteAdelantos: TfReporteAdelantos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Reporte de Adelantos.'
  ClientHeight = 455
  ClientWidth = 733
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object oBtn_Preview: TBitBtn
    Left = 603
    Top = 93
    Width = 113
    Height = 41
    Caption = 'Visualizar'
    TabOrder = 1
    OnClick = oBtn_PreviewClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 431
    Width = 733
    Height = 24
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 24
    Top = 31
    Width = 549
    Height = 394
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Generales'
      object Label3: TLabel
        Left = 31
        Top = 42
        Width = 34
        Height = 13
        Caption = 'Desde:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 285
        Top = 42
        Width = 32
        Height = 13
        Caption = 'Hasta:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 47
        Top = 127
        Width = 38
        Height = 13
        Caption = 'Chapa:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 117
        Top = 70
        Width = 27
        Height = 13
        Caption = 'Hora:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 349
        Top = 70
        Width = 27
        Height = 13
        Caption = 'Hora:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object oFecha01: TDBDateTimeEditEh
        Left = 97
        Top = 34
        Width = 134
        Height = 24
        DynProps = <>
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Visible = True
        OnExit = oFecha01Exit
        EditFormat = 'DD/MM/YYYY'
      end
      object oFecha02: TDBDateTimeEditEh
        Left = 331
        Top = 34
        Width = 134
        Height = 24
        DynProps = <>
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = True
        OnExit = oFecha02Exit
        EditFormat = 'DD/MM/YYYY'
      end
      object oChapa: TEdit
        Left = 129
        Top = 122
        Width = 89
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object oFecha2: TDateTimePicker
        Left = 384
        Top = 64
        Width = 81
        Height = 21
        Date = 40413.889537037040000000
        Format = 'hh:mm tt '
        Time = 40413.889537037040000000
        Kind = dtkTime
        TabOrder = 3
      end
      object oFecha1: TDateTimePicker
        Left = 150
        Top = 64
        Width = 80
        Height = 21
        Date = 40413.388888888890000000
        Format = 'hh:mm tt '
        Time = 40413.388888888890000000
        Kind = dtkTime
        TabOrder = 2
      end
    end
  end
  object oBtn_Print: TBitBtn
    Left = 603
    Top = 169
    Width = 113
    Height = 41
    Caption = 'Imprimir'
    TabOrder = 2
    OnClick = oBtn_PrintClick
  end
  object oBtn_Salir: TBitBtn
    Left = 603
    Top = 322
    Width = 113
    Height = 41
    Cancel = True
    Caption = 'Salir'
    TabOrder = 3
    OnClick = oBtn_SalirClick
  end
  object oSqlStr: TMemo
    Left = 680
    Top = 401
    Width = 36
    Height = 24
    Lines.Strings = (
      'oSql'
      'Str')
    TabOrder = 5
    Visible = False
  end
  object oBtn_PDF: TBitBtn
    Left = 603
    Top = 245
    Width = 113
    Height = 41
    Caption = 'PDF'
    TabOrder = 6
    OnClick = oBtn_PDFClick
  end
  object frxReport1: TfrxReport
    Version = '4.15.4'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Por defecto'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40729.696863819440000000
    ReportOptions.LastChange = 40729.696863819440000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 577
    Top = 397
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
    end
  end
end
