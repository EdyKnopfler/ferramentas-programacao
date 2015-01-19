unit UTextSearch;

interface

uses
   SysUtils, Classes, Controls, StdCtrls, ExtCtrls, DBGrids, Types, Windows,
   UGridForm, JvUIB, JvUIBDataSet, DB, Messages, Forms;

type
   TTextSearch = class(TEdit)
   private
      FormGrid: TGridForm;
      DataSet:  TJvUIBDataSet;

      HasFocus:         boolean;
      ChangingByItself: boolean;
      LastGeneratedSQL: string;

      // Properties ---------------------------------------
      FGridFieldNames:   TStrings;
      FGridFieldWidths:  TStrings;
      FGridFieldFormats: TStrings;
      FDataBase:         TJvUIBDataBase;
      FTransaction:      TJvUIBTransaction;
      FTableName:        string;
      FKeyField:         string;
      FSearchField:      string;
      FExtraFilter:      string;
      FKeyFieldLabel:    TLabel;
      FUseSQLUpper:      boolean;
      FHowToUseMessage:  string;
      FPopupWidth:       integer;
      FPopupHeight:      integer;
      FSelectedKey:      variant;
      FHasSelected:      boolean;
      FSQLSelect:        string;
      FOnSelectRecord:         TNotifyEvent;

      procedure SetGridFieldNames(G: TStrings);
      procedure SetGridFieldWidths(G: TStrings);
      procedure SetGridFieldFormats(G: TStrings);
      procedure SetDataBase(D: TJvUIBDataBase);
      procedure SetTransaction(T: TJvUIBTransaction);
      procedure GenerateNewSQLSelect;

      // What message params do we need to put the focus back to this component after showing the grid?
      //procedure DiscoverMessageParams(var msg: TMessage); message wm_mouseactivate;

   protected
      procedure CreateGrid; virtual;
      procedure ShowGrid; virtual;
      procedure HideGrid; virtual;
      procedure RecordChosen(Sender: TObject); virtual;
      procedure DoOnSelectRecord(Sender: TObject); virtual;
      procedure Change;  override;
      procedure DoEnter; override;
      procedure DoExit;  override;
      procedure KeyPress(var Key: Char); override;
      procedure KeyDown(var Key: Word; Shift: TShiftState); override;
   public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;

      procedure PutData(NewText: string; NewSelectedKey: variant);
      procedure ClearData;
      function  FieldValue(FieldName: string): variant;

      property SelectedKey: variant read FSelectedKey;
      property HasSelected: boolean read FHasSelected;
      property SQLSelect:   string  read FSQLSelect;  // Know what's the generated SELECT! ;)
   published
      property zGridFieldNames:   TStrings read FGridFieldNames   write SetGridFieldNames;
      property zGridFieldWidths:  TStrings read FGridFieldWidths  write SetGridFieldWidths;
      property zGridFieldFormats: TStrings read FGridFieldFormats write SetGridFieldFormats;

      property zDataBase:        TJvUIBDataBase    read FDataBase        write SetDataBase;
      property zTransaction:     TJvUIBTransaction read FTransaction     write SetTransaction;
      property zTableName:       string            read FTableName       write FTableName;
      property zKeyField:        string            read FKeyField        write FKeyField;
      property zSearchField:     string            read FSearchField     write FSearchField;
      property zExtraFilter:     string            read FExtraFilter     write FExtraFilter;
      property zUseSQLUpper:     boolean           read FUseSQLUpper     write FUseSQLUpper;
      property zKeyFieldLabel:   TLabel            read FKeyFieldLabel   write FKeyFieldLabel;
      property zHowToUseMessage: string            read FHowToUseMessage write FHowToUseMessage;
      property zPopupWidth:      integer           read FPopupWidth      write FPopupWidth;
      property zPopupHeight:     integer           read FPopupHeight     write FPopupHeight;
      property zOnSelectRecord:  TNotifyEvent      read FOnSelectRecord  write FOnSelectRecord;
   end;

procedure Register;

implementation

uses Variants;

procedure Register;
begin
   RegisterComponents('Éderson', [TTextSearch]);
end;


// Configuration -------------------------------------------------------------------------------


constructor TTextSearch.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   DataSet := TJvUIBDataSet.Create(Self);
   DataSet.BufferChunks := 100;
   DataSet.OnClose      := etmStayIn;

   FGridFieldNames   := TStringList.Create;
   FGridFieldWidths  := TStringList.Create;
   FGridFieldFormats := TStringList.Create;

   FSelectedKey     := Null;
   FPopupWidth      := 300;
   FPopupHeight     := 200;
   FHowToUseMessage := 'Select and press Enter.';
end;

destructor TTextSearch.Destroy;
begin
   FGridFieldNames.Free;
   FGridFieldWidths.Free;
   FGridFieldFormats.Free;
   FormGrid.Free;
   DataSet.Free;
   inherited;
end;


// Events --------------------------------------------------------------------------------------


