object fDatabase_Backup_Restore: TfDatabase_Backup_Restore
  Left = 195
  Top = 125
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Copia Seguridad MySQL'
  ClientHeight = 485
  ClientWidth = 712
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tab: TPageControl
    Left = 9
    Top = 9
    Width = 597
    Height = 390
    ActivePage = tabEjecutar
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object tabEjecutar: TTabSheet
      Caption = 'Realizar copia de seguridad'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      object olStatus_Backup: TLabel
        Left = 5
        Top = 309
        Width = 580
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Caption = '.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMoneyGreen
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object gComando: TGroupBox
        Left = 6
        Top = 173
        Width = 576
        Height = 125
        Caption = 'Comando resultante '
        TabOrder = 0
        object olObj_Name: TLabel
          Left = 118
          Top = 64
          Width = 60
          Height = 13
          Caption = 'NINGUNO...'
        end
        object Label1: TLabel
          Left = 15
          Top = 64
          Width = 97
          Height = 13
          Caption = 'Nombre del Objecto:'
        end
        object ProgressBarB: TProgressBar
          Left = 15
          Top = 83
          Width = 546
          Height = 25
          TabOrder = 0
        end
        object oBtn_Backup: TBitBtn
          Left = 15
          Top = 23
          Width = 135
          Height = 35
          Cursor = crHandPoint
          Hint = 'Ejecuta el comando resultante para hacer la copia de seguridad'
          Caption = '&Ejecutar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = oBtn_BackupClick
        end
        object oBtn_Salir1: TButton
          Left = 426
          Top = 23
          Width = 135
          Height = 35
          Cursor = crHandPoint
          Hint = 'Cierra esta aplicaci'#243'n'
          Cancel = True
          Caption = '&Salir'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = oBtn_Salir1Click
        end
        object oBtn_Config1: TBitBtn
          Left = 221
          Top = 23
          Width = 135
          Height = 35
          Cursor = crHandPoint
          Hint = 'Configurar opciones para copia de seguridad'
          Caption = 'Configurar'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = oBtn_Config1Click
        end
      end
      object GroupBox1: TGroupBox
        Left = 6
        Top = 9
        Width = 576
        Height = 75
        Caption = 'Configuraci'#243'n '
        TabOrder = 1
        object lbBD: TLabel
          Left = 4
          Top = 42
          Width = 169
          Height = 13
          Caption = 'Bases de datos (cat'#225'logos) a copiar'
        end
        object oList_Databases: TComboBox
          Left = 179
          Top = 33
          Width = 376
          Height = 22
          DropDownCount = 10
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
      object GroupBox3: TGroupBox
        Left = 6
        Top = 100
        Width = 576
        Height = 59
        Caption = 'Destino '
        TabOrder = 2
        object Label8: TLabel
          Left = 8
          Top = 19
          Width = 132
          Height = 13
          Caption = 'Carpeta y fichero de destino'
        end
        object txtDestino: TEdit
          Left = 144
          Top = 16
          Width = 391
          Height = 21
          TabOrder = 0
        end
        object bSelDestino: TButton
          Left = 539
          Top = 15
          Width = 19
          Height = 22
          Cursor = crHandPoint
          Hint = 'Seleccionar destino de copia de seguridad'
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = bSelDestinoClick
        end
      end
    end
    object tabRecuperar: TTabSheet
      Caption = 'Recuperar/Restaurar copia'
      ImageIndex = 2
      object olStatus_Restore: TLabel
        Left = 6
        Top = 304
        Width = 580
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Caption = 'EJECUTANDO CONSULTA.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10800292
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object gComandoRes: TGroupBox
        Left = 6
        Top = 173
        Width = 576
        Height = 125
        Caption = 'Comando resultante '
        TabOrder = 0
        object oBtn_Restore: TBitBtn
          Left = 15
          Top = 23
          Width = 135
          Height = 35
          Cursor = crHandPoint
          Hint = 
            'Ejecuta el comando resultante para realizar la restauraci'#243'n de u' +
            'na copia existente'
          Caption = '&Ejecutar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = oBtn_RestoreClick
        end
        object oBtn_Salir2: TButton
          Left = 426
          Top = 23
          Width = 135
          Height = 35
          Cursor = crHandPoint
          Hint = 'Cierra esta aplicaci'#243'n'
          Cancel = True
          Caption = '&Salir'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = oBtn_Salir1Click
        end
        object oBtn_Config2: TBitBtn
          Left = 221
          Top = 23
          Width = 135
          Height = 35
          Cursor = crHandPoint
          Hint = 'Configurar opciones para restauraci'#243'n'
          Caption = 'Configurar'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = oBtn_Config2Click
        end
        object ProgressBarR: TProgressBar
          Left = 15
          Top = 83
          Width = 546
          Height = 25
          TabOrder = 3
        end
      end
      object GroupBox7: TGroupBox
        Left = 6
        Top = 9
        Width = 576
        Height = 75
        Caption = 'Configuraci'#243'n '
        TabOrder = 1
        object Label9: TLabel
          Left = 9
          Top = 45
          Width = 81
          Height = 13
          Caption = 'Nombre cat'#225'logo'
        end
        object txtBDRes: TEdit
          Left = 94
          Top = 42
          Width = 441
          Height = 21
          TabOrder = 0
        end
      end
      object GroupBox9: TGroupBox
        Left = 6
        Top = 100
        Width = 576
        Height = 59
        Caption = 'Fichero origen '
        TabOrder = 2
        object Label12: TLabel
          Left = 6
          Top = 26
          Width = 51
          Height = 13
          Caption = 'Fichero sql'
        end
        object txtOrigen: TEdit
          Left = 62
          Top = 24
          Width = 476
          Height = 21
          TabOrder = 0
        end
        object bSelOrigen: TButton
          Left = 541
          Top = 23
          Width = 19
          Height = 22
          Cursor = crHandPoint
          Hint = 'Seleccionar fichero origen para restaurar'
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = bSelOrigenClick
        end
      end
    end
    object tabConfiguracion: TTabSheet
      Caption = 'Configuraci'#243'n'
      ImageIndex = 1
      object tabConf: TPageControl
        Left = 4
        Top = 4
        Width = 582
        Height = 495
        ActivePage = tabConfRestaurar
        TabOrder = 0
        OnExit = tabConfExit
        object tabConfCop: TTabSheet
          Caption = 'Copia seguridad'
          object GroupBox2: TGroupBox
            Left = 3
            Top = 68
            Width = 567
            Height = 189
            Caption = 'Otros par'#225'metros de configuraci'#243'n '
            TabOrder = 0
            object opOPT: TCheckBox
              Left = 10
              Top = 20
              Width = 371
              Height = 17
              Caption = 'add-drop-table, add-locks  disable-keys  lock-tables)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object opSoloDefinicion: TCheckBox
              Left = 10
              Top = 44
              Width = 371
              Height = 17
              Caption = 'Copiar s'#243'lo definici'#243'n de tablas, no copiar datos'
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              TabOrder = 1
            end
            object opHexadecimal: TCheckBox
              Left = 10
              Top = 94
              Width = 371
              Height = 17
              Caption = 'Exportar columnas de tipo binario en formato hexadecimal'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
            end
            object opInsertExtendidos: TCheckBox
              Left = 10
              Top = 69
              Width = 371
              Height = 17
              Caption = 'Insert extendidos'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
            end
            object opProcedimientos: TCheckBox
              Left = 10
              Top = 119
              Width = 371
              Height = 17
              Caption = 'Incluir procedimientos y funciones'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
            end
            object BitBtn1: TBitBtn
              Left = 10
              Top = 150
              Width = 75
              Height = 25
              Caption = 'Regresar'
              TabOrder = 5
              OnClick = BitBtn1Click
            end
          end
          object GroupBox5: TGroupBox
            Left = 4
            Top = 3
            Width = 567
            Height = 59
            Caption = 'Datos de acceso '
            TabOrder = 1
            object Label2: TLabel
              Left = 7
              Top = 23
              Width = 36
              Height = 13
              Caption = 'Usuario'
            end
            object Label5: TLabel
              Left = 122
              Top = 23
              Width = 54
              Height = 13
              Caption = 'Contrase'#241'a'
            end
            object Label6: TLabel
              Left = 294
              Top = 23
              Width = 22
              Height = 13
              Caption = 'Host'
            end
            object Label7: TLabel
              Left = 446
              Top = 23
              Width = 31
              Height = 13
              Caption = 'Puerto'
            end
            object txtUsuario: TEdit
              Left = 46
              Top = 21
              Width = 67
              Height = 21
              TabOrder = 0
            end
            object txtContrasena: TEdit
              Left = 179
              Top = 21
              Width = 73
              Height = 21
              PasswordChar = '*'
              TabOrder = 1
            end
            object txtPuerto: TEdit
              Left = 480
              Top = 21
              Width = 73
              Height = 21
              TabOrder = 2
            end
            object txtHost: TEdit
              Left = 318
              Top = 21
              Width = 99
              Height = 21
              TabOrder = 3
            end
          end
        end
        object tabConfRestaurar: TTabSheet
          Caption = 'Restaurar'
          ImageIndex = 1
          object GroupBox4: TGroupBox
            Left = 4
            Top = 70
            Width = 567
            Height = 189
            Caption = 'Otros par'#225'metros de configuraci'#243'n '
            TabOrder = 0
            object BitBtn2: TBitBtn
              Left = 10
              Top = 150
              Width = 75
              Height = 25
              Caption = 'Regresar'
              TabOrder = 0
              OnClick = BitBtn2Click
            end
          end
          object GroupBox8: TGroupBox
            Left = 4
            Top = 3
            Width = 564
            Height = 57
            Caption = 'Datos de acceso '
            TabOrder = 1
            object Label13: TLabel
              Left = 7
              Top = 23
              Width = 36
              Height = 13
              Caption = 'Usuario'
            end
            object Label14: TLabel
              Left = 122
              Top = 23
              Width = 54
              Height = 13
              Caption = 'Contrase'#241'a'
            end
            object Label15: TLabel
              Left = 294
              Top = 23
              Width = 22
              Height = 13
              Caption = 'Host'
            end
            object Label16: TLabel
              Left = 446
              Top = 23
              Width = 31
              Height = 13
              Caption = 'Puerto'
            end
            object txtUsuarioRes: TEdit
              Left = 46
              Top = 21
              Width = 67
              Height = 21
              TabOrder = 0
            end
            object txtContrasenaRes: TEdit
              Left = 179
              Top = 21
              Width = 73
              Height = 21
              TabOrder = 1
            end
            object txtPuertoRes: TEdit
              Left = 480
              Top = 21
              Width = 73
              Height = 21
              TabOrder = 2
            end
            object txtHostRes: TEdit
              Left = 318
              Top = 21
              Width = 99
              Height = 21
              TabOrder = 3
            end
          end
        end
      end
    end
  end
  object be: TStatusBar
    Left = 0
    Top = 466
    Width = 712
    Height = 19
    AutoHint = True
    Panels = <
      item
        Width = 400
      end
      item
        Width = 60
      end>
    ExplicitTop = 405
    ExplicitWidth = 610
  end
  object dlAbrir: TOpenTextFileDialog
    DefaultExt = 'bk1'
    Filter = 'Facil Backup (*.bk1)|*.bk1|Ficheros SQL (*.sql)|*.sql '
    Left = 608
    Top = 76
  end
  object dlGuardar: TSaveTextFileDialog
    DefaultExt = 'bk1'
    FileName = 'copia_bd'
    Filter = 'Facil Backup (*.bk1)|*.bk1|Ficheros SQL (*.sql)|*.sql'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 608
    Top = 32
  end
  object oConnection: TFDConnection
    Left = 16
    Top = 416
  end
  object oConn: TFDConnection
    Left = 80
    Top = 416
  end
  object oBackup: TFDIBBackup
    Protocol = ipTCPIP
    Host = 'localhost'
    UserName = 'root'
    Database = 'one2009_1'
    Verbose = True
    Left = 256
    Top = 416
  end
  object oScript1: TFDScript
    SQLScripts = <>
    Connection = oConnection
    Params = <>
    Macros = <>
    Left = 480
    Top = 416
  end
  object oRestore: TFDIBRestore
    Protocol = ipTCPIP
    Host = 'localhost'
    UserName = 'root'
    Database = 'one2009_1'
    Left = 336
    Top = 416
  end
end
