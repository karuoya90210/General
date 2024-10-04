table 50113 "Gen. Contract Quality Entry"
{
    Caption = 'Contract Quality Entry';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Quality Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Contract Quality Code";
            trigger OnValidate()
            var
                ContRec: Record "Gen. Contract Quality Code";
            begin
                if xRec.Description <> '' then
                    Description := '';
                if ContRec.Get("Quality Code") then
                    Description := ContRec.Description;
            end;
        }

        field(4; Description; Text[2000])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Rating; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","1","1.5","2","2.5","3","3.5","4","4.5","5";
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

}