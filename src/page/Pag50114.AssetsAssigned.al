page 50114 "Assets Assigned"
{
    Caption = 'Assets Assigned';
    PageType = ListPart;
    SourceTable = "Fixed Asset";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the fixed asset.';
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the subclass of the class that the fixed asset belongs to.';
                }
            }
        }
    }
}
