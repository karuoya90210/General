tableextension 50105 "G/L Entry" extends "G/L Entry"
{
    fields
    {
        //Payroll
        field(52167423; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payroll Period';
        }
        //End Payroll
        //Fixed Asset Acquisition
        field(52167424; Selected; Boolean)
        {
            Caption = 'Selected';
            DataClassification = ToBeClassified;
        }
        field(52167425; "Related Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Related Account Type';
        }
        field(52167426; "Related Entry No."; Integer)
        {
            Caption = 'Related Entry No.';
            DataClassification = ToBeClassified;
        }
    }
}
