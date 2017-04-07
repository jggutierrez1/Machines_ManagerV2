object TSplashForm2: TTSplashForm2
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'TSplashForm2'
  ClientHeight = 128
  ClientWidth = 431
  Color = clMenuHighlight
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object olMensage: TLabel
    Left = 8
    Top = 29
    Width = 415
    Height = 40
    Alignment = taCenter
    AutoSize = False
    Caption = 'Consultando base de datos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 117
    Top = 5
    Width = 196
    Height = 14
    Caption = 'Espere un momento por favor:..'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object oSign: TLabel
    Left = 13
    Top = 77
    Width = 4
    Height = 13
    Caption = '/'
  end
  object oCPorc1: TLabel
    Left = 391
    Top = 77
    Width = 20
    Height = 13
    Caption = '0 %'
  end
  object oCPorc2: TLabel
    Left = 391
    Top = 102
    Width = 20
    Height = 13
    Caption = '0 %'
  end
  object ProgressBar1: TProgressBar
    Left = 32
    Top = 75
    Width = 353
    Height = 20
    TabOrder = 0
  end
  object ProgressBar2: TProgressBar
    Left = 32
    Top = 100
    Width = 353
    Height = 20
    TabOrder = 1
    Visible = False
  end
  object oLogs: TListBox
    Left = 98
    Top = 160
    Width = 31
    Height = 25
    ItemHeight = 13
    TabOrder = 2
    Visible = False
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 392
    Top = 16
  end
end
