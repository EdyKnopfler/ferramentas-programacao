unit SelecionarPeriodoFormUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, JvExMask, JvToolEdit, ExtCtrls;

type
  TSelecionarPeriodoForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnOK: TBitBtn;
    btnCancelar: TBitBtn;
    Label1: TLabel;
    deInicio: TJvDateEdit;
    Label2: TLabel;
    deFim: TJvDateEdit;
    Label3: TLabel;
    cbMes: TComboBox;
    edtAno: TEdit;
    Label4: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbMesChange(Sender: TObject);
    procedure edtAnoKeyPress(Sender: TObject; var Key: Char);
    procedure edtAnoExit(Sender: TObject);
    procedure cbMesKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SelecionarData;
  public
    { Public declarations }
  end;

var
  SelecionarPeriodoForm: TSelecionarPeriodoForm;

implementation

{$R *.dfm}

uses
   FuncoesUnt;

procedure TSelecionarPeriodoForm.FormShow(Sender: TObject);
var
   Ano, Mes, Dia: word;
begin
   DecodeDate(Date, Ano, Mes, Dia);
   cbMes.ItemIndex := Mes - 1;
   edtAno.Text     := IntToStr(Ano);
   SelecionarData;
end;

procedure TSelecionarPeriodoForm.cbMesChange(Sender: TObject);
begin
   SelecionarData;
end;

procedure TSelecionarPeriodoForm.edtAnoKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      deInicio.SetFocus;
      Exit;
   end;

   if not (Key in [#8, '0'..'9']) then
      Key := #0;
end;

procedure TSelecionarPeriodoForm.cbMesKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      SelectNext(ActiveControl, True, True);
   end;
end;

procedure TSelecionarPeriodoForm.edtAnoExit(Sender: TObject);
begin
   SelecionarData;
end;

procedure TSelecionarPeriodoForm.SelecionarData;
var
   Ano, DiasFevereiro: integer;
   DiasNosMeses: variant;
begin
   Ano := LerInteiroEdit(edtAno);

   if IsLeapYear(Ano) then
      DiasFevereiro := 29
   else
      DiasFevereiro := 28;

   DiasNosMeses  := VarArrayOf([31, DiasFevereiro, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]);
   deInicio.Date := EncodeDate(Ano, cbMes.ItemIndex + 1, 1);
   deFim.Date    := EncodeDate(Ano, cbMes.ItemIndex + 1, DiasNosMeses[cbMes.ItemIndex]);
end;

procedure TSelecionarPeriodoForm.btnOKClick(Sender: TObject);
begin
   if deInicio.Date > deFim.Date then
   begin
      Application.MessageBox('A data inicial não deve ser posterior à final.', 'Erro',
            mb_IconExclamation);
      deFim.SetFocus;
      Exit;
   end;

   ModalResult := mrOk;
end;

end.
