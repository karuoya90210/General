tableextension 50115 "Document Attachment" extends "Document Attachment"
{
    fields
    {
        field(52167423; "Attachment Type"; Enum "Attachment Type")
        {
            Caption = 'Attachment Type';
        }
        field(52167424; "Mail Attachment"; Boolean)
        {
            Caption = 'Mail Attachment';
        }
        field(52167425; "External Ref. No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "Send Attachment"; Boolean)
        {
            Caption = 'Send Attachment';
            DataClassification = ToBeClassified;
        }
    }
}
