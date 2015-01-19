object Form1: TForm1
  Left = 275
  Top = 113
  Width = 696
  Height = 474
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object DBGrid1: TDBGrid
    Left = 9
    Top = 9
    Width = 667
    Height = 388
    DataSource = dsPacientes
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
  end
  object btnGerar: TBitBtn
    Left = 280
    Top = 405
    Width = 127
    Height = 25
    Caption = '&Gerar Relat'#243'rio'
    TabOrder = 1
    OnClick = btnGerarClick
    Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      18000000000000060000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FF6C6A6A6C6A6AFF00FFFF00FF6C6A6A6C6A6AFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF989898989898FF00FFFF
      00FF989898989898FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF6C6A6AAAA7A7A19F9F6C6A6A6C6A6A6C6A6AE5E3E36C6A6A6C6A6A6C6A
      6AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF989898BFBFBFBABABA98989898
      9898989898E1E1E1989898989898989898FF00FFFF00FFFF00FFFF00FFFF00FF
      6C6A6ADAD9D9A19F9FA19F9FA19F9F3736363535356C6D6DBFBFBFE1E2E2B7B6
      B66C6A6A6C6A6A6C6A6AFF00FFFF00FF989898DBDBDBBABABABABABABABABA72
      7272717171999999CCCCCCDFDFDFC7C7C7989898989898989898FF00FF6C6A6A
      D4D3D3CACACA8E8C8C8E8C8C8E8C8C3C3B3B0A090A0707070B0B0B0707077A7A
      7ABBBBBB6C6A6AFF00FFFF00FF989898D7D7D7D3D3D3AEAEAEAEAEAEAEAEAE76
      7676474747454545494949454545A2A2A2CACACA989898FF00FF6C6A6ACACACA
      CACACA8E8C8CD7D4D4CECBCBBFBCBCB1AFAFA3A0A08886865E5B5C0707070909
      090808086C6A6A767373989898D3D3D3D3D3D3AEAEAED9D9D9D3D3D3CBCBCBC3
      C3C3BABABAAAAAAA8E8E8E4545454747474646469898989D9D9D6C6A6ACACACA
      8E8C8CEFEEEEFFFEFEFBFAFAE3E0E1DEDEDEDEDDDDCFCECEBDBCBCADABAB8B89
      895856567A7878757373989898D3D3D3AEAEAEE6E6E6EFEFEFEDEDEDDFDFDFDE
      DEDEDDDDDDD4D4D4CACACAC1C1C1ACACAC8A8A8AA1A1A19D9D9D6C6A6A8E8C8C
      FFFFFFFEFCFCFAFAFAD5D4D5989193A09899B2ABACC4C0C1D7D7D7D8D8D8C7C6
      C6B7B6B6918F8F6C6969989898AEAEAEEFEFEFEFEFEFEDEDEDD8D8D8B3B3B3B7
      B7B7C2C2C2CDCDCDDADADADBDBDBD0D0D0C7C7C7AFAFAF979797FF00FF6C6A6A
      6C6A6AEDEBEBB1A6A77A6F728A83889692959690919D97989A93959E9899BBBA
      BAD1D1D1C2C2C26C6A6AFF00FF989898989898E6E6E6C1C1C19E9E9EAAAAAAB2
      B2B2B1B1B1B6B6B6B4B4B4B7B7B7C9C9C9D7D7D7CECECE989898FF00FFFF00FF
      FF00FF6C6A6ABB897FA7876D8B6F647D67606F62657973798F8B8EA9A3A4CBCA
      CAC1C1C16C6A6AFF00FFFF00FFFF00FFFF00FF989898A7A7A79999998A8A8A9A
      9A9A9696969F9F9FAEAEAEBDBDBDD3D3D3CDCDCD989898FF00FFFF00FFFF00FF
      FF00FFFF00FFBD8281FFE3B4FFD39FE9B281C99973BA916CBD8281807D7E6C6A
      6A6C6A6AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9D3D3D3CCCCCCB8
      B8B8A7A7A79F9F9FA9A9A9A5A5A5989898989898FF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFBD8281FFE0B8FFD3A7FFD09DFFCE90FFC688BD8281FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9D5D5D5CFCFCFCB
      CBCBC6C6C6C3C3C3A9A9A9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFC08683FFE7CFFFE0C0FFD9B2FFD3A5FFD099BD8281FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFABABABDDDDDDD8D8D8D3D3D3CE
      CECECACACAA9A9A9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFBD8281FEEBD8FFE6CCFFDEBDFFD8B1FED3A4BD8281FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9E0E0E0DCDCDCD7D7D7D3
      D3D3CDCDCDA9A9A9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      BD8281FFFFF2FFFFF2FFEBD8FFE5CAFFE1BDF3C7A7BD8281FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9EAEAEAEAEAEAE1E1E1DCDCDCD7
      D7D7CBCBCBA9A9A9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      BD8281BD8281BD8281FBEFE2FBE3CFFBDDC2BD8281FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9A9A9A9A9A9A9E3E3E3DCDCDCD8
      D8D8A9A9A9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFBD8281BD8281BD8281FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9A9A9A9A9
      A9A9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    NumGlyphs = 2
  end
  object trPacientes: TJvUIBTransaction
    DataBase = Conexao
    Options = [tpNowait, tpReadCommitted, tpRecVersion]
    Left = 279
    Top = 207
  end
  object Conexao: TJvUIBDataBase
    Params.Strings = (
      'sql_dialect=3'
      'lc_ctype=NONE'
      'user_name=sysdba'
      'password=masterkey')
    DatabaseName = 'C:\BD\CLINIC_ANTIGO.FDB'
    UserName = 'sysdba'
    PassWord = 'masterkey'
    LibraryName = 'fbclient.dll'
    Connected = True
    Left = 243
    Top = 207
  end
  object dsetPacientes: TFBDataSet
    Active = True
    AutoUpdateOptions.WhenGetGenID = wgNever
    AutoUpdateOptions.IncrementBy = 1
    DefaultFormats.DisplayFormatNumeric = '#,##0.0'
    DefaultFormats.DisplayFormatInteger = '#,##0'
    DefaultFormats.EditFormatNumeric = '#0.0'
    DefaultFormats.EditFormatInteger = '#0'
    DetailConditions = []
    DataBase = Conexao
    Macros = <>
    Option = [poTrimCharFields, poRefreshAfterPost]
    Transaction = trPacientes
    UpdateRecordTypes = [cusUnmodified, cusModified, cusInserted]
    SQLSelect.Strings = (
      'select'
      '   prontuario,'
      '   nome,'
      '   cidade,'
      '   uf'
      'from paciente'
      'order by uf, cidade, nome')
    Left = 315
    Top = 207
    object dsetPacientesPRONTUARIO: TIntegerField
      FieldName = 'PRONTUARIO'
      DisplayFormat = '#,##0'
      EditFormat = '#0'
    end
    object dsetPacientesNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object dsetPacientesCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 72
    end
    object dsetPacientesUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
  end
  object dsPacientes: TDataSource
    DataSet = dsetPacientes
    Left = 351
    Top = 207
  end
  object rhtPacientes: TRelatorioHTML
    Cabecalho.Strings = (
      '<html>'
      ''
      '<head>'
      '   <title>Pacientes por Cidade</title>'
      '   <style type="text/css">'
      '      .traco_abaixo {'
      '         border-bottom: 1px solid black;'
      '      }'
      '   </style>'
      '</head>'
      ''
      '<body>'
      ''
      '<h1>Relat'#243'rio de Pacientes por Cidade</h1>'
      ''
      '<table border="0" cellspacing="0" cellpadding="3">')
    Registro.Strings = (
      '<tr>'
      '   <td><#PRONTUARIO></td>'
      '   <td><#NOME></td>'
      '</tr>')
    Rodape.Strings = (
      '   <tr>'
      '      <td><big><b>TOTAL GERAL:</b></big></td>'
      '      <td><big><$total_geral> paciente(s)</big></td>'
      '   </tr>'
      ''
      '</table>'
      '</body>'
      '</html>')
    DataSet = dsetPacientes
    Detalhes = <>
    Grupos = <
      item
        Cabecalho.Strings = (
          '   <tr>'
          '      <td colspan="2">'
          '         <big><b>Estado:</b> <#UF></big>'
          '      </td>'
          '   </tr>')
        Rodape.Strings = (
          '   <tr>'
          
            '      <td class="traco_abaixo"><big><b>Total estado:</b></big></' +
            'td>'
          
            '      <td class="traco_abaixo"><big><$total_uf> paciente(s)</big' +
            '></td>'
          '   </tr>'
          '   <tr><td>&nbsp;</td></tr>')
        Campo = 'UF'
      end
      item
        Cabecalho.Strings = (
          '<tr>'
          '   <td colspan="2">'
          '      <b>Cidade:</b> <#CIDADE>'
          '   </td>'
          '</tr>'
          ''
          '<tr>'
          '   <td width="100"><b>Prontu'#225'rio</b></td>'
          '   <td><b>Nome</b></td>'
          '</tr>')
        Rodape.Strings = (
          '   <tr>'
          '      <td><b>Total cidade:</b></td>'
          '      <td><$total_cidade> paciente(s)</td>'
          '   </tr>'
          '   <tr><td>&nbsp;</td></tr>')
        Campo = 'CIDADE'
      end>
    OnGerandoRegistro = rhtPacientesGerandoRegistro
    OnMarcaEncontrada = rhtPacientesMarcaEncontrada
    OnGrupoIniciando = rhtPacientesGrupoIniciando
    Left = 450
    Top = 405
  end
end
