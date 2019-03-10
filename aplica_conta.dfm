object faplica_conta: Tfaplica_conta
  Left = 0
  Top = 0
  Caption = 
    'SISTEMA DE CONTROL DE COLECTAS ELECTRONICAS (APLICAR A INTERFUER' +
    'ZA WEB).'
  ClientHeight = 745
  ClientWidth = 1024
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 8
    Width = 1024
    Height = 664
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Pendientes por aplicar'
      object olFecha1: TLabel
        Left = 3
        Top = 62
        Width = 34
        Height = 13
        Caption = 'Desde:'
      end
      object olFecha2: TLabel
        Left = 122
        Top = 62
        Width = 32
        Height = 13
        Caption = 'Hasta:'
      end
      object olCliente: TLabel
        Left = 243
        Top = 62
        Width = 44
        Height = 16
        Caption = 'Cliente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 3
        Top = 5
        Width = 59
        Height = 16
        Caption = 'Empresa:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 120
        Width = 1016
        Height = 516
        Align = alBottom
        DataGrouping.FootersDefValues.ShowFunctionName = True
        DataGrouping.FootersDefValues.RunTimeCustomizable = True
        DataGrouping.GroupLevels = <
          item
          end
          item
            ColumnName = 'Column_0_op_fecha'
          end>
        DataSource = oDs_Qry_Op
        DynProps = <>
        FooterRowCount = 1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        RowPanel.Active = True
        SumList.Active = True
        TabOrder = 0
        Columns = <
          item
            CellButtons = <>
            DisplayFormat = 'dd/mm/yyyy hh:mm am/pm'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_fecha'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footers = <>
            MaxWidth = 127
            MinWidth = 127
            Title.Alignment = taCenter
            Title.Caption = 'Fecha'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 127
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'cte_id'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footers = <>
            MaxWidth = 50
            MinWidth = 50
            Title.Alignment = taCenter
            Title.Caption = 'C'#243'd. Cte.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'cte_nombre_loc'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.DisplayFormat = '###0'
            Footer.FieldName = 'cte_id'
            Footer.Value = '0'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Nombre Cliente'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 231
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_fact_global'
            Footers = <>
            MaxWidth = 80
            MinWidth = 80
            Title.Alignment = taCenter
            Title.Caption = '#Global'
            Width = 80
          end
          item
            CellButtons = <>
            Color = 9632618
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_colect'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_colect'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            MaxWidth = 85
            MinWidth = 85
            Title.Alignment = taCenter
            Title.Caption = 'Colectado'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 85
          end
          item
            CellButtons = <>
            Color = 10930928
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_impjcj'
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_impjcj'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Imp. J.C.J.'
          end
          item
            CellButtons = <>
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_porc_cons'
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_porc_cons'
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Consesi'#243'n'
          end
          item
            CellButtons = <>
            Color = 9632618
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_tec'
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Serv. T'#233'cnico'
          end
          item
            CellButtons = <>
            Color = 10930928
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_dev'
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Devoluciones'
          end
          item
            CellButtons = <>
            Color = 10930928
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_otros'
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = 'Otros'
          end
          item
            CellButtons = <>
            Color = 10930928
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_cred'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_cred'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            MaxWidth = 85
            MinWidth = 85
            Title.Alignment = taCenter
            Title.Caption = 'Premios'
            Width = 85
          end
          item
            CellButtons = <>
            Color = 9632618
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_tot'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_tot'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            MaxWidth = 85
            MinWidth = 85
            Title.Alignment = taCenter
            Title.Caption = 'Total'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 85
          end
          item
            CellButtons = <>
            Color = 9632618
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_brutoemp'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_brutoemp'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Bruto Emp.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 95
          end
          item
            CellButtons = <>
            Color = 9632618
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_netoemp'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_netoemp'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Neto Emp.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
          end
          item
            CellButtons = <>
            Checkboxes = True
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_baja_prod'
            Footer.FieldName = 'op_baja_prod'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Baja Prod.'
            Width = 70
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object oFecha1: TDBDateTimeEditEh
        Left = 3
        Top = 81
        Width = 113
        Height = 24
        DynProps = <>
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Kind = dtkDateEh
        ParentFont = False
        TabOrder = 1
        Visible = True
      end
      object oFecha2: TDBDateTimeEditEh
        Left = 122
        Top = 81
        Width = 113
        Height = 24
        DynProps = <>
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Kind = dtkDateEh
        ParentFont = False
        TabOrder = 2
        Visible = True
      end
      object oLst_Ctes: TDBLookupComboboxEh
        Left = 243
        Top = 81
        Width = 348
        Height = 24
        DynProps = <>
        DataField = ''
        Enabled = False
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        KeyField = 'cte_id'
        ListField = 'cte_nombre_com'
        ListSource = oDS_Ctes
        ParentFont = False
        TabOrder = 3
        Visible = True
      end
      object oLst_emp: TDBLookupComboboxEh
        Left = 3
        Top = 22
        Width = 518
        Height = 24
        DynProps = <>
        DataField = ''
        EditButtons = <>
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        KeyField = 'emp_id'
        ListField = 'emp_descripcion'
        ListSource = oDs_Emp
        ParentFont = False
        TabOrder = 4
        Visible = True
      end
      object oBtn_Preview: TPngBitBtn
        Tag = 5
        Left = 723
        Top = 22
        Width = 144
        Height = 57
        Align = alCustom
        BiDiMode = bdLeftToRight
        Caption = 'Filtrar'
        ParentBiDiMode = False
        TabOrder = 5
        OnClick = oBtn_PreviewClick
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
          8700000006624B474400FF00FF00FFA0BDA79300000009704859730000004800
          0000480046C96B3E0000000976704167000000300000003000CEEE8C5700000D
          444944415478DAB59A7B6CD45516C7EFB4430B451EA5BCB10521200F0BDB8D0F
          90D5586C401E8A1AB55A174D7031ABB3666344FF222BD9BFFCC3EC0E2B958028
          22D62716018DC60413A512B082E22B1614055B2AA5403B7DBFA67B3EE73767FA
          EB506841BCC94D67EEEFCEBDE77BCEF73CEEFD3570E0C08119E3C78FDFD2AF5F
          BF1CF707B5CECE4ED7D6D6565F5B5BFBEF929292F0983163DAE6CF9F7F49D60E
          ECDDBBF7C19C9C9C0DC16030E58F02406B6D6D7567CE9CA991BE6AFFFEFD1B46
          8C18D1B670E1C2DF0FE0C30F3F0CE5E6E686C502413475A95B4747878B46A3AE
          BDBDDD353636BA4824522B7DD5975F7EB97EE4C8916DB7DE7AEBEF03F0C1071F
          84E6CD9B1796CF4136114B749BC077C601170804E2E37C17D02A1C4226824F4E
          4E8E0BCE337A535393CEADA9A9A915304FBDF4D24B1BAFBEFAEAE8F2E5CB2F1E
          C0FBEFBF1FCACBCB0B373737077FFAE927D7D0D0A042A7A5A5E98663C78E7595
          959571E111BABEBEDE0D1D3AD44D9830C19D3A75CA9D3E7DDAB5B4B468E77952
          5292139E4319A50E73478F1EAD6B0F1E3C58E78B15AA649D27DE7CF3CDD784C2
          D1071E78E0E200BCF7DE7B0A40040C565555A910682B35355505010C636894BF
          00418B087AD965973901AE5AA69905796E0AA0F199F5000E10D6018438759500
          59B965CB96A21B6FBC315A505070E10076EEDC1992881016B3060F1D3AA442B3
          199B88A3A129A502E3274E9C70292929FA9C8EA000484F4FD739701CF0CC0108
          201174DCB8716EF8F0E1BA566666A66E0C389E8995AA64EF95DBB76F2F9A3163
          46F4A1871EBA30003B76EC5000D01DA17550B48C20086D1C678CCFE617368767
          E6375800A169361780F61C4A49C8D6750D448C8255F2EC09B1C46BD75E7B6DF4
          91471EE93B8077DF7D37B460C182B068B49BF71AE7CD394DE0B316888DD30100
          E7FD4E0FF56892075C7575B59B3871621C000DAB01423A20566EDCB8B148824A
          F4E1871FEE1B806DDBB6856EB9E516B5001A6143FE9A26FBF7EFAFDC352D2214
          CFFCD105E18E1F3FEEF021E33D42B216FCC789F117C05D79E5957150A620B384
          00AC92BEF29D77DE29CACECE8E3EF6D8637D07401412A7D2C1BABABA38EFE137
          D1C36F150460632877ECD83177F2E4493760C0002771DD0D1B36CC0D1C385001
          431FC04722750A1230575C31419562EBF9E9C4FED049C03CF19AB46BAEB926FA
          F8E38FF70D8008AC00108E8D11908D008253B219CFD9908E605F7DF5953AF3AC
          597F92E8324A2DE359050B74518EBF80A8AC3CAECA600FD6F65BD51A4001216D
          457E7EFE0EFFB31E0188B9428B162D0A8BD683151515AA711C138A583442B021
          438668D480B300F9F9E79F850E53B5F7EF9F2A403B204E7C61146B8E0C60F395
          EAEA534AB5B4B4016ED0A041FA9C79E6331ED80896DDBC78F1E2BFC9E3F6F302
          D8BA756B482686452B4116B2ECEA5FD0B4C4F82FBFFCE23EFFFC739793F36737
          69D2C4B334185BD6181EFF3DBFB575EBEB1B84F3D56A59CB1DAC8172B00E3E53
          5E5E5E3C67CE9CBFC2AEF30278FBEDB7D5026252058033F9A384DFD9D0FCC183
          0785C757A8E6913B10487689D3038124DFEFA23E009DF1EFB5B51115B8BDBD4D
          01B027D4051496110B14CF9E3D7B994C6D3C2F80B7DE7A4B2D0000B481901919
          19674DC4C9A4F416076F7037DCF017D15450054F4A4AF685DC684CE38198F5C8
          215D42F3CC68C55E757511FD0CA52C6AE11B580000D75D775DEF00A416092D59
          B24401E040F00F3F48D4FE6FBFFDE64A4BF7BB9933B3B5CE41CBC9C95E9C378B
          B5B777C4040CC44075FA2C60D6E88C03696E6E51C554579F541F83BEFC8E902B
          7559B124B5DE01BCF1C61B0A40C2A05A80820E27F637C601565FDFE824B48973
          F78B85C064019014CBD89D0A000183C1E4981FD8582036A74369D7D1E1D1A9A3
          A35D01343636E89E681F255E7EF9E5EEBBEFBEEB1B80D75F7F3D2435791C00F5
          909514D6F8EE5966989B32658A0A8D058C3A9E837739ACC769D3BAAD128D85D7
          24B58457A2440540A32638C06001720515AB84E8BE01907CA100CC89018056FC
          8E8CF04D4D2D52C76469790D002F64FA4B8BAE4864001090EE23A33ABDD10AA1
          1B1B9B14406565858E414F2C20079EBEF9801F00663C7AF4E85993E03FA0264F
          9E225565866ADF5F167986E802E0F985F371BFFB7A5D4EEDF941737393D0B34E
          85C70A442209187D8B420680620E009411895108BF282FAFD0426CC890A12AA0
          3F7CFAC328EE0320FF582CF0C481F829D4D2D2ACA1B4A6E68CAEEFAD1D70726E
          2EBEFEFAEB7B07F0EAABAF866EBBEDB6B805A00B61CCDF485E58213373BC4488
          41F172C2F38580960D16FB3DED26397F6E43704FE84E5F3EE8D0101B8DB68BE3
          B66828A5D0B3A40680B973E7F60E406AF0D0D2A54BD5022CCEA1C58A2D6B549A
          72E810005962817415D80B9549B164E6E2631ECF937C65B6C77D737203C31800
          9817899C9132E59493034DBC52ED3380575E792574FBEDB7878577710BF8F300
          1B506DE2DC9CAC323246C4E813F001E97E7EF0FB04A1D313D4C51DDAACC03342
          EEE1C3657A5698346992D65F38313ED027009B376F0EDD71C71DE70440C381A9
          3CE1FFB87199EA6489C2FB29649641DB441A8B561E653CEDB7B545752E0ADFB7
          6FAFAEC9B193B21C5F282D2D2D967372EF005E7EF9E56E00884289272FBE1F39
          7244CD3B6DDA7405624EDC05C4BA8B85D9402C5975F8F8EF94FBDE67121EE7EC
          4AF7C5175F48869FA97B415FCECD32567CD34D375D3880C3870F6B5C4EAC30A9
          FF29A1B3B367A989535307C401F8854770AFCEF7D74276B985623C27F72CD2E6
          76EFFE44859E366D9A8225388C1A354A2D909B9BDB3B804D9B3685EEBCF34E05
          4026FEF1C71F359D2736ACF0EBAFBF6AB1377BF61C3762C4480191E2BC3221E0
          CBCA4912CB9363003A55195D9CF72CC033E69496EE73656587DC55575D15BF1C
          A012350AE5E5E5F50EE0C5175F0CDD75D75D0A00C139229EABF1FCEBAFBF562D
          4996D4E3634A4A6A3CA49A4F5824311F203758EC3727DEB3A7C41D3B7AC40DCB
          18EEE6CC99ABE3AC4322C322FBF6ED2B9E3F7F7EDF00F82DD0531EF037F20196
          206A60F63163C68AE3A56934A1B88322568678F7A2567D76AAA538031C38B01F
          0DBBF4A1434409E9BA46F6CC59EAC8761D2987A6E2050B16F40EE085175E500B
          70B98B86C9C468D6A343773F4010EE7628B8486ED08D8885C9F98BE6ECF86816
          B0730154C2BA12DF3569F19B8A8A7297C27175F020972ED93F2B6B82D65AEC83
          05162E5CD83B800D1B3684EEBEFBEEB0F04F0120A05DA9F4D408A996E838BD91
          1FF80DE5077902F056D7D339C47B562B97CFF51A61004B725445486020C2A1FD
          899207081052856A149283D68501F0DF26F7B5D985959C6155B31C0BEDEC6B1D
          4129D4B2B2B2F4BA1267C51A3FFCF083CE977ACCD50BD065CB96B916F9CE5CF1
          A3626146EF00D6AF5F1F0760D7E4BD5D65243668031084B16EEB90980060F7A5
          76DFC45F72CE679F7DA65414CAE85AE28F7AFE103FFB48EAB4FC810307D650DE
          9C17C03DF7DC1396F018C494761A2392D0ED3B82400DA317F421ED2308390261
          11108A40333ACF381E22308714B4CE18BFE33B82422584C77AF8074DA843ED55
          7FF0E0C1D5DF7CF3CDFF242FB4C909AD6700EBD6AD0BE5E7E7EBCD1C8B21A059
          C2A209DA458300B2BB22A866E0EC2FBFE5568E67FC06107C362B9865E8F60204
          207BF6EC71DF7EFBADD65C942CB49B6FBE999C13F9FEFBEF574B722D94C8D84A
          923D0BC0F3CF3F1FBAF7DE7BC3F2E3A045158444A36816A7226CA25DBEF38C46
          C24130B48A70441940D2988B608C99A5CC9A46250EF1F8CEE4C993F5C2ACA4A4
          4485872E681B9052CC2988B2B2B2D5D20B2550B4E26B6701C002129F83BC89B1
          3B1A36B4C30DB19B8DED96CEB44FF1851076FD68EF064CCB28C15E7E5872E339
          EB412DD6E38507F300BA7BF76ECD0FC88183B36E4E4E0E20EAA48C795A28BE56
          2CD1C69E71008585856A015E7080CE6EC72C2B1A3DA006DDEE70CC0ACC65419B
          6F4E4D3825579845CCA7A016CFB908C6A2FEEB762C0108ACC135278C607F0E3A
          92602322DF6A09C9852247AB5D4407D6AE5D1BBAEFBEFBC212AF83666E7EC466
          A66DBAD1C32E67CD41A1119F19B7D752369F7104B6A86697B916899863EB5A43
          865DBB76D1A342EB80683EC07A505918111105AE16A085B257ABBEF27AEEB9E7
          420505056141A651C804B2F8CD5F1625BAE0640869EF0078C947E56802F95B4F
          6389CFAC364A6C685FF2D311A153BB809F0233F027FC53AC562789F369117E2D
          F125B066CD9AD0FDF7DF1F16AD078912FE372E26001BD9EB56D3BE253B005FEA
          863577EEDCF9D1AA55ABB60BC5FE21FB4DC32FCC0785E611F9FC2F91615D1C80
          8BBD27565E9DE3F5524F09EE52BE1CB7F5091E9F7EFAE9B6E5CB97FF539C364F
          ACFC9428782A0CC0FAB1777327045841E099679E09C9C4FF8A63F4B31BB99E4E
          643DD1E07C73CC8A7D056BEB310767960CBDF5D1471F7D50860648B0582AD1F0
          4951F054EAAE58B9724AE6FE3D306FDEBC252B56AC7876FAF4E9999D5EEB56C7
          D8E289E37E61ECDF0912053FDFEFCEF52C06A0E5E38F3F7EB6A8A8E83F3215AD
          668882970A902725284C9580D4207F37C9F81A6C26A17874AE38C824E7BF5EBB
          8096F832E4629BAD231A3E2D8EBC4B843CE4BC33282D43AAE045E28B8B852947
          E5D916192B43603C354D7AFF8B05F007B456E9BC59F4BF5E42364E5A63A5D74B
          3F2EBDEDFF9CC1088CD0F0C7F60000000049454E44AE426082}
        PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
      end
      object oAll_Ctes: TCheckBox
        Left = 297
        Top = 61
        Width = 127
        Height = 17
        Caption = 'Todos los clientes.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Visible = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Detalle de maquinas'
      ImageIndex = 1
      OnEnter = TabSheet2Enter
      object oJson_Script: TMemo
        Left = 0
        Top = 472
        Width = 1016
        Height = 164
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object DBGridEh2: TDBGridEh
        Left = 0
        Top = 0
        Width = 1016
        Height = 473
        Align = alTop
        DataGrouping.FootersDefValues.ShowFunctionName = True
        DataGrouping.FootersDefValues.RunTimeCustomizable = True
        DataGrouping.GroupLevels = <
          item
          end
          item
            ColumnName = 'Column_0_op_fecha'
          end>
        DataSource = oDs_Qry_Det
        DynProps = <>
        FooterRowCount = 1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        RowPanel.Active = True
        SumList.Active = True
        TabOrder = 1
        Columns = <
          item
            CellButtons = <>
            DisplayFormat = 'dd/mm/yyyy hh:mm am/pm'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_fecha'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footers = <>
            MaxWidth = 127
            MinWidth = 127
            Title.Alignment = taCenter
            Title.Caption = 'Fecha'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 127
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'cte_id'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footers = <>
            MaxWidth = 50
            MinWidth = 50
            Title.Alignment = taCenter
            Title.Caption = 'Cod.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'cte_nombre_loc'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.DisplayFormat = '###0'
            Footer.FieldName = 'cte_id'
            Footer.Value = '0'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Nombre Cliente'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 231
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_chapa'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Chapa'
            Width = 85
          end
          item
            CellButtons = <>
            Color = 9632618
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_colect'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_colect'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            MaxWidth = 85
            MinWidth = 85
            Title.Alignment = taCenter
            Title.Caption = 'Colectado'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 85
          end
          item
            CellButtons = <>
            Color = 10930928
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_impjcj'
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_impjcj'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Imp. J.C.J.'
          end
          item
            CellButtons = <>
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_porc_cons'
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_porc_cons'
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Consesi'#243'n'
          end
          item
            CellButtons = <>
            Color = 9632618
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_tec'
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Serv. T'#233'cnico'
          end
          item
            CellButtons = <>
            Color = 10930928
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_dev'
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Devoluciones'
          end
          item
            CellButtons = <>
            Color = 10930928
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_otros'
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = 'Otros'
          end
          item
            CellButtons = <>
            Color = 10930928
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_cred'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_cred'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            MaxWidth = 85
            MinWidth = 85
            Title.Alignment = taCenter
            Title.Caption = 'Premios'
            Width = 85
          end
          item
            CellButtons = <>
            Color = 9632618
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_tot'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_tot'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            MaxWidth = 85
            MinWidth = 85
            Title.Alignment = taCenter
            Title.Caption = 'Total'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 85
          end
          item
            CellButtons = <>
            Color = 9632618
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_brutoemp'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_brutoemp'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Bruto Emp.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 95
          end
          item
            CellButtons = <>
            Color = 9632618
            DisplayFormat = '##,###,##0.00'
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_tot_netoemp'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.DisplayFormat = '##,###,##0.00'
            Footer.FieldName = 'op_tot_netoemp'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Tahoma'
            Footer.Font.Style = [fsBold]
            Footer.Value = '0.00'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Neto Emp.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
          end
          item
            CellButtons = <>
            Checkboxes = True
            DynProps = <>
            EditButtons = <>
            FieldName = 'op_baja_prod'
            Footer.FieldName = 'op_baja_prod'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Baja Prod.'
            Width = 70
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            Footers = <>
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object oBtnApply_Interfuerza: TPngBitBtn
    Tag = 4
    Left = 361
    Top = 680
    Width = 184
    Height = 57
    Align = alCustom
    BiDiMode = bdLeftToRight
    Caption = 'Aplicar Interfuerza'
    Enabled = False
    ParentBiDiMode = False
    TabOrder = 1
    OnClick = oBtnApply_InterfuerzaClick
    PngImage.Data = {
      89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
      8700000006624B474400FF00FF00FFA0BDA79300000009704859730000004800
      0000480046C96B3E0000000976704167000000300000003000CEEE8C5700000C
      174944415478DAED58097814E5197E6766EFCDB13936896C4212120201924024
      18408B68C07AE20308282AD4B6A815A916115B2AE055AB522A783C1EA5556EA1
      524141010F10041121844B080402C440EE4D36BBD973A6DFFFCF6C0282208A46
      9F87D9E7CB3FD99DD979DFEF7BBFE35F01BFF043686F001709B437808B04DA1B
      C069470C9981EC4A58A083043FDCF49F8CA5BF04020F9035C1E0E8E218559052
      30CA6AB09A4A6B4A576FDDB7F5354BACA5C133CDF33326F02059034C29DD5326
      8E2B18F7C8F559D747980D66ECABDE175CB863E1B277F6BCF3D76E45DD0E943C
      500294FCCC08089304288D8A25A36BC64363F2C74C1ED27588C5A03340A49724
      4838EE3A8E05C5F3BF5CB873D1A4A6694DEB712714CCFDB910F833592322D333
      D3A7DEDDFBEEFB8B328B8C0CB42888ADA6137570795D58B2FBADA3F34B164CA9
      DC52B918C90862767B1378144C36B6EC2ED95347E78E1E3F307DA09E81154481
      7B9FBF44350ACC02213F96EF5BEE7C73C7DCA7CACACB5E122284967623204C21
      D9B895B8ACF4AC67EECABF6B4C614AA12E2C194110B8F1481001FA4F8D84A0A3
      55C0CCCDFF6C99F3E59C47B000B3DB8580EE511D82EE60525E46EED3B7E68EBC
      E352476F4950187C8223A85E3F990C072FE9A017F55877F813BCBC6906CA1A2B
      16054318FBD3121806883902E446A5438F8C6EB3C6F41A3D2C37295750140643
      E29EE6E209EB5FF33EF33C23B0B2F45DBCF9C58BF0FB9C70CA58DCE2C798B313
      607559A1766282C31A692AF0050235C1E6D006FA5FC653E7097E2C81CF1009BC
      9C56D0B9D7CC9179436FCE8ECF16140691BC0F4DF3D08C1160DED70B7A48A284
      B7BF5A8A65257320053D08D1153501BCEE6DC1BDA713B88EEC387DC315888F48
      30F7498DB3DF9C694F19901A9790B6FEC08E4325070EDF08234AF1E4F9E1373E
      6E80CFEDCFC84FCF7D7974AFE1833BC7654251D8278C80C4410BD022C10991E7
      49328CC892DD0BF1C1BE45D4A07DE439CA7B1FCA9A82182B89D8A81248E2A081
      7B116D48D4E525C7C75FDB29EE92419D131CDDD2E33B98E3AD51B01A8DF8B46C
      BBF2DAFA350F7788899D71A4A606DF890435A888440B9A9D9EEEFDB37ACFBE25
      F786ABD26CA91A7802CAC132D094D49C841A011D791EF4DEC29D73B1A16C194C
      420841BAA7C18F3D8D013C9092830F8F6E65293395068D10EC4931D17776B25F
      7263664252CF747B525462A44D30B1662284BD21C1E56FC2CC352B3E3B507AE2
      2644A1FE9C04C601F1BD62505FE1CCB92C23EFD5517937F4ED684B46480607AA
      68C0A1B44987999E7CEDA78BE6EDF837761C5B03B3242340F7D4FA50D2E4C7BD
      4603367BBD7429C9583011884008438B723B2E2CEADCDF1869B46AFA436B22F1
      FA40E706BD80B7B77DE659FAF997234549784F7E5CF976F0BF03520625E2EB5D
      D5855776E93D7B68EEE082A4483B645968F37C1878789509BC6484CBD782B9DB
      E6E060CD6658740A7C24FA5A2F3637F9709FD98A628F4B05CF05284EE71118D5
      B38B61EED05E7DF576532AAFB5CCE32757049E505409CAEB2A31E3FDD56FD496
      34FF1E69D40DCF94CC4380CEF724A37CF3F1BE5764E5BD3A3CAF28C71E194FE0
      D1069C4C61DA5754424C3E06AA0E356E27E615FF07C71B4A60251579097CB507
      EB1ABD98408FDF150AB4815733882444693D322E16F36EE817ADEF69EF87085D
      1C27C1CB186B289C8CA4D669BAF89575EB8E7DBAEDE0AF69E0DD8B27BE017E0A
      F0F05DD762F6A2B583AECECA9F7D53DE155D634C36AE79459634F082069E9110
      34CD9B50E1ACC2FCED73E16A39080B81F710D813CD58EDF2E23ED18032B9812E
      7DFED4C709022320638459C4FCBE7DA0CFCF48449AA58074174104B496AE4581
      3DC8A0D363D3C152BCF6F1C6C9C98931CFEEDB4FC9FCACFA65E2DFE8ABFE0238
      5E305E53989AF3D275D9FD33A2CC51DCF34AD8EBB2D07ACE4C26D391EFCB6A2B
      B0A4E42DF8FDC76022F0CD7E2855CD58D6D48289D4068E28CDF4807F9C1E6C95
      8082016619EFA5A422E2AA7E9478E624249B7BC22C46692D9D7C2FAA1582BD5C
      5E0F5EFF74FDE62D07AA6F8A8F446DCD9F80A85934CAEF80D0E572C3D0FEE93D
      670EE854D0D162B010F8B05C1878B52028A136F00CFE9E1387B062D70A92F209
      0EDEE543A8D285A5CDCD9848DC2AA95C002F9E39D5043E5001095619ABCC165C
      7A4D117930914A9F18872463774448F11C384BE2704EE8A800AFDDB3D3BB6AE7
      CE3192282E918C32CAEA21F549360FCDEFD0FDF9C2D4FC0E669D99006ADE96DB
      0870E95014D867410ACD9ECA2358B9FB7D92501D8C3A7202813FEEC29B4D6E4C
      26CDD7861E3B7BA1E3047AD2492930DD084CEB910FFCAA37C9819E6310CC88D3
      67C026A550529BD46AC44948A874D6E1BFDB37AD28AF73DF7AD403EFC074D3D8
      7C478FBF93D9F5A251AD361CB4A48127D05A0E84281FFC413F76561CC59A3D1F
      C32435528523F05EF849F3AF3478F0984E427D70EAB9DB0C6F648647998A5018
      296065B41DB1C3AE076C117CAEE2F2B18A31889252611113C85366DE29439495
      6BBFDAE6DCF1F591518E980847F784AC677B24768D0B836FF3B8BACADA1A22AF
      BBFD6EECADACC086FD9F33415275A32D8117DE6A375EA8F7E009038DFFBE29E7
      06DF4A402202E49588581DFE47CC8B065E05F4EEA125261B10B59E6014A8238B
      89302381CEA371A8A61A9BCB7795F67264DBBBD83362580BE29ED70033FDABE0
      25BEB279DEE56FC4E1EA3A7C56BA1572D04D0E029C3EB4D4B8F134819F61D4A3
      C5F3C87703DF4AC0FEB87AE295F1A099C6EDE40C60E48D80D9A091105512E11B
      18503D2229192D6868023A4675A25CA384A77711D2B74A8511903532DE8007CD
      01178ED638B1E54031FC3489B1EF6CF4A189C03F5947DEA704F6364FFEEEE05B
      09B0C3329D953AF488D6E30373041CA38602690EF5023E93AB67DAD50A37996E
      600D0821CA3ED90449B14090A9FCCA166E023713793E042F69BE92506E292D41
      8BDBC7FB57A31F0DB51E4CAB72E29508BAAC69D2F9813F85809508B88330C41B
      31CF6AC0887E970B18D48FC1D6F1522740D2062D818357A8A13193A919CB4A90
      2428837022A859884A6528C84AA60136B11BEAA8146EDAB70B2E1A66187DF27C
      4D831793AA9BB1809E17AC7FF0FCC19F4220939A51B5979FDE6633E08D943451
      7FFB9008D84C267A4BC78908DAC84BBED72C4816201A7E32AA7F4A802646A244
      1D3410642474B0A11B9C4E111BF6EE464343300CBEC2E9C5E4AA462C8EA26A5B
      FDC7EF07FE14023C0A547383321CB1667C101F8D1EC3AE8D474E2AFBA94CCFA3
      004D480A87411E27F0323736A77B894E0B999726478A4C500F9B9283BA86003E
      D9B917F5F5217E1725EC51023FA1BC1CCB93526854B8EFFB833F8D809D86A483
      1380F4D978CE6EC543850536DCDCB713954E636B044E9690AC112085730BC243
      E6E6D462945C543534E2C3EDFB515B27F38D0879BE946C7C453D3E4C8C8272EC
      0F3F0CFC6904B2290247049ECCBF4AB06279E73483EDCEC1BD901419A3C9483A
      49422A011A76E92F23D042ABFA33A60DD9F8BABE16EF6FDB4E110872F0D46177
      11F8FB7313B17EE33192EB0FF4FC1909B0C3309DBA640091099178BBA31D8386
      0FCCC165E9DD78895409A8FE67FA6704821AF820074F0D105DA9CE576165F127
      A8A3498C7BDE8F629A6FEE8E89C2D6A32768F377FF85017F4602772C04569187
      7CB4F34989C18B032EED208EE8331826D1CA09A8B7C8BCFAF0C4D5A4C3E46543
      16BE3A7E182B4A56C1D9ECE29B6F57001B09FCF828134AA864E2D06F2F1CF833
      126087FE31BE4BCBA4FC5D9D9769EE346EE00838AC695065A44A28AC7D15BC04
      8B928CE263BBF0EEEE77F8CF806CDEA18AF9913B80097A117B5BA82A95FEE6C2
      82FF56021211A0C9564AE8847F757660EC2D8557A3676221DFD8E8A8F74B923A
      23895A75F20602F8A2FC0B7CB47F2D5A421E56C96864C04A4F10E369C22CDF43
      11F53E7CE1C17F2B0176C4CE60751CC33BDA30FF9258C96831EB093CC580AAA9
      9E8CFDE4A1A75D9444C6085435D550430BB1CDB7D21CC052DA4D3D4443DA31DA
      98A074EC8F03FEAC04A29E211929702447613555A4EEE17928BC86CFA1AD2C2A
      747D883CBF98C04FD489A872FFC8E0CF1E81E780FA1208A98578B94324EEA129
      B115F43749B0D5476589F43EC7E3C714DAEFD415DFF6E3023F2701FB4CC064E4
      9DF9EA181366D1641A4D6015B6D16123B6D4464620C9BB7D32167B8398459F35
      14DFFAD3803F2B014EE279DED444D27D024944CF7240D2E4A2D3566660454B46
      2DADC1DDB7FF74E0CF49E097705C24D0DEC74502ED7DFC1F56BDE17CAF18F7CE
      0000000049454E44AE426082}
    PngOptions = []
  end
  object oBtnExit: TPngBitBtn
    Tag = 8
    Left = 900
    Top = 680
    Width = 109
    Height = 57
    Align = alCustom
    BiDiMode = bdLeftToRight
    Cancel = True
    Caption = 'Salir'
    ParentBiDiMode = False
    TabOrder = 2
    OnClick = oBtnExitClick
    PngImage.Data = {
      89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
      8700000006624B474400FF00FF00FFA0BDA793000000097048597300000B1300
      000B1301009A9C180000000976704167000000300000003000CEEE8C57000013
      634944415478DACD5909781455F2AFEE9E7B26C92493FB6002244012B2842B09
      245C021A0EB945110591530105B9F14665F9AFD7B2A88B220A6AB894FC81059C
      954340301C02096742124212989C93C9643267F74C6FBDEE0E443F3C97FD3E3B
      A974CFA4FBBDFA55FDAA5ED56B0AEEE1B16ADD36F8FE74816CF50BCF8C0C08D0
      3EEBF743127ECD51349C6AB636BDD52BC5987FF487CB30A057CA3D9B93BA5703
      658C5B00A7F2FE4EADDE726A7C8F2E71EB70E84897D7274CA05632E0F1780BCF
      165E9CF6CAAC11E7E53219703EDF9F0B00CFF340258E095BB064F9D6B4C4C8C1
      3F9DC4E9E1E0F8B9A277739F7F70B9317D8CB7E2F4AE3F170061ACE4C9A98F3F
      396B6756D7E804E07F3C89C3EB879D872FEC39B1F6D1270158CBBD9BF4DE1D34
      248C4A9F3C73C1D6DEC931F13F0540E8B4E36081E9DCFA29D3312CAAF12BFE8F
      4EF4BF02C040C7119913A72FCAEDD925C608E0C7D169610281425E0E761F2934
      9DFBE7D419E801F39F1200D3F9C1CCF1D316E6764B200080F8E4F6E1460F984E
      5C349D59F73802F0FE39012892C7648E9EBA2037A54394F1F6C0D28587F5C1A1
      D3574CA7DE9D8C003CE6769D7AF0B7E854EAE3B79E8B5069D4099C0FE40CF86E
      7C73FC42655060806FEDA2E1F70840E274E0AF7D0CAB371F0F4BEF1ADF3FD2A0
      E9E4F3F36C458DBDF04CE1B5FCF609492DD3EF6F270050A78ECF1C3965416E67
      63B808A0CDE8C8203876EEAA29FFCD471080DBBCE48DF5F21123464C0ED469E6
      F979E844FC455350CDB15C5E6945F5C78FE6A4958C7F6221BF73D3BB7F1CC094
      959F40FED92BB2BFAD9CDE3F3E367CA54629CF46662B69A486DFCFB778DCECE7
      DF9DC87F69C2A3231BA2E41413D0FDA1CC9CC716E426C6858914A2EE0CEFF5F1
      70B2E09AE9F89A871080CBBCFD40E1D888A8C88FEB9BBDC17637073C0EAC56D0
      1016A8E4B54AFA4A4DBDEDEDBD07BEDF9E9CDACDB97862DAEF07B078ED7E282A
      A9D04E9D3064568758C3529C3F92A4421E975772C8181A344A9AABBC59B378DC
      80E475642C7DAF4732872280F6D1A1C6D6D15B27607180B3974B4D475F1F3F03
      78A7F5BD3D85EF293541D3588E84825F0808DE2F86854E2D8310ADC2516BB16F
      3EFC7DC1EAFB264CBC35B39B1CFFC3FD3600D3DF390C2545D7421E19D56F4517
      63E85CBC4DEDE5FC68504AB06AEB4364BAF25BB53B97CE9830A3D95C6C37644E
      CE1C3C79616EBB8860A378137DDB09ACCF0F178AAE9B0EAF1A3D137C4ED7CA4F
      4E6C30B68B19EB6545007E5E549E8020D7728602955CE6AFB5B4EC3D77B16861
      F7AC07AEBF383CF0D70164CFFD1C2A2B2A031F1EFBC0AA8CE4C8B92A052313C6
      6E559C12CD4A128C02C3EEF0996B0756CF9C380DB89BB5E1598F670C44003161
      21464171FA0E58168D77F9DA75D3A15746CE04CEC10D5E94F7E1D4D1E9A35C18
      1C0ECC50A8359079C88A2E8A6422FCBD6EB6EE3F927F617E87AE3DAEEF7F7F25
      40D537770710F12D0FB583B314235E7C75D9883E1D9E8F0C562B5BB94CD1AD0F
      884A0569E5D06867E1B50D470E9DDF301F17A7FA5B51FDA7A60F98FCDC960802
      E0760850C2B9C9E583E2D27253FEEB0FCEF47BEC9C6CE0BAF539837A8C9E38C8
      0834D2B1CEE641903E82400040CE7E517F70B859C8BF64FEEADB6FBE9B17903E
      A5D6FE41E25D00C40E04B87904E2A77C317EE2906E1FF5E86808014A323875C7
      030CBA56AF5140798D033ED85504677FB8B01B4EAE9C077E4F4DEC7D4FA6F79B
      BC684B5848B0517C4EF416099B9B3616EAAAAB4C275FCD99C9B9EC5EE8BE7C39
      65E8BAA07D5C083566603CA425E8C1D2EC012709680282FCF8418A391E6E595C
      DCA11FAEBF59B6F9FF56D15953DDFEA3F37F0C20710B0FE5EB5F4B183372F0B6
      077AC5F654213D084F28FC434B770A81AB92C1B705B5B079DF3568A86B7243FD
      C9BFC2E50F3FC03B9A8C436766644D5E9C6B08093212E505C1946573FBC0E2F0
      81B3E1A6E9E8F34366B2CEE616D077CE86C449CB4067CC506AB4F2811971303A
      3B5600402C2EC682088000C2AC07572A9B1A8E9DBA3CD59237733F250597F057
      BBC8028EB70DF21ECFEE7E79DC80A4953106B544774A2C076891F32AA50CF69E
      34C3765331B89BAD366838F72F28DDF611789B0BF0DFAE0E39B333FA3EB63437
      38446FA424EA785109ABD30F9803C0595F653AB064C00C04408AB9185019D221
      6EE87088E83384D6844566F432C2B87EB1587AB3B872FBA558F00BCA939F1617
      0BDF9CA9F8BAE4E0975375133FAD6F592D17014CC51B770C5EF59771A3737666
      A74426901545B420894311845C46C3F1CB16F87CCF657035545540E5DE2FC17C
      F4209AE8120E514BFC9C38F2A9CC3E8F2DCF0DD22300B256F014B4609621CA0B
      5C4600FB9EC99AC13A6CA49853A144A17484D06E19D0E1A18954507C4A76467B
      6A5866343850599F4F02408020085B8B17F69FAB765A6E5D9FEEDE376F3BC875
      3CC5E8E3C1D77443963267FB736306A5FD353A4425108762C47025FA33489D1B
      0D1EF870C70568A8B8560625B91BA1A1E03B9CBC0C8558D34BC2A3CBE8B99999
      539FCF0D080C32F2481D6C01C0DFEA674460AFAD34ED9A933EC3EBB0B5D6420A
      143D4A3B0868D79B4A9A3E5D1991D473D4FD9DA14B8C165C1E9F44239FE08DF2
      5A079C28B680D76EDB6E373D3FCBDF54D62C12C99011366CC19ADC81DDE3872A
      E5B464795AE230562E3E1AB61E288333F917EBA074EB3AA8FECE844F5D47696E
      B3BA30C963E667664C7B215713A437FA850CC0904C7A7BCD6832979BBE7CB207
      A150DB628EB0534740502149FDE99419CFC4744AEE3C6A500750A2117DC4FAB8
      86702867CB9AE03A82F079DD15AEB2A3639CDFBD5D20E417FDA025BD464D7838
      2FB57D68ACC81862795A284E481016DD6C81CF779EF7B6147DBD098A377D8ACF
      1449CAFBDB6461261C17B29C456FE6EAA3A38C4471190D220069452E2B28347D
      35ABF7DDCA69F26F2D4A07A67DCE5865CAA40503FA77D5778E0B441A89ABBFCD
      C9C1C99246210E7C1CE7F5D414CFB6ED79F6732133B69FB476E2889C219FC41A
      B42A90F84F9427C2F134ECCBAF8263A62367A1E0ED57C055775AA2CD4F9B5A46
      86FD40D694E5B943727A1BD55AA5E07E02422103A8BED504FB777D6B3AFF8F89
      0880BB5B392D2C2F784A5166AE589290396474568F5890D3BC00A2A4DA0165C4
      FA18503EECA73D8D556F5AB64D7B993CA4EAF6D4670BEFEB97F146488082A284
      AC43012301B0B979D8B6EF92A7ECE0E637A16CDB26BCBF4AE2FC4F0F461D9FD5
      3D62D0FCCFBBFF25B1CB90F458681FAEC500C6F45761836F4E57C0F52B97B6DF
      D8327B21DE5B0377EF0718B29E32B1D9C3A3063DF3467676D7F060AD0C6C0E16
      2E5535637AE5043044BC4DD55B6BBF78E219024097FEEC9615FDFAF45AA953CB
      05CAD0C83D120332BCBED5E4819DBB8E1799F7BCB0101C15F978BF0DEE7E90C9
      8DEDC7AF7951DFB1C7141D96947A9D5CF042B38B03574B8BBDF6ECBE57AA0EBE
      BF19EF6B849F6F68D4249CC21E7C6B75FAE021F747062BA1ACCE01B5A887A03C
      AED602005B9DA97EF7F259044060FAB35FACEC9399B18C0010A923F29F649F5B
      560FECDEB17BBB396FC14B786F390AFB331393B10C9AF00E7D8DF74D9B61484C
      EBABD4EA02C942EC6EB6D4D5141ED95B7EF093CF7C1EE7459251E1E70F12D411
      A1839E9BD3EBC1292B956AA5ACB2C1052C2B524704C02380EA0335794BE608BC
      4B5FB065457A7AEF655A955C505AA010C30834B23859DFB17D3B5F2BD8B8F07D
      89FBBFD40A92DA2986962992F5C6E4546D586C849F637DCDE6B20ABBB9B410FF
      578C527F97F8F9E911103760CAF0A4714BD6B7B094DEE3E104E5392CBD318085
      8CC435D71CACDEB95804D00B01F4E8D97B1929D0040A11C1E8633098BD3CC517
      5DFAE1D5DD4B47BE83F7DA7F65624A02118C120A62662199AA5952BCF9173CD8
      F650F499FBEE684DD2F08FB1B4082494E1507112C09C4421AEB9F6A079C74211
      40A7E99FAEC8C8CE5A161AA014952731809E20DE402460B159BFDAB178F82C6B
      6589F5374CDE4A039924C4639C6475FFAF3DA83344428BA5463161FDE9653630
      AC72B9BCA2C224FB10EB23003FA655D65A7DB064D3D32280C871EFADE83374E8
      B2D83015D286006084AA53004133C052505571E1F8433B168F39F51B01FCE183
      ACB839F3564587F59FB6ADC6EAEBC7B2DEDB9627DB913ED627D4469EBA8AAF8B
      364C9F270471C0C097E7A78F18F76AA2319821350FF10223794000219703E775
      FC7DD74B9356A44F9CE7FE62F143FF13E53BF7190AC5F907A867F2AE3E51C706
      BFDFD0E4520B814BF8EF95CE0880A678682A29DC5AF2E9134B85342A4B993631
      75F48CF7BAA5C6A9355871B6662012C8844E0C2303B59AA9676DD54FBE3E2C61
      6FBBA4EE50555470CF016CBCC943F189D349DEE0C42DE5B5EE348F97BD431D56
      8A03A4938CE7A0EAE48177AA762D5D236C1E43547676FCB0451BD3B2D2E2741A
      39E8540C569F8C0480788054A3320852D1E73C75D79F9C3022B97048423298CB
      AEDE13C5830CE1B0F6542D949E3E1AA53276FF4749BD6F82D5EE162923595FA0
      10F6A53234A8D7DAE82AFEF7A6E71AF3376C230030F92B3B05E7FCEDDDB4C183
      87EA42F5D8EBD210808D8B46C1E0B54C00406845BC13AAE28F52F69A8573FB19
      CFCF7AFD9FB0E1C5A7FF2BE595387E015A7AEF9E33D1AAD8E435A5567EF2AD46
      0F2D589B58DDC709B411B20F8A4E810179E55259E9AED767BBAACE9D145A6F94
      084DCF39738C7DC7ADE89A912CF7E2A22A430F2810801A0B196CEC41892227C0
      1044B4DA7F51CDD95FAA2E3ABB5F1518E29D3BACE71F52FEE58FF2E0E2B17DF4
      8485AFF7742982579558F9A155562F735B694971F299452F681458A25B1BA1E4
      D4B73B6E7CB9F8451CA2BCB5A50C908576C90AEEBFE89D6E7DD393223AC408B5
      BC0CDB4A19D2889CC90E04A115F14E20B60CED74BC358CF17E41BB6D1BAE7C7F
      E84A426A4FDFB83E9D7F93E26F6DDC0A55C585D490494FC731016193EA58C5EC
      6B8DBEF6E66656B032C7DDA10C890196500735D5D22C945CBADA587168C30ACB
      F9DDFF8F43595A01905DA3F8A03E739F0A4DCD999791D5552E0FD6038B95A84C
      E23F83D949866792A5D009806B1E4469808F55FB2B8364DC3EA5CFBB07BCCE0B
      5835D48744447169C6D01F297DEC874B98FE7CB42E28444F6B023B7B18E50356
      563EF6460B9D5266F33376F71D9A089697AC4EA884490742947EA8BC5E095517
      F2F7946C5FFE1AEF63AFE0B0CE5600E4AC97054667840D5EF67264426A66EF3E
      5D80D70422080AA94328254730142A4F018687004289E51BD66B80CB07842BF9
      16BD8C2FC7CF97D4C015AB68BE1A3D6EA5681ED338A577FBA848272FEBD8C242
      92C54B75363BA9E04A07500D6E10BC2D661956B2BCA838A97FB09B81302CEFAA
      2BCD5059565A59BE7FED2BD6E2E3A4A1226DACBFEDBE10F1425C40E2C091A17D
      672C8D69DF3EA667AF04F06B83C0433C81F421DD1AD67B82E24A3CAB1809884C
      BCC6CA1702B1490C6084CFBC9216575E342E8D8A534D5884636D088D78C6F616
      B03A06B2A7853D0A82F00B8B147BDBFA1C46228FC6F1437555355455991DB74E
      E6ADBFF1CD87A49A2D4571B55A1EDA7881D42E9D42D31F7D24B4E78499619161
      FADE3D3A822A3402EC885581298C0050A3A2E42C78827C264D0B9EC94E0C1152
      57B76E2962E128EC4C7BFDA2A5B1CD050F2A8C1536B8591184708D851A4997AC
      C47DAD8C474A78A1B2C20CE65A0B5B537038AFE8AB351FFA392F290A9BA04DBB
      DDF62019891462295103674F0EED36EC117D484860B7A43888ED100D4E5A21BE
      75244AA3A5D58C084285D7642B80780293D5ED5692F402644782585950DE2F5A
      9B28EEF291971EA2F2E43B225EA40C8D8B9441811DB5CB06A595B56069B4B1B5
      17BFFBFA4ADEDB1BBDF6C6B31275B8B656FFE9410AB0508A66BA46F67D744C64
      EFB10F6BF486D0F8E82048ED1C0B018660E048A941B7F1845C3A4B94222D242D
      9988589F28EFF6498A4BCABBBCE2B553F20079EB1AC0F841EB77424D6D1D54D4
      3581A3B9C579EBDC61D3955DEBB648CA9356F447DDE0CF6DAF93782069A44B58
      5ACE90B8EC490F69238D093A8D92EA18AD87E40E11106C08005A4ECA0E51E156
      30C433C87DC10B64E7DCD3AA6C1B4B3BA56B024EACBFB13CF0B9C162B1C18D3A
      2B34393C5891D6D6941DC9DB536CDABC176943F69EC85E1246D08FFB915F7AC1
      2193E8D4511BD9B157FCA0C7478475C9E8AB0C080AD422676242B5D029460F31
      6101A00F50835225A657B9E411CC4002EF5B9516031541891BD102B7FCC87587
      D30D354D761407B46040B89C0E77757141E1A5BD9FFDCB7CE1386961AF81D84B
      78EEA6E4AFBD6222F148F66C622946D629227540BA316BEC7DC1F1C9C94A9D4E
      4716B6003479945E09D1C16A8808528341A7003DD6532A25A65F748FFF760CF8
      856D7407BAC48E681A9D1EB039BD60473790770F1EA7D3535B7EADB4E8E8DE63
      45DFEE3AE171349342AB4A0AD89F6D827ECB4B3E61E7022504254EA6D4740C4F
      CE4C8DED35B86758C7D42E8161E1E12AB55641566852D7A81464AD20DE60B076
      6284582116F749BE275989BC8FF1E3058BBD624B536393B9E46A49F1F787CE17
      9FF8F77987B5A1046FAB94ACEE845F69827ECF5B4AE20D8D042492A2A8685D44
      BBF8E894F4C4E82E691D43DB25C4E843C30C9AC040AD5AAB562A64321A7F2946
      08781E9743E039CEEBF5389CCE16ABC55A5F556EAEBC5A585E76F6FBD2EAD2AB
      E53ED67B53E27903884DFF6F693DFFD06B56121BA4EF25EF7B82254006994219
      1214116B080A8FD2EB820D3AAD3E58A35028643423A37CAC87F33A1D1E7B63BD
      DD565F6B6BB879C3E276B490AD15B249D02809E997C9E2C4C1EF7887FCDFBC27
      2699522E81D1B611B5F49D5CBA87CCE19714F3484A126AB4486797646DFFEF51
      BCF5F80FB9AC0245468DB03C0000000049454E44AE426082}
    PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
  end
  object oConection: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'CharacterSet=utf8'
      'Server=localhost'
      'User_Name=root'
      'Database=one2009_1')
    LoginPrompt = False
    Left = 8
    Top = 690
  end
  object oScript: TFDScript
    SQLScripts = <>
    Connection = oConection
    ScriptOptions.IgnoreError = True
    ScriptOptions.CommandSeparator = ';'
    ScriptOptions.Verify = True
    Params = <>
    Macros = <>
    Left = 548
    Top = 690
  end
  object ResizeKit1: TResizeKit
    FormPos = rpDefault
    FormWidth = 0
    FormHeight = 0
    FormMaxWidth = 0
    FormMaxHeight = 0
    FormMinWidth = 0
    FormMinHeight = 0
    ResizeFont = False
    Enabled = True
    ValidTaskbar = True
    Left = 601
    Top = 690
    DesignFrmW = 1024
    DesignFrmH = 745
    DesignDpiW = 96
    DesignDpiH = 96
  end
  object oCmdProc: TFDStoredProc
    Connection = oConection
    Left = 655
    Top = 690
  end
  object oDs_Qry_Det: TDataSource
    DataSet = oQry_Det
    Left = 199
    Top = 690
  end
  object oQry_Det: TFDQuery
    Connection = oConection
    SQL.Strings = (
      'SELECT'
      '`id_op`,'
      '`op_emp_id`,'
      '`op_fecha`,'
      '`cte_id`,'
      '`cte_nombre_loc`,'
      '`maqtc_id`,'
      '`op_chapa`,'
      '`jueg_cod`,'
      '`op_nodoc`,'
      '`op_modelo`,'
      '`op_tot_colect`,'
      '`op_tot_impjcj`,'
      '`op_tot_porc_cons`,'
      '`op_tot_tec`,'
      '`op_tot_dev`,'
      '`op_tot_otros`,'
      '`op_tot_cred`,'
      '`op_cal_cred`,'
      '`op_tot_sub`,'
      '`op_tot_itbm`,'
      '`op_tot_tot`,'
      '`op_tot_brutoemp`,'
      '`op_tot_netoemp`,'
      '`op_baja_prod`'
      'FROM '#9'operacion'
      'WHERE (op_aplica_interf =0)'
      'ORDER BY op_emp_id,op_fecha, cte_id, op_chapa'
      'LIMIT 50')
    Left = 263
    Top = 690
  end
  object oDs_Emp: TDataSource
    AutoEdit = False
    DataSet = oQry_Empresa
    Left = 708
    Top = 690
  end
  object oQry_Empresa: TFDQuery
    Connection = oConection
    SQL.Strings = (
      
        'SELECT * FROM empresas where emp_inactivo=0 ORDER BY emp_descrip' +
        'cion')
    Left = 762
    Top = 690
  end
  object oDS_Ctes: TDataSource
    DataSet = oQry_Ctes
    Left = 815
    Top = 690
  end
  object oQry_Ctes: TFDQuery
    Connection = oConection
    SQL.Strings = (
      
        'SELECT ct.cte_id,ct.cte_nombre_loc,ct.cte_nombre_com  FROM clien' +
        'tes ct WHERE ct.cte_inactivo=0 ORDER BY ct.cte_nombre_loc ')
    Left = 869
    Top = 690
  end
  object oDs_Qry_Op: TDataSource
    DataSet = oQry_Op
    Left = 71
    Top = 690
  end
  object oQry_Op: TFDQuery
    Connection = oConection
    SQL.Strings = (
      'SELECT'
      
        '  `id_autoin`, `op_emp_id`, `op_fecha`, `cte_id`, `cte_nombre_lo' +
        'c`, `op_tot_colect`, `op_tot_impjcj`, `op_tot_porc_cons`, `op_to' +
        't_tec`, `op_tot_dev`, `op_tot_otros`, `op_tot_cred`, `op_cal_cre' +
        'd`, `op_tot_sub`, `op_tot_itbm`, `op_tot_tot`,`op_tot_brutoemp`,' +
        ' `op_tot_netoemp`,`op_fact_global`'
      'FROM operaciong op'
      'WHERE (op.op_aplica_interf =0)'
      'AND (op.cte_id="42")'
      
        'AND ((DATE_FORMAT(op.op_fecha, "%Y-%m-%d") >= "2018-02-13") AND ' +
        '(DATE_FORMAT(op.op_fecha, "%Y-%m-%d") <= "2019-02-13"))'
      'ORDER BY op.op_emp_id, op.op_fecha, op.cte_id')
    Left = 135
    Top = 690
  end
end
