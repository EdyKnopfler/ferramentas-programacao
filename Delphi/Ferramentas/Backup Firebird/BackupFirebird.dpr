program BackupFirebird;

uses
  Forms,
  UBackupForm in 'UBackupForm.pas' {BackupForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TBackupForm, BackupForm);
  Application.Run;
end.
