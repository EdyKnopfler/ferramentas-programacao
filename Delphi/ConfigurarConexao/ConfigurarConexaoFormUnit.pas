unit ConfigurarConexaoFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles;

type
  TConfigurarConexaoForm = class(TForm)
    btnAbrir: TBitBtn;
    btnSalvar: TBitBtn;
    Label1: TLabel;
    edtIP: TEdit;
    Label2: TLabel;
    edtArquivo: TEdit;
    Label3: TLabel;
    edtUsuario: TEdit;
    Label4: TLabel;
    edtSenha: TEdit;
    Label5: TLabel;
    edtConfirmarSenha: TEdit;
    odAbrir: TOpenDialog;
    sdSalvar: TSaveDialog;
    procedure CamposEnter(Sender: TObject);
    procedure CamposExit(Sender: TObject);
    procedure CamposKeyPress(Sender: TObject; var Key: Char);
    procedure edtConfirmarSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure btnAbrirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConfigurarConexaoForm: TConfigurarConexaoForm;

implementation

{$R *.dfm}

function Criptografar(Texto: string): string;
var
   i: integer;
begin
   Result := '';

   for i := 1 to Length(Texto) do
      Result := Chr(255 - Ord(Texto[i])) + Result;
end;

procedure TConfigurarConexaoForm.CamposEnter(Sender: TObject);
begin
   TEdit(Sender).Color := $00BFFFFF;
end;

procedure TConfigurarConexaoForm.CamposExit(Sender: TObject);
begin
   TEdit(Sender).Color := clWindow;
end;

procedure TConfigurarConexaoForm.CamposKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(ActiveControl, True, True);
   end;
end;

procedure TConfigurarConexaoForm.edtConfirmarSenhaKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      btnSalvar.Click;
   end;
end;

procedure TConfigurarConexaoForm.btnAbrirClick(Sender: TObject);
var
   Ini: TIniFile;
begin
   if not odAbrir.Execute then
      Exit;

   Ini := TIniFile.Create(odAbrir.FileName);

   try
      edtIP.Text             := Ini.ReadString('Conexao', 'IP', '');
      edtArquivo.Text        := Ini.ReadString('Conexao', 'Arquivo', '');
      edtUsuario.Text        := Ini.ReadString('Conexao', 'Usuario', '');
      edtSenha.Text          := Criptografar(Ini.ReadString('Conexao', 'Senha', ''));
      edtConfirmarSenha.Text := '';
   finally
      FreeAndNil(Ini);
   end;
end;

procedure TConfigurarConexaoForm.btnSalvarClick(Sender: TObject);
var
   Ini: TIniFile;
begin
   if edtConfirmarSenha.Text <> edtSenha.Text then
   begin
      Application.MessageBox('As senhas digitadas não coincidem.', 'Erro', mb_IconError);
      edtSenha.Text          := '';
      edtConfirmarSenha.Text := '';
      edtSenha.SetFocus;
      Exit;
   end;

   if not sdSalvar.Execute then
      Exit;

   Ini := TIniFile.Create(sdSalvar.FileName);

   try
      Ini.WriteString('Conexao', 'IP', edtIP.Text);
      Ini.WriteString('Conexao', 'Arquivo', edtArquivo.Text);
      Ini.WriteString('Conexao', 'Usuario', edtUsuario.Text);
      Ini.WriteString('Conexao', 'Senha', Criptografar(edtSenha.Text));
      Ini.WriteString('Backup', 'ArquivoBackup', ChangeFileExt(edtArquivo.Text, '.fbk'));

      Application.MessageBox(PChar('Dados salvos com sucesso em ' + sdSalvar.FileName + '.'), 'Configurar Conexão',
            mb_IconInformation);
   finally
      FreeAndNil(Ini);
   end;
end;

end.
