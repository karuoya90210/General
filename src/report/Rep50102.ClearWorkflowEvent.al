report 50102 "Clear Workflow Event"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = tabledata "Workflow Event" = d;
    Caption = 'Clear Workflow Event';

    trigger OnPreReport()
    var
        WFEvent: Record "Workflow Event";
    begin
        WFEvent.Reset();
        WFEvent.DeleteAll();
    end;
}
