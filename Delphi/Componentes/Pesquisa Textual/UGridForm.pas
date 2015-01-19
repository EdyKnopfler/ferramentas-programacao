unit UGridForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ExtCtrls;

type
  TGridForm = class(TForm)
    edtGridLostFocus: TEdit;
    pnlExternalBorder: TPanel;
    pnlInternalBorder: TPanel;
    DS: TDataSource;
    DBGrid: TDBGrid;
    pnlHowToUse: TPanel;
    procedure edtGridLostFocusEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OnChooseRecord: TNotifyEvent;
  end;

var
  GridForm: TGridForm;

implementation

{$R *.dfm}

// Esta grid está escondida atrás do painel principal
procedure TGridForm.edtGridLostFocusEnter(Sender: TObject);
begin
   Self.Hide;
end;

procedure TGridForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   // Alt+F4 must close the form that contains the TTextSearch, as if this were not a real form.
   // So, let's hide this form and pass the Alt+F4 for the first form.
   if (Key = vk_F4) and (ssAlt in Shift) then
      Self.Hide; 
end;

procedure TGridForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #27 then
   begin
      Key := #0;
      Self.Hide;
   end;

   if Key = #13 then
   begin
      Key := #0;

      if DS.DataSet.RecordCount > 0 then
      begin
         if Assigned(OnChooseRecord) then
            OnChooseRecord(Self);

         Self.Hide;
      end;
   end;
end;

procedure TGridForm.DBGridDblClick(Sender: TObject);
begin
   if DS.DataSet.RecordCount > 0 then
   begin
      if Assigned(OnChooseRecord) then
         OnChooseRecord(Self);

      Self.Hide;
   end;
end;

end.
