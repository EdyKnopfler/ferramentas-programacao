unit UBackupForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, jvuib, ComCtrls, ExtCtrls, IniFiles;

type
  TBackupForm = class(TForm)
    Backup: TJvUIBBackup;
    pcGuias: TPageControl;
    tsBackup: TTabSheet;
    Label1: TLabel;
    feBackupFDB: TFilenameEdit;
    Label2: TLabel;
    feBackupFBK: TFilenameEdit;
    tsRestaurar: TTabSheet;
    Label3: TLabel;
    edtHost: TEdit;
    Label4: TLabel;
    edtUsuario: TEdit;
    Label5: TLabel;
    edtSenha: TEdit;
    Restore: TJvUIBRestore;
    btnIniciarBackup: TBitBtn;
    pnlRetorno: TPanel;
    btnIniciarRestauracao: TBitBtn;
    Label6: TLabel;
    feRestaurarFBK: TFilenameEdit;
    Label7: TLabel;
    feRestaurarFDB: TFilenameEdit;
    procedure btnIniciarBackupClick(Sender: TObject);
    procedure BackupVerbose(Sender: TObject; Message: String);
    procedure btnIniciarRestauracaoClick(Sender: TObject);
    procedure RestoreVerbose(Sender: TObject; Message: String);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BackupForm: TBackupForm;

implementation

{$R *.dfm}


// Backup --------------------------------------------------------------------------------------------------------------


procedure TBackupForm.btnIniciarBackupClick(Sender: TObject);
begin
   if feBackupFDB.FileName = '' then
   begin
      Application.MessageBox('Informe o banco de dados!', 'Iniciar Backup', mb_IconExclamation);
      feBackupFDB.SetFocus;
      Exit;
   end;

   if feBackupFBK.FileName = '' then
   begin
      Application.MessageBox('Informe o arquivo de backup!', 'Iniciar Backup', mb_IconExclamation);
      feBackupFBK.SetFocus;
      Exit;
   end;

   with Backup do
   begin
      Host             := edtHost.Text;
      UserName         := edtUsuario.Text;
      PassWord         := edtSenha.Text;
      Database         := feBackupFDB.FileName;
      BackupFiles.Text := feBackupFBK.FileName;
      Run;
      ShowMessage('Backup efetuado com sucesso.');
   end;
end;

procedure TBackupForm.BackupVerbose(Sender: TObject; Message: String);
begin
   pnlRetorno.Caption := Message;
   pnlRetorno.Refresh;
end;


// Restauração ---------------------------------------------------------------------------------------------------------


procedure TBackupForm.btnIniciarRestauracaoClick(Sender: TObject);
begin
   if feRestaurarFBK.FileName = '' then
   begin
      Application.MessageBox('Informe o arquivo de backup!', 'Iniciar Restauração', mb_IconExclamation);
      feRestaurarFBK.SetFocus;
      Exit;
   end;

   if feRestaurarFDB.FileName = '' then
   begin
      Application.MessageBox('Informe o banco de dados!', 'Iniciar Restauração', mb_IconExclamation);
      feRestaurarFDB.SetFocus;
      Exit;
   end;

   if Application.MessageBox(PChar('Confirma a restauração do backup?'#13#13 +
      'ATENÇÃO! Todos os dados atuais serão perdidos.'), 'Iniciar Restauração',
      mb_IconQuestion + mb_YesNo + mb_DefButton2) = idNo then
      Exit;

   with Restore do
   begin
      Host             := edtHost.Text;
      UserName         := edtUsuario.Text;
      PassWord         := edtSenha.Text;
      Database         := feRestaurarFDB.FileName;
      BackupFiles.Text := feRestaurarFBK.FileName;
      Run;
      ShowMessage('Restauração efetuada com sucesso.');
   end;
end;

procedure TBackupForm.RestoreVerbose(Sender: TObject; Message: String);
begin
   pnlRetorno.Caption := Message;
   pnlRetorno.Refresh;
end;


// Outras configurações ------------------------------------------------------------------------------------------------


procedure TBackupForm.FormCreate(Sender: TObject);
var
   Configuracao: TIniFile;
begin
   pcGuias.ActivePage       := tsBackup;
   Configuracao             := TIniFile.Create(ExtractFilePath(Application.ExeName) +
                               'BackupFirebird.ini');
   try
      edtHost.Text            := Configuracao.ReadString('Backup', 'Host', '');
      feBackupFDB.FileName    := Configuracao.ReadString('Backup', 'FDB', '');
      feRestaurarFDB.FileName := Configuracao.ReadString('Backup', 'FDB', '');
      feBackupFBK.FileName    := Configuracao.ReadString('Backup', 'FBK', '');
      feRestaurarFBK.FileName := Configuracao.ReadString('Backup', 'FBK', '');

   finally
      Configuracao.Free;
   end;
end;

end.
