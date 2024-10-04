table 50109 "Item Budget A/C"
{
    Caption = 'Item Budget A/C';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Budget G/L Acc"; Code[20])
        {
            Caption = 'Budget G/L Account';
            TableRelation = "G/L Account"."No.";
            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
            begin
                if GLAcc.Get("Budget G/L Acc") then
                    "G/L Acc Name" := GLAcc.Name;
            end;
        }
        field(4; "G/L Acc Name"; Text[250])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
