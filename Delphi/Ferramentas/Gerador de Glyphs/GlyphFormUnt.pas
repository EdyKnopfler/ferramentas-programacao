unit GlyphFormUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, Buttons, Jpeg, NGImages;

type
  TGlyphForm = class(TForm)
    opdSelecionar: TOpenPictureDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    btnSelecionar: TBitBtn;
    ScrollBox1: TScrollBox;
    imgResultado: TImage;
    Splitter1: TSplitter;
    ScrollBox2: TScrollBox;
    imgOriginal: TImage;
    spdSalvar: TSavePictureDialog;
    GroupBox1: TGroupBox;
    imgModeloCor: TImage;
    imgModeloPB: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnSalvar: TBitBtn;
    cbAjustar: TComboBox;
    edtMedida: TEdit;
    Label3: TLabel;
    btnGerar: TBitBtn;
    procedure btnSelecionarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    procedure LerImagem;
    procedure Dimensionar(Imagem: TBitmap);
    procedure GerarPB(EmCores, EmPB: TBitmap);
    procedure GerarGlyph(EmCores, EmPB: TBitmap);
  public
    { Public declarations }
  end;

var
  GlyphForm: TGlyphForm;

implementation

uses StrUtils, SmoothResizeUnt, FuncoesUnt;

{$R *.dfm}

procedure TGlyphForm.btnSelecionarClick(Sender: TObject);
begin
   if not opdSelecionar.Execute then
      Exit;

   LerImagem;
   btnGerar.Enabled := True;
end;

procedure TGlyphForm.LerImagem;
var
   NG: TNGImage;
begin
   // Tratar transparência em imagens PNG
   if UpperCase(RightStr(opdSelecionar.FileName, 4)) = '.PNG' then
   begin
      NG := TNGImage.Create;
      try
         NG.Transparent      := True;
         NG.TransparentColor := clWhite;
         NG.LoadFromFile(opdSelecionar.FileName);
         imgOriginal.Picture.Assign(NG);
      finally
         NG.Free;
      end;
   end
   else
      imgOriginal.Picture.LoadFromFile(opdSelecionar.FileName);
end;

procedure TGlyphForm.btnGerarClick(Sender: TObject);
var
   EmCores, EmPB: TBitmap;
begin
   try
      EmCores := TBitmap.Create;
      EmPB    := TBitmap.Create;

      EmCores.Width  := imgOriginal.Picture.Width;
      EmCores.Height := imgOriginal.Picture.Height;
      EmCores.Canvas.Draw(0, 0, imgOriginal.Picture.Graphic);

      if cbAjustar.ItemIndex <> 0 then
         Dimensionar(EmCores);

      GerarPB(EmCores, EmPB);
      GerarGlyph(EmCores, EmPB);
      btnSalvar.Enabled := True;
   finally
      EmCores.Free;
      EmPB.Free;
   end;
end;

procedure TGlyphForm.Dimensionar(Imagem: TBitmap);
var
   Largura, Altura, NovaLargura, NovaAltura: integer;
   Dimensionado: TBitmap;
begin
   Largura := Imagem.Width;
   Altura  := Imagem.Height;

   if cbAjustar.ItemIndex = 1 then  // Ajustar por largura
   begin
      NovaLargura := LerInteiroEdit(edtMedida, 'Gerar Glyph', 'Valor inválido!');
      NovaAltura  := Round(NovaLargura / Largura * Altura);
   end
   else if cbAjustar.ItemIndex = 2 then  // Ajustar por altura
   begin
      NovaAltura  := LerInteiroEdit(edtMedida, 'Gerar Glyph', 'Valor inválido!');
      NovaLargura := Round(NovaAltura / Altura * Largura);
   end
   else
   begin
      NovaLargura := Largura;
      NovaAltura  := Altura;
   end;

   Dimensionado := TBitmap.Create;
   try
      Dimensionado.Width  := NovaLargura;
      Dimensionado.Height := NovaAltura;
      SmoothResize(Imagem, Dimensionado);
      Imagem.Assign(Dimensionado);
   except
      Dimensionado.Free;
   end;
end;

procedure TGlyphForm.GerarPB(EmCores, EmPB: TBitmap);
begin
   // Converter para a paleta tons de cinza 8 bits (desenhando-a sobre o modelo P&B)
   with imgModeloPB.Picture.Graphic do
   begin
      Width  := EmCores.Width;
      Height := EmCores.Height;
   end;

   imgModeloPB.Canvas.Draw(0, 0, EmCores);

   with EmPB do
   begin
      Width  := EmCores.Width;
      Height := EmCores.Height;
      Canvas.Draw(0, 0, imgModeloPB.Picture.Graphic);
   end;
end;

procedure TGlyphForm.GerarGlyph(EmCores, EmPB: TBitmap);
begin
   // Desenhar as imagens sobre o modelo de 24 bits
   with imgModeloCor.Picture.Graphic do  // Preparar a tela de pintura
   begin
      Width       := EmCores.Width * 2 + 4;    // Espaço para acomodar as versões em cores e P&B
      Height      := EmCores.Height + 2;
      Brush.Color := clWhite;
      imgModeloCor.Canvas.FillRect(Rect(0, 0, Width, Height));
   end;

   imgModeloCor.Canvas.Draw(1, 1, EmCores);
   imgModeloCor.Canvas.Draw(EmCores.Width + 3, 1, EmPB);

   imgResultado.Picture.Bitmap := imgModeloCor.Picture.Bitmap;
end;

procedure TGlyphForm.btnSalvarClick(Sender: TObject);
begin
   if spdSalvar.Execute then
      imgResultado.Picture.SaveToFile(spdSalvar.FileName);
end;

end.
