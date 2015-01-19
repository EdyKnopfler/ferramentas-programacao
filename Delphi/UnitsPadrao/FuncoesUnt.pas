unit FuncoesUnt;

interface

uses
   // Types, Grids, DBGrids, StdCtrls, Forms, SHDocVw, Classes;
   Types, DBGrids, Grids, Graphics, StdCtrls, SysUtils, Forms, Windows, IniFiles, DB,
   SHDocVw, Controls;

function Criptografar(Texto: string): string;
procedure ZebrarGrid(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
procedure GravarConfiguracao(Arquivo, Secao, Nome, Valor: string);
function LerConfiguracao(Arquivo, Secao, Nome: string): string;
procedure AbrirPaginaWeb(Endereco: string);
function ValidarCPF(CPF: string): boolean;
procedure AvisoEntradaInvalida(Controle: TWinControl; Titulo, Mensagem: string);
procedure VerificarDigitacaoEdit(UmEdit: TCustomEdit; NomeCampo: string);
function LerInteiroEdit(UmEdit: TCustomEdit): integer;
function LerRealEdit(UmEdit: TCustomEdit): double;

implementation

function Criptografar(Texto: string): string;
var
   i: integer;
begin
   Result := '';

   for i := 1 to Length(Texto) do
      Result := Chr(255 - Ord(Texto[i])) + Result;
end;

procedure ZebrarGrid(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
begin
   if not Odd(Column.Field.DataSet.RecNo) then // Se não for par
   begin
      if not (gdSelected in State) then // Se o estado da célula não é selecionado
      begin
         with Sender as TDBGrid do
         begin
             with Canvas do
             begin
                Brush.Color := $00BFFFFF;  // Cor da célula
                FillRect(Rect);            // Pinta a célula
             end;

             // Reescreve o valor que vem do banco de dados
             DefaultDrawDataCell (Rect, Column.Field, State)
          end;
      end;
   end;
end;

procedure GravarConfiguracao(Arquivo, Secao, Nome, Valor: string);
var
   Configuracao: TIniFile;
begin
   Configuracao := TIniFile.Create(Arquivo);

   try
      Configuracao.WriteString(Secao, Nome, Valor);
   finally
      Configuracao.Free;
   end;
end;

function LerConfiguracao(Arquivo, Secao, Nome: string): string;
var
   Configuracao: TIniFile;
begin
   Configuracao := TIniFile.Create(Arquivo);

   try
      Result := Configuracao.ReadString(Secao, Nome, '');
   finally
      Configuracao.Free;
   end;
end;

procedure AbrirPaginaWeb(Endereco: string);
var
   Navegador:   TWebBrowser;
   Flags:       OleVariant;
begin
   Navegador   := TWebBrowser.Create(nil);
   try
      Flags := navOpenInNewWindow;
      Navegador.Navigate(Endereco, Flags);
   finally
      Navegador.Free;
   end;
end;

// Não fui eu que fiz, só dei uma arrumada! :P
function ValidarCPF(CPF: string): boolean;
var
   d1: array[1..9] of byte;
   i, df1, df2, df3, df4, df5, df6, resto1, resto2, primeirodigito, segundodigito : integer;
begin
   Result := True;
   CPF    := StringReplace(CPF, '.', '', [rfReplaceAll]);
   CPF    := StringReplace(CPF, '-', '', [rfReplaceAll]);
   CPF    := Trim(CPF);

   if Length(CPF) <> 11 then
   begin
      Result := False;
      Exit;
   end;

   for i := 1 to 9 do
   begin
      if CPF[i] in ['0'..'9'] then
         d1[i] := StrToInt(CPF[i])
      else
         Result := False;
   end;

   if Result then
   begin
      df1    := 0;
      df2    := 0;
      df3    := 0;
      df4    := 0;
      df5    := 0;
      df6    := 0;
      resto1 := 0;
      resto2 := 0;

      primeirodigito := 0;
      segundodigito  := 0;

      df1    := 10*d1[1] + 9*d1[2] + 8*d1[3] + 7*d1[4] + 6*d1[5] + 5*d1[6] + 4*d1[7] +
                3*d1[8] + 2*d1[9];
      df2    := df1 div 11;
      df3    := df2 * 11;
      resto1 := df1 - df3;

      if (resto1 = 0) or (resto1 = 1) then
         primeirodigito := 0
      else
         primeirodigito := 11 - resto1;

      df4    := 11*d1[1] + 10*d1[2] + 9*d1[3] + 8*d1[4] + 7*d1[5] + 6*d1[6] + 5*d1[7] +
                4*d1[8] + 3*d1[9] + 2*primeirodigito;
      df5    := df4 div 11;
      df6    := df5 * 11;
      resto2 := df4 - df6;

      if (resto2 = 0) or (resto2 = 1) then
           segundodigito := 0
      else
           segundodigito := 11 - resto2;

      if (primeirodigito <> StrToInt(CPF[10])) or (segundodigito <> StrToInt(CPF[11])) then
           Result := False;
   end;
end;

procedure AvisoEntradaInvalida(Controle: TWinControl; Titulo, Mensagem: string);
begin
   Application.MessageBox(PChar(Mensagem), PChar(Titulo), mb_IconWarning);
   Controle.SetFocus;
   Abort;
end;

procedure VerificarDigitacaoEdit(UmEdit: TCustomEdit; NomeCampo: string);
begin
   if Trim(UmEdit.Text) = '' then
      AvisoEntradaInvalida(UmEdit, 'Faltando Dados', 'Favor preencher o campo ' + NomeCampo + '.');
end;

function LerInteiroEdit(UmEdit: TCustomEdit): integer;
begin
   try
      Result := StrToInt(Trim(UmEdit.Text));
   except
      on EConvertError do
         AvisoEntradaInvalida(UmEdit, 'Dado Inválido', '"' + UmEdit.Text + '" não é um valor inteiro válido.');
   end;
end;

function LerRealEdit(UmEdit: TCustomEdit): double;
begin
   try
      Result := StrToFloat(Trim(UmEdit.Text));
   except
      on EConvertError do
         AvisoEntradaInvalida(UmEdit, 'Dado Inválido', '"' + UmEdit.Text + '" não é um valor numérico real válido.');
   end;
end;

end.
