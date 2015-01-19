object Form1: TForm1
  Left = 192
  Top = 114
  Width = 409
  Height = 459
  Caption = 'Testando TRelatorioHTML'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 8
    Width = 225
    Height = 25
    DataSource = dsMestre
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
    Flat = True
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 40
    Width = 385
    Height = 145
    DataSource = dsMestre
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Visible = True
      end>
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 200
    Width = 185
    Height = 145
    DataSource = dsDetalhe1
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Nome2'
        Width = 123
        Visible = True
      end>
  end
  object DBGrid3: TDBGrid
    Left = 208
    Top = 200
    Width = 185
    Height = 145
    DataSource = dsDetalhe2
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Valor'
        Width = 123
        Visible = True
      end>
  end
  object DBNavigator2: TDBNavigator
    Left = 8
    Top = 352
    Width = 135
    Height = 25
    DataSource = dsDetalhe1
    VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
    Flat = True
    TabOrder = 4
  end
  object DBNavigator3: TDBNavigator
    Left = 208
    Top = 352
    Width = 135
    Height = 25
    DataSource = dsDetalhe2
    VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
    Flat = True
    TabOrder = 5
  end
  object Button1: TButton
    Left = 148
    Top = 392
    Width = 105
    Height = 25
    Caption = 'Gerar Relat'#243'rio'
    TabOrder = 6
    OnClick = Button1Click
  end
  object cdsMestre: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 80
    Data = {
      4E0000009619E0BD0100000018000000020000000000030000004E0006436F64
      69676F0100490000000100055749445448020002000300044E6F6D6501004900
      000001000557494454480200020019000000}
    object cdsMestreCodigo: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Codigo'
      Size = 3
    end
    object cdsMestreNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
  end
  object cdsDetalhe1: TClientDataSet
    Active = True
    Aggregates = <>
    IndexFieldNames = 'Codigo'
    MasterFields = 'Codigo'
    MasterSource = dsMestre
    PacketRecords = 0
    Params = <>
    OnNewRecord = cdsDetalhe1NewRecord
    Left = 272
    Top = 112
    Data = {
      4F0000009619E0BD0100000018000000020000000000030000004F0006436F64
      69676F0100490000000100055749445448020002000300054E6F6D6532010049
      00000001000557494454480200020019000000}
    object cdsDetalhe1Codigo: TStringField
      FieldName = 'Codigo'
      Size = 3
    end
    object cdsDetalhe1Nome2: TStringField
      DisplayLabel = 'Nome 2'
      FieldName = 'Nome2'
      Size = 25
    end
  end
  object dsMestre: TDataSource
    DataSet = cdsMestre
    Left = 304
    Top = 80
  end
  object dsDetalhe1: TDataSource
    DataSet = cdsDetalhe1
    Left = 304
    Top = 112
  end
  object cdsDetalhe2: TClientDataSet
    Active = True
    Aggregates = <>
    IndexFieldNames = 'Codigo'
    MasterFields = 'Codigo'
    MasterSource = dsMestre
    PacketRecords = 0
    Params = <>
    OnNewRecord = cdsDetalhe2NewRecord
    Left = 272
    Top = 144
    Data = {
      430000009619E0BD010000001800000002000000000003000000430006436F64
      69676F01004900000001000557494454480200020003000556616C6F72080004
      00000000000000}
    object cdsDetalhe2Codigo: TStringField
      FieldName = 'Codigo'
      Size = 3
    end
    object cdsDetalhe2Valor: TFloatField
      FieldName = 'Valor'
      DisplayFormat = '0.00'
      EditFormat = '0.00'
    end
  end
  object dsDetalhe2: TDataSource
    DataSet = cdsDetalhe2
    Left = 304
    Top = 144
  end
  object rMestre: TRelatorioHTML
    Cabecalho.Strings = (
      '<html>'
      ''
      '<head>'
      '<title> Testando TRelatorioHTML </title>'
      '</head>'
      ''
      '<body>'
      '<h1>Relat'#243'rio Exemplo</h1>'
      ''
      '<table cellpadding="0" cellspacing="0" border="0">'
      ''
      '<tr> '
      '   <td width="75"><b>C'#243'digo</b></td>'
      '   <td colspan="2"><b>Nome</b></td>'
      '</tr>')
    Registro.Strings = (
      '<tr>'
      '   <td><#Codigo></td>'
      '   <td><#Nome></td>'
      '</tr>')
    Rodape.Strings = (
      '</table>'
      '</body>'
      '</html>')
    DataSet = cdsMestre
    Detalhes = <
      item
        RelatorioDetalhe = rDetalhe1
      end
      item
        RelatorioDetalhe = rDetalhe2
      end>
    Left = 256
    Top = 392
  end
  object rDetalhe1: TRelatorioHTML
    Cabecalho.Strings = (
      '<tr>'
      '   <td>&nbsp;</td>'
      '   <td colspan="2"><b>Nomes detalhe</b></td>  '
      '</tr>')
    Registro.Strings = (
      '<tr>'
      '   <td>&nbsp;</td>'
      '   <td width="50"><$Contador></td>'
      '   <td width="250"><#Nome2></td>  '
      '</tr>')
    DataSet = cdsDetalhe1
    Detalhes = <>
    OnGerandoCabecalho = rDetalhesGerandoCabecalho
    OnGerandoRegistro = rDetalhesGerandoRegistro
    OnMarcaEncontrada = rDetalhesMarcaEncontrada
    Left = 288
    Top = 392
  end
  object rDetalhe2: TRelatorioHTML
    Cabecalho.Strings = (
      '<tr>'
      '   <td>&nbsp;</td>'
      '   <td colspan="2"><b>Valores  detalhe</b></td>  '
      '</tr>')
    Registro.Strings = (
      '<tr>'
      '   <td>&nbsp;</td>'
      '   <td><$Contador></td>'
      '   <td><#Valor></td>  '
      '</tr>')
    Rodape.Strings = (
      '<tr><td>&nbsp;</td></tr>')
    DataSet = cdsDetalhe2
    Detalhes = <>
    OnGerandoCabecalho = rDetalhesGerandoCabecalho
    OnGerandoRegistro = rDetalhesGerandoRegistro
    OnMarcaEncontrada = rDetalhesMarcaEncontrada
    Left = 320
    Top = 392
  end
end
