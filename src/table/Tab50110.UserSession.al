table 50110 "User Session"
{
    Caption = 'User Session';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = "User Setup";
        }
        field(2; "Login Date"; Date)
        {
            Caption = 'Login Date';
        }
        field(3; "Login Time"; Time)
        {
            Caption = 'Login Time';
        }
        field(4; "Logout Date"; Date)
        {
            Caption = 'Logout Date';
        }
        field(5; "Logout Time"; Time)
        {
            Caption = 'Logout Time';
        }
        field(6; "Client IP"; Text[20])
        {
            Caption = 'Client IP';
        }
    }
    keys
    {
        key(PK; "User ID", "Login Date", "Login Time")
        {
            Clustered = true;
        }
    }
}
