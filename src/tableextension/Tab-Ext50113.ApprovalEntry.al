tableextension 50113 "Approval Entry" extends "Approval Entry"
{
    fields
    {
        field(52167423; "Final Approval"; Boolean)
        {
            Caption = 'Final Approval';
            DataClassification = ToBeClassified;
        }
        field(52167424; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(52167425; "Workflow User Group Code"; Code[20])
        {
            TableRelation = "Workflow User Group".Code;
            Caption = 'Workflow User Group Code';
        }
        field(52167426; "Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Account No.';
        }
        field(52167427; "Rejected By"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
    }

    keys
    {
        key(Keys2; "Sequence No.", "Date-Time Sent for Approval")
        {
        }
        key(Keys3; "Record ID to Approve")
        {
        }
    }
    trigger OnAfterInsert()
    var
        ApprovalEntryCustom: Record "Approval Entry Custom";
    begin
        ApprovalEntryCustom.Init();
        ApprovalEntryCustom.TransferFields(Rec);
        ApprovalEntryCustom.Insert();
    end;

    trigger OnModify()
    var
        ApprovalEntryCustom: Record "Approval Entry Custom";
    begin
        if ApprovalEntryCustom.Get(Rec."Entry No.") then begin
            ApprovalEntryCustom.TransferFields(Rec);
            ApprovalEntryCustom.Modify();
        end;
    end;
}
