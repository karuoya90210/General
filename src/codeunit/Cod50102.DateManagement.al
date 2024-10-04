codeunit 50102 "Date Management"
{
    procedure GetDateTime(FieldCaption: Text) DTime: DateTime
    var
        DateTimeDialog: Page "Date-Time Dialog";
    begin
        Clear(DateTimeDialog);
        DateTimeDialog.Caption := StrSubstNo('Please select the value for %1', FieldCaption);
        if DateTimeDialog.RunModal() = Action::OK then
            exit(DateTimeDialog.GetDateTime());
    end;

}
