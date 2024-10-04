page 50107 "Bank Branches"
{
    ApplicationArea = Payroll;
    PageType = List;
    SourceTable = "Bank Branch";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(BranchCode; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(BranchName; Rec."Branch Name")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

}
