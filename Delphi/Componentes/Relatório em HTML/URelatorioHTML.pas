unit URelatorioHTML;

interface

uses
  SysUtils, Classes, DB, StrUtils, SHDocVw, WinTypes;

type
  TRelatorioHTML = class;
  TDetalhes      = class;
  TItemDetalhe   = class;
  TGrupos        = class;
  TItemGrupo     = class;
  
  TEventoMarca   = procedure (Sender: TObject; const Marca: string; var Conteudo: string)
                   of object;
  TEventoGrupo   = procedure (Sender: TObject; const CampoGrupo: string) of object;

  TRelatorioHTML = class(TComponent)
  private
    { Private declarations }
    GruposNomes, GruposValores: array of string;
    Relatorio: TStrings;

    FCabecalho, FRegistro, FRodape: TStrings;
    FDataSet:  TDataSet;
    FDetalhes: TDetalhes;
    FGrupos:   TGrupos;
    FOnGerandoCabecalho, FOnGerandoRegistro, FOnGerandoRodape: TNotifyEvent;
    FOnMarcaEncontrada: TEventoMarca;
    FOnGrupoIniciando, FOnGrupoFinalizando: TEventoGrupo;

    procedure SetCabecalho(const Value: TStrings);
    procedure SetRegistro(const Value: TStrings);
    procedure SetRodape(const Value: TStrings);
    procedure SetDetalhes(const Value: TDetalhes);
    procedure SetGrupos(const Value: TGrupos);

    function ProcessarMarcas(const HTMLOriginal: string): string;
    function ProcessarCampos(const HTMLOriginal: string): string;
    function GerarRegistros: string;
    procedure AbrirPaginaWeb(Endereco: string);
    procedure InicializarGrupos;
    procedure VerificarGrupos;
    procedure EncerrarGrupos(APartirDe: integer);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function  Gerar: TStrings;
    procedure Salvar(Arquivo: string);
    procedure AbrirNoNavegador;
  published
    { Published declarations }
    property Cabecalho: TStrings  read FCabecalho write SetCabecalho;
    property Registro:  TStrings  read FRegistro  write SetRegistro;
    property Rodape:    TStrings  read FRodape    write SetRodape;
    property DataSet:   TDataSet  read FDataSet   write FDataSet;
    property Detalhes:  TDetalhes read FDetalhes  write SetDetalhes;
    property Grupos:    TGrupos   read FGrupos    write SetGrupos;

    property OnGerandoCabecalho: TNotifyEvent read FOnGerandoCabecalho write FOnGerandoCabecalho;
    property OnGerandoRegistro:  TNotifyEvent read FOnGerandoRegistro  write FOnGerandoRegistro;
    property OnGerandoRodape:    TNotifyEvent read FOnGerandoRodape    write FOnGerandoRodape;
    property OnMarcaEncontrada:  TEventoMarca read FOnMarcaEncontrada  write FOnMarcaEncontrada;
    property OnGrupoIniciando:   TEventoGrupo read FOnGrupoIniciando   write FOnGrupoIniciando;
    property OnGrupoFinalizando: TEventoGrupo read FOnGrupoFinalizando write FOnGrupoFinalizando;
  end;

  TDetalhes = class(TCollection)
  public
     function Add: TItemDetalhe;
  end;

  TItemDetalhe = class(TCollectionItem)
  private
    FRelatorioDetalhe: TRelatorioHTML;
  published
    property RelatorioDetalhe: TRelatorioHTML read FRelatorioDetalhe write FRelatorioDetalhe;
  end;

  TGrupos = class(TCollection)
  public
     function Add: TItemGrupo;
  end;

  TItemGrupo = class(TCollectionItem)
  private
     FCabecalho, FRodape: TStrings;
     FCampo: string;

     procedure SetCabealho(const Value: TStrings);
     procedure SetRodape(const Value: TStrings);
  public
     constructor Create(Collection: TCollection); override;
     destructor Destroy; override;
  published
     property Cabecalho: TStrings read FCabecalho write SetCabealho;
     property Rodape:    TStrings read FRodape    write SetRodape;
     property Campo:     string   read FCampo     write FCampo;
  end;

procedure Register;

implementation

uses Windows;

procedure Register;
begin
  RegisterComponents('Éderson', [TRelatorioHTML]);
end;

const
   GrupoZerado = #0#0#0;

{ TRelatorioHTML }

// Criação e destruição ----------------------------------------------------

