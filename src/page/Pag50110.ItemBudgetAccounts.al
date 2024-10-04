page 50110 "Item Budget Accounts"
{
    Caption = 'Item Budget Accounts';
    PageType = List;
    SourceTable = "Item Budget A/C";
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
                field("Budget G/L Acc"; Rec."Budget G/L Acc")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget G/L Acc field.';
                }
                field("G/L Acc Name"; Rec."G/L Acc Name")
                {
                    Caption = 'Account Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Acc Name field.';
                }
            }
        }
    }
}
