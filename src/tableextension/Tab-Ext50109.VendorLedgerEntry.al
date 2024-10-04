tableextension 50109 "Vendor Ledger Entry" extends "Vendor Ledger Entry"
{
    fields
    {
        //Payroll
        field(52167423; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payroll Period';
        }
        //Finance
        field(52167424; Selected; Boolean)
        {
            Caption = 'Selected';
            DataClassification = ToBeClassified;
        }
    }
}
