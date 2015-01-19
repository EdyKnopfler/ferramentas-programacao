unit CadastroPadraoFormUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, DB, Grids, DBGrids, StdCtrls, Buttons,
  DBCtrls;

type
  TCadastroPadraoForm = class(TForm)
    pcGuias: TPageControl;
    tsListagem: TTabSheet;
    tsDados: TTabSheet;
    pnlListagem: TPanel;
    pnlDadosExterno: TPanel;
    pnlPesquisa: TPanel;
    DS: TDataSource;
    Label1: TLabel;
    edtPesquisa: TEdit;
    pnlDados: TPanel;
    DBN: TDBNavigator;
    Panel1: TPanel;
    DBG: TDBGrid;
    pnlBotoes: TPanel;
    btnIncluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFechar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DSDataChange(Sender: TObject; Field: TField);
    procedure pcGuiasChanging(Sender: TObject; var AllowChange: Boolean);
    procedure btnFecharClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure DBGDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ActiveAntigo:   boolean;
    UltimaPesquisa: string;
  protected
     ControlarTransacao: boolean;

     // Define como o formulário se comporta ao ser realizada uma pesquisa
     procedure Pesquisar(Texto: string); virtual; abstract;

     procedure ConfirmarTransacao; virtual; abstract;
     procedure CancelarTransacao; virtual; abstract;
     procedure GravarRegistro; virtual;
  public
    { Public declarations }
  end;

var
  CadastroPadraoForm: TCadastroPadraoForm;

implementation

uses FuncoesUnt;

{$R *.dfm}

procedure TCadastroPadraoForm.FormShow(Sender: TObject);
begin
   pcGuias.ActivePage := tsListagem;
   ActiveAntigo := DS.DataSet.Active;
   Pesquisar('');  // Pesquisa inicial
   UltimaPesquisa := '';
end;

procedure TCadastroPadraoForm.edtPesquisaChange(Sender: TObject);
begin
   if UltimaPesquisa = Trim(edtPesquisa.Text) then
      Exit;

   UltimaPesquisa := Trim(edtPesquisa.Text);
   Pesquisar(UltimaPesquisa);
end;

procedure TCadastroPadraoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   with DS.DataSet do
   begin
      if State in [dsInsert, dsEdit] then
         GravarRegistro;

      Active := ActiveAntigo;
   end;
end;

procedure TCadastroPadraoForm.DSDataChange(Sender: TObject; Field: TField);
begin
   btnIncluir.Enabled  := (DS.State = dsBrowse);
   btnAlterar.Enabled  := (DS.State = dsBrowse) and (DS.DataSet.RecordCount > 0);
   btnExcluir.Enabled  := (DS.State = dsBrowse) and (DS.DataSet.RecordCount > 0);
   btnGravar.Enabled   := (DS.State in [dsInsert, dsEdit]);
   btnCancelar.Enabled := (DS.State in [dsInsert, dsEdit]);
   DBN.Enabled         := (DS.State = dsBrowse);
end;

procedure TCadastroPadraoForm.pcGuiasChanging(Sender: TObject; var AllowChange: Boolean);
begin
   // Salvar os dados antes de trocar de guia
   if pcGuias.ActivePage = tsDados then
   begin
      if DS.State in [dsInsert, dsEdit] then
      begin
         try
            pcGuias.SetFocus;
            GravarRegistro;
         except
            on E: Exception do
            begin
               AllowChange := False;

               if not (E is EAbort) then
                 Application.ShowException(E);
            end;
         end;
      end;
   end;
end;

procedure TCadastroPadraoForm.btnFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TCadastroPadraoForm.btnIncluirClick(Sender: TObject);
begin
   pcGuias.ActivePage := tsDados;
   DS.DataSet.Append;
end;

procedure TCadastroPadraoForm.btnAlterarClick(Sender: TObject);
begin
   pcGuias.ActivePage := tsDados;
   DS.DataSet.Edit;
end;

procedure TCadastroPadraoForm.btnExcluirClick(Sender: TObject);
begin
   if Application.MessageBox('Deseja mesmo excluir este registro?', 'Excluir', mb_IconQuestion +
      mb_YesNo + mb_DefButton2) = idYes then
   begin
      DS.DataSet.Delete;

      if ControlarTransacao then
         ConfirmarTransacao;

      if DS.DataSet.IsEmpty then
         btnIncluir.SetFocus;
   end;
end;

procedure TCadastroPadraoForm.btnGravarClick(Sender: TObject);
begin
   GravarRegistro;
   btnIncluir.SetFocus;
end;

procedure TCadastroPadraoForm.btnCancelarClick(Sender: TObject);
var
   Incluindo: boolean;
begin
   Incluindo := (DS.State = dsInsert);
   DS.DataSet.Cancel;

   if (not Incluindo) and ControlarTransacao then
      CancelarTransacao;  // Garantir desbloqueio de registros e retorno dos registros detalhe

   btnIncluir.SetFocus;
end;

procedure TCadastroPadraoForm.DBGDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   ZebrarGrid(Sender, Rect, DataCol, Column, State);
end;

procedure TCadastroPadraoForm.GravarRegistro;
begin
   pcGuias.SetFocus;  // Certificar-se da atualização de todos os DataAwares
   DS.DataSet.Post;

   if ControlarTransacao then
      ConfirmarTransacao;
end;

procedure TCadastroPadraoForm.FormCreate(Sender: TObject);
begin
   ControlarTransacao := False;
end;

end.
