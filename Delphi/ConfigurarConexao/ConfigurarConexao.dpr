program ConfigurarConexao;

uses
  Forms,
  ConfigurarConexaoFormUnit in 'ConfigurarConexaoFormUnit.pas' {ConfigurarConexaoForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TConfigurarConexaoForm, ConfigurarConexaoForm);
  Application.Run;
end.