constructor TRelatorioHTML.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   Relatorio  := TStringList.Create;
   FCabecalho := TStringList.Create;
   FRegistro  := TStringList.Create;
   FRodape    := TStringList.Create;
   FDetalhes  := TDetalhes.Create(TItemDetalhe);
   FGrupos    := TGrupos.Create(TItemGrupo);
end;

destructor TRelatorioHTML.Destroy;
begin
   Relatorio.Free;
   FCabecalho.Free;
   FRegistro.Free;
   FRodape.Free;
   FDetalhes.Free;
   FGrupos.Free;
   inherited;
end;

// Processamento das strings nas propriedades ------------------------------

// Formato da marca: <$nome_da_marca>
function TRelatorioHTML.ProcessarMarcas(const HTMLOriginal: string): string;
var
   i, f: integer;  // Início e fim da marca
   Nome, Conteudo: string;
begin
   Result := HTMLOriginal;
   i := PosEx('<$', HTMLOriginal, 1);

   while i <> 0 do
   begin
      f := PosEx('>', HTMLOriginal, i + 2);

      if f = 0 then
         Break;

      Nome := Copy(HTMLOriginal, i + 2, f - i - 2);

      if Trim(Nome) <> '' then
      begin
         Conteudo := 'Marca não tratada: <$' + Nome + '>';

         if Assigned(FOnMarcaEncontrada) then
            FOnMarcaEncontrada(Self, Nome, Conteudo);

         Result := StringReplace(Result, '<$' + Nome + '>', Conteudo, [rfReplaceAll,
               rfIgnoreCase]);
      end;

      i := PosEx('<$', HTMLOriginal, f + 1);
   end;
end;

// Formato do campo: <#nome_do_campo>
function TRelatorioHTML.ProcessarCampos(const HTMLOriginal: string): string;
var
   i:     integer;
   Campo: string;
begin
   Result := HTMLOriginal;

   for i := 0 to DataSet.FieldCount - 1 do
   begin
      if Trim(DataSet.Fields[i].DisplayText) = '' then
         Campo := '&nbsp;'
      else
         Campo := Trim(DataSet.Fields[i].DisplayText);

      Result := StringReplace(Result, '<#' + DataSet.Fields[i].FieldName + '>', Campo,
            [rfReplaceAll, rfIgnoreCase]);
   end;
end;

// Geração do relatório ----------------------------------------------------

// Os registros devem ser gerados tanto para a instância corrente quanto para seus detalhes
function TRelatorioHTML.GerarRegistros: string;
var
   i:       integer;
   HTML:    string;
   Detalhe: TStrings;
begin
   DataSet.First;
   InicializarGrupos;

   while not FDataSet.Eof do
   begin
      VerificarGrupos;
      if Assigned(FOnGerandoRegistro) then
         FOnGerandoRegistro(Self);

      HTML := ProcessarMarcas(ProcessarCampos(Registro.Text));
      Relatorio.Add(HTML);

      for i := 0 to Detalhes.Count - 1 do
      begin
         if Assigned(Detalhes.Items[i]) then
         begin
            Detalhe := TItemDetalhe(Detalhes.Items[i]).RelatorioDetalhe.Gerar;
            try
               Relatorio.Add(Detalhe.Text);
            finally
               Detalhe.Free;
            end;
         end;
      end;

      DataSet.Next;
   end;

   if Grupos.Count > 0 then
      EncerrarGrupos(0);
end;

function TRelatorioHTML.Gerar: TStrings;
begin
   Relatorio.Clear;

   if Assigned(FOnGerandoCabecalho) then
      FOnGerandoCabecalho(Self);
   Relatorio.Add(ProcessarMarcas(FCabecalho.Text));

   Relatorio.Add(GerarRegistros);

   if Assigned(FOnGerandoRodape) then
      FOnGerandoRodape(Self);
   Relatorio.Add(ProcessarMarcas(FRodape.Text));

   Result := TStringList.Create;
   Result.Assign(Relatorio);
end;

// Salvamento do HTML e abertura no navegador ------------------------------

procedure TRelatorioHTML.Salvar(Arquivo: string);
var
   HTML: TStrings;
begin
   HTML := Gerar;
   try
      HTML.SaveToFile(Arquivo);
   finally
      HTML.Free;
   end;
end;

procedure TRelatorioHTML.AbrirPaginaWeb(Endereco: string);
var
   Navegador:   TWebBrowser;
   Flags:       OleVariant;
