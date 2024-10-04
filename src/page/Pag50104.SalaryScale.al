Page 50104 "Salary Scale"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Salary Scale";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field("Salary Scale"; Rec."Salary Scale")
                {
                    ToolTip = 'Specifies the value of the Salary Scale field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ToolTip = 'Specifies the value of the Minimum Amount field.';
                    ApplicationArea = All;
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ToolTip = 'Specifies the value of the Maximum Amount field.';
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.';
                    ApplicationArea = All;
                }
                field("Loan Threshold"; Rec."Loan Threshold")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Threshold field.';
                }
                field("No. Of Emloyees"; Rec."No. Of Emloyees")
                {
                    ToolTip = 'Specifies the value of the No. Of Emloyees field.';
                    ApplicationArea = All;
                }
                field("Last Modified At"; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified At';
                    Editable = false;
                }
                field("Last Modified By"; GeneralMgt.GetUserName(Rec.SystemModifiedBy))
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified By';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Pointers)
            {
                ApplicationArea = Basic;
                Image = NumberGroup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Salary Pointer";
                RunPageLink = "Salary Scale" = field("Salary Scale");
            }
        }
    }

    var
        GeneralMgt: Codeunit "General Management";
}

