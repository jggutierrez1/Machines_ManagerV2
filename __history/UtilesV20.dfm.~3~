object fUtilesV20: TfUtilesV20
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Biblioteca de herramientas.'
  ClientHeight = 9
  ClientWidth = 9
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object oPub_Qry: TFDQuery
    Left = 264
    Top = 152
  end
  object oPub_Scp: TFDScript
    SQLScripts = <>
    Params = <>
    Macros = <>
    Left = 264
    Top = 96
  end
  object oPublicCnn: TFDConnection
    Params.Strings = (
      'User_Name=root'
      'Server=127.0.0.1'
      'Database=one2009_1'
      'DriverID=MySQL'
      'CharacterSet=utf8')
    FormatOptions.AssignedValues = [fvSE2Null, fvDataSnapCompatibility, fvQuoteIdentifiers]
    FormatOptions.DataSnapCompatibility = True
    FormatOptions.QuoteIdentifiers = True
    LoginPrompt = False
    Left = 32
    Top = 96
  end
  object oPub_Com: TFDCommand
    Connection = oPublicCnn
    Left = 264
    Top = 40
  end
  object oPublicCnnSQLL: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    FormatOptions.AssignedValues = [fvDataSnapCompatibility]
    FormatOptions.DataSnapCompatibility = True
    LoginPrompt = False
    Left = 32
    Top = 32
  end
  object oPublicCnn_Tmp: TFDConnection
    Params.Strings = (
      'Database=one2009_1'
      'User_Name=remoto'
      'Password=1234'
      'Server=192.168.0.80'
      'DriverID=MySQL')
    FormatOptions.AssignedValues = [fvDataSnapCompatibility]
    FormatOptions.DataSnapCompatibility = True
    LoginPrompt = False
    Left = 32
    Top = 168
  end
  object oIdFTP: TIdFTP
    IPVersion = Id_IPv4
    ConnectTimeout = 0
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 352
    Top = 16
  end
  object oIdIcmpClient: TIdIcmpClient
    Protocol = 1
    ProtocolIPv6 = 58
    IPVersion = Id_IPv4
    Left = 352
    Top = 80
  end
  object oIdTCPClient: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 352
    Top = 152
  end
  object oIdIPWatch: TIdIPWatch
    Active = False
    HistoryFilename = 'iphist.dat'
    Left = 352
    Top = 216
  end
  object oPub_Qry2: TFDQuery
    Connection = oPublicCnn
    Left = 264
    Top = 208
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 136
    Top = 168
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 136
    Top = 96
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 136
    Top = 32
  end
end
