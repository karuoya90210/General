page 50112 "Fixed Asset Custom Lists"
{
    Caption = 'Fixed Asset List';
    PageType = List;
    SourceTable = "Fixed Asset Custom";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("FA SubClass Code"; Rec."FA SubClass Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Group"; Rec."FA Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Group field.';
                }
            }
        }
    }
}
