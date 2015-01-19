object GridForm: TGridForm
  Left = 255
  Top = 223
  BorderStyle = bsNone
  ClientHeight = 256
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object edtGridLostFocus: TEdit
    Left = 48
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 1
    OnEnter = edtGridLostFocusEnter
  end
  object pnlExternalBorder: TPanel
    Left = 0
    Top = 0
    Width = 470
    Height = 256
    Align = alClient
    BevelInner = bvRaised
    TabOrder = 0
    object pnlInternalBorder: TPanel
      Left = 2
      Top = 2
      Width = 466
      Height = 252
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 0
      object DBGrid: TDBGrid
        Left = 2
        Top = 2
        Width = 462
        Height = 222
        Align = alClient
        BorderStyle = bsNone
        DataSource = DS
        Options = [dgColumnResize, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = DBGridDblClick
      end
      object pnlHowToUse: TPanel
        Left = 2
        Top = 224
        Width = 462
        Height = 26
        Align = alBottom
        Alignment = taLeftJustify
        Caption = 'Choose and hit Enter, or double-click the name you want.'
        TabOrder = 1
      end
    end
  end
  object DS: TDataSource
    AutoEdit = False
    Left = 154
    Top = 98
  end
end
