program Glyphs;

uses
  Forms,
  GlyphFormUnt in 'GlyphFormUnt.pas' {GlyphForm},
  FuncoesUnt in '..\Units Padrão\FuncoesUnt.pas',
  SmoothResizeUnt in '..\Units Padrão\SmoothResizeUnt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Gerador de Glyphs';
  Application.CreateForm(TGlyphForm, GlyphForm);
  Application.Run;
end.
