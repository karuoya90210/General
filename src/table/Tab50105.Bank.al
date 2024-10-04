table 50105 Bank
{
    DrillDownPageID = "Banks";
    LookupPageID = "Banks";

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Code';
        }
        field(2; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Name';
        }
    }

    keys
    {
        key(Key1; "Bank Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Bank Code", "Bank Name")
        {
        }
    }
}
