program Glyphs;

uses
  Forms,
  GlyphFormUnt in 'GlyphFormUnt.pas' {GlyphForm},
  FuncoesUnt in '..\Units Padr�o\FuncoesUnt.pas',
  SmoothResizeUnt in '..\Units Padr�o\SmoothResizeUnt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Gerador de Glyphs';
  Application.CreateForm(TGlyphForm, GlyphForm);
  Application.Run;
end.
