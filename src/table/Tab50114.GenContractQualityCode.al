table 50114 "Gen. Contract Quality Code"
{
    Caption = 'Contract Quality Code';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Description; Text[80])
        {
            DataClassification = ToBeClassified;

        }
    }
    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}