begin
   Navegador := TWebBrowser.Create(nil);
   try
      Flags := navOpenInNewWindow;
      Navegador.Navigate(Endereco, Flags);
   finally
      Navegador.Free;
   end;
end;

procedure TRelatorioHTML.AbrirNoNavegador;
var
   PastaTemp: array[0..256] of char;
   Arquivo:   string;
begin
   GetTempPath(256, PastaTemp);
   Arquivo := StrPas(PastaTemp) + 'Relatorio.html';
   Salvar(Arquivo);
   AbrirPaginaWeb(Arquivo);
end;

// Processamento de grupos -------------------------------------------------

procedure TRelatorioHTML.InicializarGrupos;
var
   i: integer;
begin
   SetLength(GruposNomes, Grupos.Count);
   SetLength(GruposValores, Grupos.Count);

   for i := 0 to Grupos.Count - 1 do
   begin
      GruposNomes[i]   := TItemGrupo(Grupos.Items[i]).Campo;
      GruposValores[i] := GrupoZerado;
   end;
end;

procedure TRelatorioHTML.VerificarGrupos;
var
   i, x:  integer;
   Grupo: TItemGrupo;
begin
   for i := 0 to Grupos.Count - 1 do
   begin
      Grupo := TItemGrupo(Grupos.Items[i]);

      // Iniciando novo grupo!
      if GruposValores[i] <> DataSet.FieldByName(Grupo.Campo).AsString then
      begin
         // Se não era o primeiro grupo, encerrar o anterior
         if GruposValores[i] <> GrupoZerado then
            EncerrarGrupos(i);

         GruposValores[i] := DataSet.FieldByName(Grupo.Campo).AsString;

         // Iniciando novo grupo?? Reiniciar todos os subgrupos!
         for x := i + 1 to Grupos.Count - 1 do
            GruposValores[x] := GrupoZerado;

         // Saída do cabeçalho de grupo
         if Assigned(FOnGrupoIniciando) then
            FOnGrupoIniciando(Self, Grupo.Campo);

         Relatorio.Add(ProcessarMarcas(ProcessarCampos(Grupo.Cabecalho.Text)));
      end;
   end;
end;

procedure TRelatorioHTML.EncerrarGrupos(APartirDe: integer);
var
   i:     integer;
   Grupo: TItemGrupo;
begin
   // Saída do rodapé do grupo e seus subgrupos, a partir do último
   for i := Grupos.Count - 1 downto APartirDe do
   begin
      Grupo := TItemGrupo(Grupos.Items[i]);

      if Assigned(FOnGrupoFinalizando) then
         FOnGrupoFinalizando(Self, Grupo.Campo);

      Relatorio.Add(ProcessarMarcas(ProcessarCampos(Grupo.Rodape.Text)));
   end;
end;

// Propriedades ------------------------------------------------------------

procedure TRelatorioHTML.SetCabecalho(const Value: TStrings);
begin
   FCabecalho.Assign(Value);
end;

procedure TRelatorioHTML.SetDetalhes(const Value: TDetalhes);
begin
   FDetalhes.Assign(Value);
end;       

procedure TRelatorioHTML.SetRegistro(const Value: TStrings);
begin
   FRegistro.Assign(Value);
end;

procedure TRelatorioHTML.SetRodape(const Value: TStrings);
begin
   FRodape.Assign(Value);
end;

procedure TRelatorioHTML.SetGrupos(const Value: TGrupos);
begin
   FGrupos.Assign(Value);
end;

// -------------------------------------------------------------------------

{ TDetalhes }

function TDetalhes.Add: TItemDetalhe;
begin
   Result := TItemDetalhe(inherited Add);
end;

{ TGrupos }

function TGrupos.Add: TItemGrupo;
begin
   Result := TItemGrupo(inherited Add);
end;

{ TItemGrupo }

constructor TItemGrupo.Create(Collection: TCollection);
begin
   inherited Create(Collection);
   FCabecalho := TStringList.Create;
   FRodape    := TStringList.Create;
end;

destructor TItemGrupo.Destroy;
begin
   FCabecalho.Free;
   FRodape.Free;
   inherited Destroy;
end;

procedure TItemGrupo.SetCabealho(const Value: TStrings);
begin
   FCabecalho.Assign(Value);
end;

procedure TItemGrupo.SetRodape(const Value: TStrings);
begin
   FRodape.Assign(Value);
end;

end.
