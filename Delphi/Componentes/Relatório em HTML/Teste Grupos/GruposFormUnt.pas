unit GruposFormUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, DB, mydbUnit,
  FBCustomDataSet, jvuib, StdCtrls, Buttons, URelatorioHTML;

type
  TForm1 = class(TForm)
    trPacientes: TJvUIBTransaction;
    Conexao: TJvUIBDataBase;
    dsetPacientes: TFBDataSet;
    dsetPacientesPRONTUARIO: TIntegerField;
    dsetPacientesNOME: TStringField;
    dsetPacientesCIDADE: TStringField;
    dsPacientes: TDataSource;
    DBGrid1: TDBGrid;
    btnGerar: TBitBtn;
    rhtPacientes: TRelatorioHTML;
    dsetPacientesUF: TStringField;
    procedure btnGerarClick(Sender: TObject);
    procedure rhtPacientesGrupoIniciando(Sender: TObject;
      const CampoGrupo: String);
    procedure rhtPacientesGerandoRegistro(Sender: TObject);
    procedure rhtPacientesMarcaEncontrada(Sender: TObject;
      const Marca: String; var Conteudo: String);
  private
    { Private declarations }
    ContagemUF, ContagemCidade: integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnGerarClick(Sender: TObject);
begin
   dsetPacientes.DisableControls;
   rhtPacientes.AbrirNoNavegador;
   dsetPacientes.EnableControls;
end;

procedure TForm1.rhtPacientesGrupoIniciando(Sender: TObject; const CampoGrupo: String);
begin
   if CampoGrupo = 'UF' then
      ContagemUF := 0
   else if CampoGrupo = 'CIDADE' then
      ContagemCidade := 0;
end;

procedure TForm1.rhtPacientesGerandoRegistro(Sender: TObject);
begin
   Inc(ContagemUF);
   Inc(ContagemCidade);
end;

procedure TForm1.rhtPacientesMarcaEncontrada(Sender: TObject; const Marca: String; var Conteudo: String);
begin
   if Marca = 'total_uf' then
      Conteudo := IntToStr(ContagemUF)
   else if Marca = 'total_cidade' then
      Conteudo := IntToStr(ContagemCidade)
   else if Marca = 'total_geral' then
      Conteudo := IntToStr(dsetPacientes.RecordCount);
end;

end.
