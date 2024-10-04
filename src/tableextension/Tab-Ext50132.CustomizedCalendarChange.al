tableextension 50132 "Customized Calendar Change" extends "Customized Calendar Change"
{
    fields
    {
        field(60000; Holiday; Boolean)
        {
            Caption = 'Holiday';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Holiday then
                    Nonworking := Holiday;
            end;
        }
    }
    procedure UpdateHolidayCalendarChanges()
    var
        BaseCalendarChange: Record "Base Calendar Change";
    begin
        BaseCalendarChange.Reset();
        BaseCalendarChange.SetRange("Base Calendar Code", "Base Calendar Code");
        BaseCalendarChange.SetRange(Date, Date);
        if BaseCalendarChange.FindFirst then
            BaseCalendarChange.Delete();
        BaseCalendarChange.Init();
        BaseCalendarChange."Base Calendar Code" := "Base Calendar Code";
        BaseCalendarChange.Date := Date;
        BaseCalendarChange.Description := Description;
        if Holiday then
            BaseCalendarChange.Nonworking := Holiday
        else
            BaseCalendarChange.Nonworking := Nonworking;
        BaseCalendarChange.Holiday := Holiday;
        BaseCalendarChange.Day := Day;
        BaseCalendarChange.Insert();
    end;
}