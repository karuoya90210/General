tableextension 50118 "G/L Budget Name" extends "G/L Budget Name"
{
    fields
    {
        field(52167423; "Budget Start Date"; Date)
        {
            Caption = 'Budget Start Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                AccPeriod: Record "Accounting Period";
                CurrentYear: Codeunit ReturnTheYear;
            begin
                /*AccPeriod.Reset();
                AccPeriod.SetRange("New Fiscal Year", true);
                AccPeriod.SetRange("Starting Date", "Budget Start Date");
                if AccPeriod.IsEmpty() then begin
                    Error('Budget Start date does not match with the fiscal year start date');
                end;*/

                "Budget End Date" := CalcDate('<12M>', "Budget Start Date" - 1);
                
                BudgetLength := GetDatesDiffInMonths("Budget Start Date", "Budget End Date");

                If ("Budget Start Date" > "Budget End Date") and (BudgetLength <> 12) and ("Budget End Date" <> 0D) then
                    Error('Budget Start Date can''t be greater than Budget End Date and should a diffrence of 12 months');
            end;
        }
        field(52167424; "Budget End Date"; Date)
        {
            Caption = 'Budget End Date';
            DataClassification = ToBeClassified;
        }
        field(52167425; Status; Enum "Document Approval Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
         field(52167426; Year; text[15])
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
            Editable = false;
        } 
        
    }

    procedure GetBudgetPeriodDescription(BudgetCode: Code[30]) DescriptionText: Text
    var
        Budget: Record "G/L Budget Name";
        StartYear, EndYear : integer;
    begin
        if Budget.get(BudgetCode) then begin
            if Budget."Budget Start Date" <> 0D then
                StartYear := Date2DMY(Budget."Budget Start Date", 3);
            if Budget."Budget End Date" <> 0D then
                EndYear := Date2DMY(Budget."Budget Start Date", 3);
            if StartYear <> EndYear then begin
                DescriptionText := StrSubstNo('%1 - %2', StartYear, EndYear);
            end else
                DescriptionText := Format(StartYear)
        end;
    end; 

    
    Procedure GetDatesDiffInMonths(firstDate: Date; secondDate: Date) DiffInMonths: Integer
    begin

        DiffInMonths := ABS(12 * (DATE2DMY(firstDate, 3) - DATE2DMY(secondDate, 3)) + DATE2DMY(firstDate, 2) - DATE2DMY(secondDate, 2));

    end;

    procedure SendApprovalRequest()
    begin
        TestField(Name);
        TestField("Budget Start Date");
        TestField("Budget End Date");
    end;

    

    var
        BudgetLength: integer;
}