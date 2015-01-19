program P1_Grupos;

uses
  Forms,
  GruposFormUnt in 'GruposFormUnt.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