procedure TTextSearch.Change;
var
   i, FieldIndex, CursorPos: integer;
begin
   // Consider that, if the user edit the control, no record is selected until he presses
   // Enter.
   if Assigned(FKeyFieldLabel) then
      FKeyFieldLabel.Caption := '';
   FHasSelected := False;
   FSelectedKey := Null;

   // Is this component updating itself? So, do NOT response to changes, please!
   if ChangingByItself or (not HasFocus) then
      Exit;

   if (DataSet.Database = nil) or (DataSet.Transaction = nil) then
      Exit;

   if Text = '' then
      HideGrid
   else
   begin
      try
         DataSet.Close;
         GenerateNewSQLSelect;
         DataSet.Params.ByNameAsString['text_to_search'] := Trim(Self.Text);
         DataSet.Open;

         // Format fields according to zGridFieldFormats property
         for i := 0 to DataSet.FieldCount - 1 do
         begin
            FieldIndex := FGridFieldNames.IndexOf(DataSet.Fields[i].FieldName);

            if FieldIndex > 0 then
            begin
               // Is there a format for the field?
               if FieldIndex < FGridFieldFormats.Count then
                 if Trim(FGridFieldFormats[FieldIndex]) <> '' then
                    TIntegerField(DataSet.Fields[i]).DisplayFormat :=
                        FGridFieldFormats[FieldIndex];
            end;
         end;

         if (DataSet.RecordCount > 0) then
         begin
            CursorPos := SelStart;
            ShowGrid;
            SelStart := CursorPos;
         end
         else
            HideGrid;
      except
         on E: Exception do
            raise Exception.Create('SEARCH ERROR:'#13#13'SQL SELECT: ' + FSQLSelect +
                  #13#13'MESSAGE: ' + E.Message);
      end;
   end;

   inherited;
end;

procedure TTextSearch.DoEnter;
begin
   HasFocus := True;
   inherited;
end;

procedure TTextSearch.DoExit;
begin
   HasFocus := False;
   HideGrid;
   inherited;
end;

procedure TTextSearch.KeyPress(var Key: Char);
begin
   if Key = #13 then
   begin
      if DataSet.Active then
      begin
         if (DataSet.RecordCount > 0) and FormGrid.Visible then
         begin
            RecordChosen(Self);
            Key := #0;
         end;
      end;
   end;

   if Key = #27 then
      HideGrid;

   if FUseSQLUpper then
      Key := AnsiUpperCase(Key)[1];

   inherited KeyPress(Key);
end;

procedure TTextSearch.KeyDown(var Key: Word; Shift: TShiftState);
begin
   inherited KeyDown(Key, Shift);

   if DataSet.Active then
   begin
      if Key = vk_Up then
      begin
         DataSet.Prior;
         Key := 0;
      end
      else if Key = vk_Down then
      begin
         Key := 0;
         DataSet.Next;
      end;
   end;
end;


// Internal tasks ------------------------------------------------------------------------------


procedure TTextSearch.CreateGrid;
begin
   FormGrid := TGridForm.Create(Self);
   FormGrid.DS.DataSet     := DataSet;
   FormGrid.OnChooseRecord := RecordChosen;
end;

procedure TTextSearch.ShowGrid;

   // What form is the component placed in?
   function WhatForm: TForm;
   var
      Component: TWinControl;
   begin
      Component := Self;

      repeat
         Component := Component.Parent;
      until Component is TForm;

      Result := TForm(Component);
   end;

var
   ThisPoint, GridPoint: TPoint;
   i:         integer;
   NewColumn: TColumn;
begin
   if FormGrid = nil then
      CreateGrid;

   if FormGrid.Visible then
      Exit; 

   // Find a position for the grid popup form, below the text search field
   ThisPoint.X     := Left - 2;
   ThisPoint.Y     := Top + Height;
   GridPoint       := Parent.ClientToScreen(ThisPoint);
   FormGrid.Left   := GridPoint.X;
   FormGrid.Top    := GridPoint.Y;
   FormGrid.Width  := FPopupWidth;
   FormGrid.Height := FPopupHeight;

   FormGrid.DBGrid.Font.Assign(Font);
   FormGrid.pnlHowToUse.Font.Assign(Font);
   FormGrid.DBGrid.Columns.Clear;

   // Configure columns in the grid
   if FGridFieldNames.Count > 0 then
   begin
      for i := 0 to FGridFieldNames.Count - 1 do
      begin
         NewColumn           := FormGrid.DBGrid.Columns.Add;
         NewColumn.FieldName := FGridFieldNames[i];

         if i < FGridFieldWidths.Count then  // Is there a width defined for the field?
            if Trim(FGridFieldWidths[i]) <> '' then
               NewColumn.Width := StrToInt(FGridFieldWidths[i]);
      end;
   end;

   if Trim(FHowToUseMessage) <> '' then
   begin
      FormGrid.pnlHowToUse.Visible := True;
      FormGrid.pnlHowToUse.Caption := FHowToUseMessage;
      FormGrid.pnlHowToUse.Height  := FormGrid.DBGrid.Canvas.TextHeight(FHowToUseMessage) + 10;
   end
   else
      FormGrid.pnlHowToUse.Visible := False;

   FormGrid.Show;

   // Do not keep the focus on the grid form; allow user continue typing
   PostMessage(WhatForm.Handle, WM_SETFOCUS, 0, 0);
   WhatForm.SetFocus;
   PostMessage(Self.Handle, WM_SETFOCUS, 0, 0);
   Self.SetFocus;
end;

procedure TTextSearch.HideGrid;
begin
   if FormGrid = nil then
      CreateGrid;

   FormGrid.Hide;
end;

// Internal event that occurs when the user selects an existent record by this control or the
// popup grid
procedure TTextSearch.RecordChosen(Sender: TObject);
begin
   // Complete the Edit control with the text from the DataSet and select a code
   PutData(DataSet.FieldValues[FSearchField], DataSet.FieldValues[FKeyField]);
   DoOnSelectRecord(Self);
   HideGrid;
   SelStart  := 0;
   SelLength := Length(Text);
end;

// Event that occurs when the user select and existing record or removes the current selection
// by typing an inexistent search entry
procedure TTextSearch.DoOnSelectRecord(Sender: TObject);
begin
   if Assigned(FOnSelectRecord) then
      FOnSelectRecord(Self);
end;


// Properties ----------------------------------------------------------------------------------


procedure TTextSearch.SetDataBase(D: TJvUIBDataBase);
begin
   FDataBase        := D;
   DataSet.Database := D;
end;

procedure TTextSearch.SetTransaction(T: TJvUIBTransaction);
begin
   FTransaction        := T;
   DataSet.Transaction := T;
end;

procedure TTextSearch.GenerateNewSQLSelect;
var
   SelectFields: string;
   i:            integer;
begin
   if FGridFieldNames.Count = 0 then
      SelectFields := FSearchField
   else
   begin
      SelectFields := '';

      for i := 0 to FGridFieldNames.Count - 1 do
      begin
         if i > 0 then
            SelectFields := SelectFields + ', ';

         SelectFields := SelectFields + FGridFieldNames[i];
      end;
   end;

   FSQLSelect := 'select ' + SelectFields + ', ' + FKeyField + ' from ' + FTableName +
                 ' where (';

   if FUseSQLUpper then
      FSQLSelect := FSQLSelect + 'upper(' + FSearchField + ')'
   else
      FSQLSelect := FSQLSelect + FSearchField;

   FSQLSelect := FSQLSelect + ' like :text_to_search || ''%'')';

   if Trim(FExtraFilter) <> '' then
      FSQLSelect := FSQLSelect + ' and (' + FExtraFilter + ')';

   FSQLSelect := FSQLSelect + ' order by ' + FSearchField;

   // Avoid assign a statement that is already prepared (remember, the user is typing!)
   if LastGeneratedSQL <> FSQLSelect then
   begin
      LastGeneratedSQL := FSQLSelect;
      DataSet.SQL.Text := FSQLSelect;
   end;
end;

procedure TTextSearch.SetGridFieldNames(G: TStrings);
begin
   FGridFieldNames.Assign(G);
end;

procedure TTextSearch.SetGridFieldWidths(G: TStrings);
begin
   FGridFieldWidths.Assign(G);
end;

procedure TTextSearch.SetGridFieldFormats(G: TStrings);
begin
   FGridFieldFormats.Assign(G);
end;

{ Used only in design time
procedure TTextSearch.DiscoverMessageParams(var msg: TMessage);
begin
   showmessage(inttostr(msg.WParam));
   showmessage(inttostr(msg.LParam));
end;
}


// User methods --------------------------------------------------------------------------------


// Allows us to define manually what data is being displayed (this method is also called by
// RecordChosen to update the component)
procedure TTextSearch.PutData(NewText: string; NewSelectedKey: variant);
begin
   ChangingByItself := True;  // The user is searching nothing, do not show the popup grid
   Text := NewText;
   ChangingByItself := False;

   FSelectedKey := NewSelectedKey;
   FHasSelected := (not VarIsNull(NewSelectedKey));

   if Assigned(FKeyFieldLabel) then
      if FHasSelected then
         FKeyFieldLabel.Caption := NewSelectedKey
      else
         FKeyFieldLabel.Caption := '';
end;

procedure TTextSearch.ClearData;  // What does this mean? :P
begin
   ChangingByItself := True;
   Text := '';
   ChangingByItself := False;

   FSelectedKey := Null;
   FHasSelected := False;

   if Assigned(FKeyFieldLabel) then
      FKeyFieldLabel.Caption := '';
end;

// Get the value of any field in the query
function TTextSearch.FieldValue(FieldName: string): variant;
begin
   if (not DataSet.Active) or (not FHasSelected) then
   begin
      Result := Null;
      Exit;
   end;

   Result := DataSet.FieldValues[FieldName];
end;

end.
