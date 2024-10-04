page 50108 "Job Titles"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Job Title";
    CardPageId = "Job Title Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Employee Count"; Rec."Employee Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Count field.';
                }
            }

        }
        area(FactBoxes)
        {
            part("Document Attachment"; "Document Attachment Factbox")
            {
                ApplicationArea = all;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(52167431), "No." = field(Code);
            }
        }
    }
}