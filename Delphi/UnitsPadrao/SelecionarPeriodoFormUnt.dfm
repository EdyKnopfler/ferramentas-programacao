object SelecionarPeriodoForm: TSelecionarPeriodoForm
  Left = 192
  Top = 105
  BorderStyle = bsDialog
  Caption = 'SelecionarPeriodoForm'
  ClientHeight = 217
  ClientWidth = 254
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 254
    Height = 217
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 252
      Height = 170
      Align = alClient
      TabOrder = 0
      object Label1: TLabel
        Left = 26
        Top = 94
        Width = 68
        Height = 16
        Caption = 'Data Inicial:'
      end
      object Label2: TLabel
        Left = 26
        Top = 130
        Width = 63
        Height = 16
        Caption = 'Data Final:'
      end
      object Label3: TLabel
        Left = 27
        Top = 22
        Width = 25
        Height = 16
        Caption = 'M'#234's'
      end
      object Label4: TLabel
        Left = 27
        Top = 58
        Width = 23
        Height = 16
        Caption = 'Ano'
      end
      object deInicio: TJvDateEdit
        Left = 108
        Top = 91
        Width = 118
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnKeyPress = cbMesKeyPress
      end
      object deFim: TJvDateEdit
        Left = 108
        Top = 127
        Width = 118
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnKeyPress = cbMesKeyPress
      end
      object cbMes: TComboBox
        Left = 108
        Top = 19
        Width = 118
        Height = 24
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        OnChange = cbMesChange
        OnKeyPress = cbMesKeyPress
        Items.Strings = (
          'Janeiro'
          'Fevereiro'
          'Mar'#231'o'
          'Abril'
          'Maio'
          'Junho'
          'Julho'
          'Agosto'
          'Setembro'
          'Outubro'
          'Novembro'
          'Dezembro')
      end
      object edtAno: TEdit
        Left = 108
        Top = 55
        Width = 64
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnExit = edtAnoExit
        OnKeyPress = edtAnoKeyPress
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 171
      Width = 252
      Height = 45
      Align = alBottom
      TabOrder = 1
      object btnOK: TBitBtn
        Left = 18
        Top = 7
        Width = 100
        Height = 30
        Caption = 'OK'
        TabOrder = 0
        OnClick = btnOKClick
        Glyph.Data = {
          8A060000424D8A060000000000003600000028000000240000000F0000000100
          1800000000005406000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD1E4E5D3E6E7FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFE3E3E3E5E5E5FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFD2E5E537833D337D3AD3E6E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3E3E3666666616161
          E5E5E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFD2E5E5408E4754A35C4F9F57327C38D2E5E6FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          E3E3E3717171868686818181606060E4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD2E6E6499A515BAC6477CA8274
          C87E51A059337D39D2E5E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFE4E4E47C7C7C8E8E8EACACACAAAAAA838383616161E4E4
          E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3E6E651
          A65A63B56D7ECE897BCC8776CA8176C98152A25A347E3AD2E5E6FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4E4E4878787979797B1B1B1AFAF
          AFACACACABABAB848484626262E4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFD3E7E759B0636BBD7684D2907AC98560B26A63B46D78C98378CB82
          53A35C35803BD2E5E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E5E59090
          90A0A0A0B7B7B7ADADAD949494979797ACACACADADAD868686646464E4E4E4FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB6DBC768BA7479C98680CE8D53A75B
          9BCAAA89BF975CAD677CCC8679CB8554A45D37803DD2E5E6FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFD2D2D29D9D9DADADADB3B3B3888888BCBCBCAEAEAE909090AF
          AFAFAEAEAE878787646464E4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          BBDDCC67BB736DC0799FCEAEFFFFFFFFFFFF87BE945EAE687DCD897CCD8756A5
          5F38813ED2E5E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5D5D59D9D9DA3A3A3C0
          C0C0FFFFFFFFFFFFACACAC919191B1B1B1B0B0B0888888656565E4E4E4FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7DDC9A6D5B7FFFFFFFFFFFFFFFFFFFFFF
          FF87BE955FAF697FCE8A7ECE8957A66039833FD2E5E6FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFD4D4D4C8C8C8FFFFFFFFFFFFFFFFFFFFFFFFACACAC929292B2B2B2
          B1B1B1898989676767E4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF87BF9560B06A81CF8D7FCF8B58A76139
          8540D2E5E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFADADAD939393B4B4B4B3B3B38A8A8A696969E4E4E4FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF88
          BF9662B26C82D18F7AC88557A6608BB898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADADAD959595B6B6B6ACAC
          AC898989AAAAAAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF88C09663B36D5FAF698FBF9EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFAEAEAE969696929292B0B0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF89C097
          90C39EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAEAEAEB3B3B3FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        NumGlyphs = 2
      end
      object btnCancelar: TBitBtn
        Left = 133
        Top = 7
        Width = 102
        Height = 30
        Cancel = True
        Caption = 'Cancelar'
        ModalResult = 2
        TabOrder = 1
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          18000000000000060000120B0000120B00000000000000000000FFFFFFFFFFFF
          E9EAF9BEBFEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBEBE
          ECE9E9F9FFFFFFFFFFFFFFFFFFFFFFFFEFEFEFCDCDCDFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFCCCCCCEEEEEEFFFFFFFFFFFFFFFFFFEDEEFA
          424DD50114CC9698E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9696E10000
          C64242CFEDEDFAFFFFFFFFFFFFF2F2F2757575494949AEAEAEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFADADAD3B3B3B6C6C6CF1F1F1FFFFFFE5E6F94554D8
          1548EE1750F9041CD19496E2FFFFFFFFFFFFFFFFFFFFFFFF9494E00202CC0000
          F90000EC4444CFE5E5F8ECECEC7A7A7A7575757D7D7D505050ADADADFFFFFFFF
          FFFFFFFFFFFFFFFFABABAB3E3E3E4A4A4A4747476E6E6EEBEBEBBFC3F00323D2
          2364FC2763FE174EF9071DD29798E3FFFFFFFFFFFF9797E10407CD0000F90000
          FE0000F90000C6BFBFECD0D0D05454548B8B8B8C8C8C7C7C7C515151AFAFAFFF
          FFFFFFFFFFADADAD4242424A4A4A4C4C4C4A4A4A3B3B3BCDCDCDFEFEFF969CE7
          0B2ED82463F92662FE164EF90219D09A9BE49A9BE3000BCE0013F90006FE0000
          F90404CD9696E1FEFEFFFFFFFFB2B2B25D5D5D8A8A8A8B8B8B7C7C7C4D4D4DB1
          B1B1B1B1B14444445656565050504A4A4A404040ADADADFFFFFFFFFFFFFFFFFF
          9499E6072CD62463F92762FE164EF9031AD10116D1062BF90422FE0013F90104
          CC9494E0FFFFFFFFFFFFFFFFFFFFFFFFB0B0B05B5B5B8A8A8A8B8B8B7C7C7C4E
          4E4E4C4C4C6565656161615656563F3F3FABABABFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF969BE7062AD62463F92662FE174FFB1144FB0E3CFE062BF8000BCE9697
          E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB1B1B15A5A5A8A8A8A8B8B8B7D
          7D7D767676727272656565444444ADADADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF999EE7072BD72665FB2560FE1C54FE1144FB0116D1999AE3FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB4B4B45B5B5B8C8C8C8A
          8A8A8181817676764C4C4CB0B0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF999FE90930D82F70FB2F6CFE2460FE1850FB031AD1999AE4FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB5B5B55E5E5E93939392
          92928989897E7E7E4E4E4EB0B0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF969FEB0B39DB3E82F94684FE2F70FB2665FC2661FE164DF90219D09697
          E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB5B5B56565659F9F9FA3A3A393
          93938C8C8C8A8A8A7B7B7B4D4D4DAEAEAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          949EED1044E05193FB5D98FE3D81FB0930D8072BD72463F92662FE164EF9031A
          D19496E2FFFFFFFFFFFFFFFFFFFFFFFFB5B5B56E6E6EACACACB1B1B19F9F9F5E
          5E5E5B5B5B8A8A8A8B8B8B7C7C7C4E4E4EADADADFFFFFFFFFFFFFEFEFF96A4F0
          174FE463A3FB74ABFE5193FB0B39DB9AA0E99A9FE8062AD62463FB2662FE174E
          F9071DD29698E3FEFEFFFFFFFFBABABA767676B7B7B7BFBFBFACACAC656565B6
          B6B6B5B5B55A5A5A8A8A8A8B8B8B7C7C7C515151AEAEAEFFFFFFBFC9F80C4AE7
          77B6FC8FBEFE63A3FC1346E0979FEBFFFFFFFFFFFF979CE70B2DD82463F92762
          FE1750FB0114CCBFC0EED6D6D6737373C5C5C5CDCDCDB8B8B86F6F6FB5B5B5FF
          FFFFFFFFFFB2B2B25D5D5D8A8A8A8B8B8B7E7E7E494949CECECEE5EAFC4871ED
          599BF777B7FC144EE3949FEDFFFFFFFFFFFFFFFFFFFFFFFF9499E6082DD72464
          FB1548EE4450D7E5E6F8EFEFEF929292B0B0B0C6C6C6757575B6B6B6FFFFFFFF
          FFFFFFFFFFFFFFFFB0B0B05C5C5C8B8B8B757575777777ECECECFFFFFFEDF0FD
          456FEC0D4BE696A4F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF969CE70323
          D24352D8EDEEFAFFFFFFFFFFFFF4F4F4909090737373BABABAFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFB2B2B2545454797979F2F2F2FFFFFFFFFFFFFFFFFF
          E9EDFCBEC8F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBEC2
          F0E9EAFAFFFFFFFFFFFFFFFFFFFFFFFFF2F2F2D5D5D5FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFD0D0D0EFEFEFFFFFFFFFFFFF}
        NumGlyphs = 2
      end
    end
  end
end
