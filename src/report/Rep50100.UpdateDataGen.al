report 50100 "Update Data Gen"
{
    ApplicationArea = All;
    Caption = 'Update Data Gen';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    trigger OnPreReport()
    var
        Workflow: Record Workflow;
        WorkflowEvent: Record "Workflow Event";
    begin
        /* Workflow.Reset();
        if Workflow.FindSet() then
            Workflow.ModifyAll(Enabled, false);

        if WorkflowEvent.FindSet() then
            WorkflowEvent.DeleteAll(); */
    end;
}
