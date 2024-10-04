page 50113 "User Sessions"
{
    ApplicationArea = All;
    Caption = 'User Sessions';
    PageType = List;
    SourceTable = "User Session";
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Login Date"; Rec."Login Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Login Date field.';
                }
                field("Login Time"; Rec."Login Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Login Time field.';
                }
                field("Logout Date"; Rec."Logout Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Logout Date field.';
                }
                field("Logout Time"; Rec."Logout Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Logout Time field.';
                }
            }
        }
    }
}
