table 50112 "Gen. Contract Entry"
{
    Caption = 'Contract Entry';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Contract No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Contract";
        }
        field(3; "Date-time Created"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(5; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Activated,Renewed,Closed,Addendum;
        }
        field(6; "Renewal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Entry No", "Contract No")
        {
            Clustered = true;
        }
    }

}