unit UTesteForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, DBCtrls, DB, DBClient,
  URelatorioHTML;

type
  TForm1 = class(TForm)
    cdsMestre: TClientDataSet;
    cdsMestreCodigo: TStringField;
    cdsMestreNome: TStringField;
    cdsDetalhe1: TClientDataSet;
    cdsDetalhe1Codigo: TStringField;
    cdsDetalhe1Nome2: TStringField;
    dsMestre: TDataSource;
    dsDetalhe1: TDataSource;
    cdsDetalhe2: TClientDataSet;
    dsDetalhe2: TDataSource;
    cdsDetalhe2Codigo: TStringField;
    cdsDetalhe2Valor: TFloatField;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBNavigator2: TDBNavigator;
    DBNavigator3: TDBNavigator;
    Button1: TButton;
    rMestre: TRelatorioHTML;
    rDetalhe1: TRelatorioHTML;
    rDetalhe2: TRelatorioHTML;
    procedure cdsDetalhe1NewRecord(DataSet: TDataSet);
    procedure cdsDetalhe2NewRecord(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure rDetalhesGerandoCabecalho(Sender: TObject);
    procedure rDetalhesGerandoRegistro(Sender: TObject);
    procedure rDetalhesMarcaEncontrada(Sender: TObject;
      const Marca: String; var Conteudo: String);
  private
    { Private declarations }
    Contador: integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.cdsDetalhe1NewRecord(DataSet: TDataSet);
begin
   if cdsMestre.IsEmpty then
      DataSet.Cancel
   else if cdsMestre.State = dsInsert then
      cdsMestre.Post;
end;

procedure TForm1.cdsDetalhe2NewRecord(DataSet: TDataSet);
begin
   cdsDetalhe1NewRecord(DataSet);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   rMestre.AbrirNoNavegador;
end;

procedure TForm1.rDetalhesGerandoCabecalho(Sender: TObject);
begin
   Contador := 0;
end;

procedure TForm1.rDetalhesGerandoRegistro(Sender: TObject);
begin
   Inc(Contador);
end;

procedure TForm1.rDetalhesMarcaEncontrada(Sender: TObject; const Marca: String;
   var Conteudo: String);
begin
   if Marca = 'Contador' then
      Conteudo := IntToStr(Contador);
end;

end.
