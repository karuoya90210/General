table 50106 "Bank Branch"
{
    DrillDownPageID = "Bank Branches";
    LookupPageID = "Bank Branches";

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            TableRelation = Bank."Bank Code";
            Caption = 'Bank Code';
        }
        field(2; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
        }
        field(3; "Bank Name"; Text[100])
        {
            CalcFormula = lookup(Bank."Bank Name" where("Bank Code" = field("Bank Code")));
            FieldClass = FlowField;
            Caption = 'Bank Name';
        }
        field(4; "Branch Name"; Text[100])
        {
            Caption = 'Branch Name';
        }
    }

    keys
    {
        key(Key1; "Bank Code", "Branch Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Bank Code", "Branch Code", "Branch Name")
        {
        }
    }
}
