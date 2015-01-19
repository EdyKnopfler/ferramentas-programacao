unit MestreDetalhePadraoFormUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadastroPadraoFormUnt, DB, DBCtrls, StdCtrls, Buttons, Grids,
  DBGrids, ExtCtrls, ComCtrls;

type
  TMestreDetalhePadraoForm = class(TCadastroPadraoForm)
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure DSDataChange(Sender: TObject; Field: TField);
    procedure dsDetalhesStateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Alterando: boolean;
  protected
     dsDetalhes: array of TDataSource;
     procedure GravarRegistro; override;
  public
    { Public declarations }
  end;

var
  MestreDetalhePadraoForm: TMestreDetalhePadraoForm;

implementation

{$R *.dfm}

{ TMestreDetalhePadraoForm }

procedure TMestreDetalhePadraoForm.FormCreate(Sender: TObject);
begin
   inherited;
   ControlarTransacao := True;
end;

procedure TMestreDetalhePadraoForm.FormShow(Sender: TObject);
var
   i: integer;
begin
  inherited;

   for i := Low(dsDetalhes) to High(dsDetalhes) do
      dsDetalhes[i].OnStateChange := dsDetalhesStateChange;
end;

procedure TMestreDetalhePadraoForm.btnIncluirClick(Sender: TObject);
begin
   inherited;
   Alterando := False;
end;

procedure TMestreDetalhePadraoForm.btnAlterarClick(Sender: TObject);
begin
   inherited;
   Alterando := True;
end;

procedure TMestreDetalhePadraoForm.GravarRegistro;
var
   i: integer;
begin
   for i := Low(dsDetalhes) to High(dsDetalhes) do
      if dsDetalhes[i].State in [dsInsert, dsEdit] then
         dsDetalhes[i].DataSet.Post;

   inherited;
end;

procedure TMestreDetalhePadraoForm.btnCancelarClick(Sender: TObject);
var
   i: integer;
begin
   inherited;

   // Atualizar os dados detalhe após cancelar a transação
   if Alterando then
   begin
      DS.DataSet.Refresh;

      for i := Low(dsDetalhes) to High(dsDetalhes) do
      begin
         if dsDetalhes[i].DataSet <> nil then
         begin
            dsDetalhes[i].DataSet.Close;
            dsDetalhes[i].DataSet.Open;
         end;
      end;
   end
   else
   begin
      DS.DataSet.Close;
      DS.DataSet.Open;
   end;
end;

procedure TMestreDetalhePadraoForm.DSDataChange(Sender: TObject; Field: TField);
var
   i: integer;
begin
   inherited;

   for i := Low(dsDetalhes) to High(dsDetalhes) do
      dsDetalhes[i].AutoEdit := (DS.State in [dsInsert, dsEdit]);
end;

procedure TMestreDetalhePadraoForm.dsDetalhesStateChange(Sender: TObject);
var
   dsSender: TDataSource;
begin
   dsSender := TDataSource(Sender);

   if dsSender.State = dsInsert then
   begin
      if DS.State = dsBrowse then
      begin
         // Impedir uma grid de incluir quando o registro mestre não está em edição
         dsSender.DataSet.Cancel;
      end
      else if DS.State = dsInsert then
      begin
         // Gravar o registro mestre que está sendo incluído
         dsSender.DataSet.Cancel;
         DS.DataSet.Post;
         DS.DataSet.Edit;
         dsSender.DataSet.Append;
      end;
   end;
end;

procedure TMestreDetalhePadraoForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
   i: integer;
begin
   inherited;

   for i := Low(dsDetalhes) to High(dsDetalhes) do
      dsDetalhes[i].DataSet.Close;
end;

end.
