tableextension 50128 "Purch & Payables Setup Gen" extends "Purchases & Payables Setup"
{
    fields
    {
        field(52167423; "Vendor Bank Acc Nos"; Code[20])
        {
            Caption = 'Vendor Bank Acc Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(52167424; "Minimum Name Characters"; Integer)
        {
            Caption = 'Minimum Name Characters';
            DataClassification = ToBeClassified;
        }
        field(52167425; "Contract Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
