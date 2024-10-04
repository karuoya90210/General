table 50108 "Fixed Asset Custom"
{
    Caption = 'Fixed Asset Custom';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Fixed Asset Custom Lists";
    LookupPageId = "Fixed Asset Custom Lists";


    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "FA Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "FA Posting Group".Code;
        }
        field(4; "FA SubClass Code"; Code[20])
        {
            TableRelation = "FA Subclass".Code;
            trigger OnValidate()
            var
                FASubClass: Record "FA Subclass";
            begin
                if FASubClass.Get("FA SubClass Code") then
                    "FA Posting Group" := FASubClass."Default FA Posting Group";
            end;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Description, "FA SubClass Code", "FA Posting Group")
        {
        }
    }
}
