object TSplashForm: TTSplashForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'TSplashForm'
  ClientHeight = 109
  ClientWidth = 431
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object olMensage: TLabel
    Left = 17
    Top = 43
    Width = 396
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Consultando base de datos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 117
    Top = 9
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
  object ProgressBar1: TProgressBar
    Left = 17
    Top = 75
    Width = 396
    Height = 20
    TabOrder = 0
  end
end
