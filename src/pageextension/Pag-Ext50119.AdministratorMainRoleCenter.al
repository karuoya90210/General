pageextension 50119 "Administrator Main Role Center" extends "Administrator Main Role Center"
{
    actions
    {
        modify(Group1)
        {
            Visible = false;
        }
        modify(Group2)
        {
            Visible = false;
        }
        modify(Group7)
        {
            Visible = false;
        }
        modify("Feature Management")
        {
            Visible = false;
        }
        modify(Group8)
        {
            Visible = false;
        }
        modify(Group27)
        {
            Visible = false;
        }
        modify(Group27A)
        {
            Visible = false;
        }
        modify(Group28)
        {
            Visible = false;
        }
        modify("User Time Registers")
        {
            Visible = false;
        }
        addafter("User Time Registers")
        {
            action("UserSessions")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'User Sessions';
                RunObject = page "User Sessions";
            }
            action("UserSessionsRpt")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'User Sessions Report';
                RunObject = report "User Sessions";
            }
        }
    }
}
