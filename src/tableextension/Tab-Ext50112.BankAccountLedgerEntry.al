tableextension 50112 "Bank Account Ledger Entry" extends "Bank Account Ledger Entry"
{
    fields
    {
        //Finance
        field(52167423; Selected; Boolean)
        {
            Caption = 'Selected';
            DataClassification = ToBeClassified;
        }
        modify("Document No.")
        {
            Caption = 'FT number';
        }
    }
}
