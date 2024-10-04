tableextension 50123 "Approval Comment Line" extends "Approval Comment Line"
{
    fields
    {
        /* field(50000; "Comment Ext"; Text[1048])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Comment := CopyStr("Comment Ext", 1, MaxStrLen(Comment));
            end;
        } */

         field(50000; "Approval Comment"; Text[1000])
        {
            Caption = 'Approval Comment';
            DataClassification = ToBeClassified;
        }


    }
}
