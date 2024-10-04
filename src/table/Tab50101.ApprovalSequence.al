/* table 50101 "Approval Sequence"
{
    fields
    {
        field(1; "Workflow User Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group";
            Caption = 'Workflow User Group Code';
        }
        field(2; "Sequence No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sequence No.';
        }
        field(4; "Sequence Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sequence Name';
        }
        field(6; "Minimum Approvers"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Minimum Approvers';
        }
    }
    keys
    {
        key(Key1; "Workflow User Group Code", "Sequence No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
 */
 //60002
 table 50101 "Approval Sequence"
{
    Caption = 'Approval Sequence';

    fields
    {
        field(1; "Workflow User Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group";
            Caption = 'Workflow User Group Code';
        }
        field(2; "Sequence No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sequence No.';
        }
        field(4; "Sequence Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sequence Name';
        }
        field(6; "Minimum Approvers"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Minimum Approvers';
        }
    }

    keys
    {
        key(Key1; "Workflow User Group Code", "Sequence No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}




