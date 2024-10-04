tableextension 50104 "Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        //Payroll
        field(52167423; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payroll Period';
        }
        field(52167424; "Budget Code"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
            DataClassification = ToBeClassified;
            Caption = 'Budget Code';
        }
    }
}
