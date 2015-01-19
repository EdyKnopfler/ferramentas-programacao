unit UDAwTextSearch;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, UTextSearch, DB, jvuibdataset,
  Dialogs;  // Dialogs help me on debug ;)

type
  TDAwTextSearch = class(TTextSearch)
  private
    { Private declarations }
    DS:         TDataSource;
    FDataSet:   TDataSet;
    FDataField: string;

    // When the user positionates on a record, this control looks up the
    // corresponding text field value in the other table using the key value.
    // Let's map key values to their respective text values, so we don't
    // need to look them up every time! ;)
    qryTexts: TJvUIBDataSet;  // Query that looks up the text values
    KeyTexts: TStrings;       // The map (Key Value=Text Value)

    procedure DSDataChange(Sender: TObject; Field: TField);
    procedure DSStateChange(Sender: TObject);
    procedure SetDataSet(D: TDataSet);
    function PerformLookup(Key: variant): string;
  protected
    { Protected declarations }
    procedure RecordChosen(Sender: TObject); override;
    procedure Change; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property zDataSet:    TDataSet read FDataSet    write SetDataSet default nil;
    property zDataField:  string   read FDataField  write FDataField;
  end;

procedure Register;

implementation

uses Variants;

procedure Register;
begin
  RegisterComponents('Éderson', [TDAwTextSearch]);
end;

{ TDAwTextSearch }

constructor TDAwTextSearch.Create(AOwner: TComponent);
begin
   inherited; 
   DS               := TDataSource.Create(Self);
   DS.OnDataChange  := DSDataChange;
   DS.OnStateChange := DSStateChange;
   qryTexts         := TJvUIBDataSet.Create(Self);
   KeyTexts         := TStringList.Create; 
end;

destructor TDAwTextSearch.Destroy;
begin
   DS.Free;
   qryTexts.Free;
   KeyTexts.Free;
   inherited;
end;

procedure TDAwTextSearch.DSDataChange(Sender: TObject; Field: TField);
var
   Key: variant;
begin
   if FDataSet = nil then
      Exit;

   if DS.State = dsBrowse then
   begin
      if (FDataSet.RecordCount = 0) or VarIsNull(FDataSet.FieldValues[FDataField]) then
      begin
         ClearData;
      end
      else
      begin
         Key := FDataSet.FieldValues[FDataField];

         if Key <> SelectedKey then
            PutData(PerformLookup(Key), Key);
      end;

      ReadOnly := True;
   end
   else
      ReadOnly := not (DS.State in [dsInsert, dsEdit]);
end;

procedure TDAwTextSearch.DSStateChange(Sender: TObject);
begin
   if DS.State in [dsInsert, dsInactive] then
      ClearData;
end;

procedure TDAwTextSearch.RecordChosen(Sender: TObject);
begin
   inherited;

   if DS.State in [dsInsert, dsEdit] then
      FDataSet.FieldValues[FDataField] := SelectedKey;
end;

procedure TDAwTextSearch.Change;
begin
   inherited;

   if DS.State in [dsInsert, dsEdit] then
      FDataSet.FieldValues[FDataField] := Null;
end;

procedure TDAwTextSearch.SetDataSet(D: TDataSet);
begin
   DS.DataSet := D;
   FDataSet   := D;
   DSDataChange(DS, nil);
end;

// Look up the text field value based on the key field value
function TDAwTextSearch.PerformLookup(Key: variant): string;
var
   NewSQL: string;
begin
   // Is the key and its correspondent text value mapped? So, use them!
   if KeyTexts.IndexOfName(VarToStr(Key)) >= 0 then
   begin
      Result := KeyTexts.Values[VarToStr(Key)];
      Exit;
   end;

   NewSQL := 'SELECT ' + zSearchField + ' FROM ' + zTableName +
         ' WHERE ' + zKeyField + ' = :key';

   if NewSQL <> qryTexts.SQL.Text then
      qryTexts.SQL.Text := NewSQL;  // Avoid repreparing the query!!

   qryTexts.Database    := zDataBase;
   qryTexts.Transaction := zTransaction;
   qryTexts.Params.ByNameAsString['key'] := VarToStr(Key);
   qryTexts.Open;

   if not qryTexts.Eof then
      Result := qryTexts.FieldValues[zSearchField]
   else
      Result := '';

   KeyTexts.Values[VarToStr(Key)] := Result;
   qryTexts.Close;
end;

end.
