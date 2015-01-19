object BackupForm: TBackupForm
  Left = 281
  Top = 117
  Width = 496
  Height = 295
  Caption = 'Utilit'#225'rio de Backup (Firebird)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 16
    Top = 19
    Width = 25
    Height = 13
    Caption = 'Host:'
  end
  object Label4: TLabel
    Left = 180
    Top = 19
    Width = 39
    Height = 13
    Caption = 'Usu'#225'rio:'
  end
  object Label5: TLabel
    Left = 344
    Top = 19
    Width = 34
    Height = 13
    Caption = 'Senha:'
  end
  object pcGuias: TPageControl
    Left = 16
    Top = 72
    Width = 457
    Height = 153
    ActivePage = tsRestaurar
    TabOrder = 3
    object tsBackup: TTabSheet
      Caption = 'Efetuar Backup'
      object Label1: TLabel
        Left = 16
        Top = 19
        Width = 81
        Height = 13
        Caption = 'Banco de dados:'
      end
      object Label2: TLabel
        Left = 16
        Top = 51
        Width = 93
        Height = 13
        Caption = 'Arquivo de backup:'
      end
      object feBackupFDB: TFilenameEdit
        Left = 120
        Top = 16
        Width = 313
        Height = 21
        DefaultExt = 'fdb'
        Filter = 'Bancos de dados do Firebird|*.fdb'
        DialogOptions = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
        DialogTitle = 'Selecionar Banco de Dados'
        NumGlyphs = 1
        TabOrder = 0
      end
      object feBackupFBK: TFilenameEdit
        Left = 120
        Top = 48
        Width = 313
        Height = 21
        DialogKind = dkSave
        DefaultExt = 'fbk'
        Filter = 'Arquivos de backup do Firebird|*.fbk'
        DialogOptions = [ofHideReadOnly, ofPathMustExist, ofEnableSizing, ofDontAddToRecent]
        DialogTitle = 'Criar Arquivo de Backup'
        NumGlyphs = 1
        TabOrder = 1
      end
      object btnIniciarBackup: TBitBtn
        Left = 184
        Top = 88
        Width = 81
        Height = 25
        Caption = '&Iniciar'
        TabOrder = 2
        OnClick = btnIniciarBackupClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00370777033333
          3330337F3F7F33333F3787070003333707303F737773333373F7007703333330
          700077337F3333373777887007333337007733F773F333337733700070333333
          077037773733333F7F37703707333300080737F373333377737F003333333307
          78087733FFF3337FFF7F33300033330008073F3777F33F777F73073070370733
          078073F7F7FF73F37FF7700070007037007837773777F73377FF007777700730
          70007733FFF77F37377707700077033707307F37773F7FFF7337080777070003
          3330737F3F7F777F333778080707770333333F7F737F3F7F3333080787070003
          33337F73FF737773333307800077033333337337773373333333}
        NumGlyphs = 2
      end
    end
    object tsRestaurar: TTabSheet
      Caption = 'Restaurar'
      ImageIndex = 1
      object Label6: TLabel
        Left = 16
        Top = 19
        Width = 93
        Height = 13
        Caption = 'Arquivo de backup:'
      end
      object Label7: TLabel
        Left = 16
        Top = 51
        Width = 73
        Height = 13
        Caption = 'Restaurar para:'
      end
      object btnIniciarRestauracao: TBitBtn
        Left = 184
        Top = 88
        Width = 81
        Height = 25
        Caption = '&Iniciar'
        TabOrder = 2
        OnClick = btnIniciarRestauracaoClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00370777033333
          3330337F3F7F33333F3787070003333707303F737773333373F7007703333330
          700077337F3333373777887007333337007733F773F333337733700070333333
          077037773733333F7F37703707333300080737F373333377737F003333333307
          78087733FFF3337FFF7F33300033330008073F3777F33F777F73073070370733
          078073F7F7FF73F37FF7700070007037007837773777F73377FF007777700730
          70007733FFF77F37377707700077033707307F37773F7FFF7337080777070003
          3330737F3F7F777F333778080707770333333F7F737F3F7F3333080787070003
          33337F73FF737773333307800077033333337337773373333333}
        NumGlyphs = 2
      end
      object feRestaurarFBK: TFilenameEdit
        Left = 120
        Top = 16
        Width = 313
        Height = 21
        DefaultExt = 'fbk'
        Filter = 'Arquivos de backup do Firebird|*.fbk'
        DialogOptions = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
        DialogTitle = 'Selecionar Arquivo de Backup'
        NumGlyphs = 1
        TabOrder = 0
      end
      object feRestaurarFDB: TFilenameEdit
        Left = 120
        Top = 48
        Width = 313
        Height = 21
        DialogKind = dkSave
        DefaultExt = 'fdb'
        Filter = 'Bancos de dados do Firebird|*.fdb'
        DialogOptions = [ofHideReadOnly, ofPathMustExist, ofEnableSizing, ofDontAddToRecent]
        DialogTitle = 'Salvar Banco de Dados'
        NumGlyphs = 1
        TabOrder = 1
      end
    end
  end
  object edtHost: TEdit
    Left = 16
    Top = 35
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edtUsuario: TEdit
    Left = 180
    Top = 35
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'SYSDBA'
  end
  object edtSenha: TEdit
    Left = 344
    Top = 35
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = 'masterkey'
  end
  object pnlRetorno: TPanel
    Left = 0
    Top = 243
    Width = 488
    Height = 23
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    TabOrder = 4
  end
  object Backup: TJvUIBBackup
    Protocol = proTCPIP
    LibraryName = 'fbclient.dll'
    OnVerbose = BackupVerbose
    Verbose = True
    Left = 56
    Top = 184
  end
  object Restore: TJvUIBRestore
    Protocol = proTCPIP
    LibraryName = 'fbclient.dll'
    OnVerbose = RestoreVerbose
    Verbose = True
    Options = [roNoValidityCheck, roReplace, roCreateNewDB]
    Left = 96
    Top = 184
  end
end
