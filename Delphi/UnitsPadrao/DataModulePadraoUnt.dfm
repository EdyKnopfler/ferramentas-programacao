object PadraoDM: TPadraoDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 221
  Top = 102
  Height = 128
  Width = 312
  object BD: TJvUIBDataBase
    Params.Strings = (
      'sql_dialect=3'
      'lc_ctype=WIN1252'
      'user_name=sysdba'
      'password=masterkey')
    CharacterSet = csWIN1252
    UserName = 'sysdba'
    PassWord = 'masterkey'
    LibraryName = 'fbclient.dll'
    Left = 48
    Top = 24
  end
  object Transacao: TJvUIBTransaction
    DataBase = BD
    Options = [tpNowait, tpReadCommitted, tpRecVersion]
    Left = 128
    Top = 24
  end
  object qryUtilidades: TJvUIBQuery
    Transaction = Transacao
    DataBase = BD
    OnError = etmStayIn
    Left = 208
    Top = 24
  end
end
