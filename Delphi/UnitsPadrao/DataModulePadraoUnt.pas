unit DataModulePadraoUnt;

interface

uses
  SysUtils, Classes, jvuib, DB, jvuibdataset, Forms, Windows, mydbUnit, fbcustomdataset,
  jvuiblib, FuncoesUnt, IniFiles;

type
  TPadraoDM = class(TDataModule)
    BD: TJvUIBDataBase;
    Transacao: TJvUIBTransaction;
    qryUtilidades: TJvUIBQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Abortar(Campo: TField; Mensagem, Titulo: string);
    procedure VerificarCamposObrigatorios(DataSet: TDataSet);
  public
    { Public declarations }
    procedure Bloquear(Tabela, CampoChave: string; Valor: integer;
         Transacao: TJvUIBTransaction);
    procedure ContornarBug(DataSet: TDataSet);
    function ObterCodigo(Gerador: string): integer;
    procedure SalvarSeNecessario(DataSet: TDataSet);
  end;

var
  PadraoDM: TPadraoDM;

implementation

{$R *.dfm}

{ TDM }


procedure TPadraoDM.DataModuleCreate(Sender: TObject);
var
   Ini: TIniFile;
   Arquivo, IP, Usuario, Senha: string;
begin
   Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Conexao.ini');

   try
      try
         Arquivo := Ini.ReadString('Conexao', 'Arquivo', '');
         IP      := Ini.ReadString('Conexao', 'IP', '');
         Usuario := Ini.ReadString('Conexao', 'Usuario', '');
         Senha   := Criptografar(Ini.ReadString('Conexao', 'Senha', ''));

         if IP <> '' then
            BD.DatabaseName := IP + ':' + Arquivo
         else
            BD.DatabaseName := Arquivo;

         BD.UserName     := Usuario;
         BD.PassWord     := Senha;
         BD.Connected    := True;
      except
         on E: Exception do
         begin
            Application.MessageBox(PChar('Erro ao conectar-se ao banco de dados:'#13#13 + E.Message +
                  #13#13'Verifique as configurações de conexão!'), 'Erro', mb_IconError);
            Application.Terminate;
         end;
      end;
   finally
      FreeAndNil(Ini);
   end;
end;

procedure TPadraoDM.DataModuleDestroy(Sender: TObject);
begin
   BD.Connected := False;
end;

procedure TPadraoDM.Abortar(Campo: TField; Mensagem, Titulo: string);
begin
   if Campo <> nil then
      Campo.FocusControl;

   Application.MessageBox(PChar(Mensagem), PChar(Titulo), mb_IconExclamation);
   Abort;
end;

procedure TPadraoDM.VerificarCamposObrigatorios(DataSet: TDataSet);
var
   i: integer;
begin
   for i := 0 to DataSet.FieldCount - 1 do
   begin
      if (DataSet.Fields[i].Required) and (Trim(DataSet.Fields[i].AsString) = '') then
      begin
         DataSet.Fields[i].FocusControl;
         Abortar(DataSet.Fields[i], 'Favor preencher o campo ' + DataSet.Fields[i].DisplayLabel
               + '.', 'Faltando Dados');
      end;
   end;
end;

procedure TPadraoDM.Bloquear(Tabela, CampoChave: string; Valor: integer;
   Transacao: TJvUIBTransaction);
begin
   with qryUtilidades do
      try
         Transaction := Transacao;
         SQL.Text    := 'SELECT * FROM ' + Tabela + ' WHERE ' + CampoChave + ' = ' +
                        IntToStr(Valor) + ' WITH LOCK';
         try
            Open;

            if Eof then
               Abortar(nil, 'Este registro não existe mais no banco de dados!'#13#13 +
                    'Pode ter sido excluído por outro usuário.', 'Erro');
         except
            on E: EUIBError do
            begin
               if E.ErrorCode = 25 then
                  Abortar(nil, 'Este registro está sendo alterado por outro usuário.', 'Erro');
            end;
         end;
      finally
         Close;
         Transaction := Self.Transacao;
      end;
end;

function TPadraoDM.ObterCodigo(Gerador: string): integer;
begin
   with qryUtilidades do
   begin
      Transaction := Transacao;
      SQL.Text := 'SELECT GEN_ID(' + Gerador + ', 1) AS CODIGO FROM RDB$DATABASE';
      Open;
      Result := Fields.ByNameAsInteger['CODIGO'];
      Close;
      Transacao.Commit;
   end;
end;

// Contornar um bug no FBDataSet :(
procedure TPadraoDM.ContornarBug(DataSet: TDataSet);
begin
   with DataSet do
   begin
      if RecordCount = 0 then
      begin
         Close;
         Open;
      end;
   end;
end;

procedure TPadraoDM.SalvarSeNecessario(DataSet: TDataSet);
begin
   with DataSet do
      if State in [dsInsert, dsEdit] then
         Post;
end;

end.
