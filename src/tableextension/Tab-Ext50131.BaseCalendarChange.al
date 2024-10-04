tableextension 50131 "Base Calendar Change" extends "Base Calendar Change"
{
    fields
    {
        field(60000; Holiday; Boolean)
        {
            Caption = 'Holiday';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Holiday then
                    Nonworking := Holiday;
            end;
        }
    }
}