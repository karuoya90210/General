page 50111 "Approval Comment Line Cust"
{
    Caption = 'Approval Comments';
    DataCaptionFields = "Record ID to Approve";
    DelayedInsert = true;
    LinksAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Approval Comment Line";
    ShowFilter = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Comment Ext"; rec."Approval Comment")
                {
                    Visible = ModifyAllowed;
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the comment. You can enter a maximum of 250 characters, both numbers and letters.';
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the user who created this approval comment.';

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation(rec."User ID");
                    end;
                }
                field("Date and Time"; rec."Date and Time")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date and time when the comment was made.';
                }
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        ModifyAllowed := true;
        DeleteAllowed := true;
    end;

    trigger OnAfterGetRecord()
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Workflow Step Instance ID", Rec."Workflow Step Instance ID");
        if ApprovalEntry.FindFirst() then begin
            if (Rec."User ID" <> UserId) then begin
                ModifyAllowed := false;
                DeleteAllowed := false;
            end;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        DeletionError: Label 'You cannot delete comments to approved or rejected approval or other users comments';
    begin
        if not DeleteAllowed then
            Error(DeletionError);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec."Workflow Step Instance ID" := WorkflowStepInstanceID;
        if GlobalDocNo <> '' then
            Rec."Document No." := GlobalDocNo;
        if GlobalTableId <> 0 then begin
            Rec."Table ID" := GlobalTableId;
            Rec."Record ID to Approve" := GlobalRecordID;
        end;
    end;

    var
        WorkflowStepInstanceID: Guid;

    procedure SetWorkflowStepInstanceID(NewWorkflowStepInstanceID: Guid)
    begin
        WorkflowStepInstanceID := NewWorkflowStepInstanceID;
    end;

    var
        GlobalDocNo: Code[20];
        GlobalRecordID: RecordId;
        GlobalTableId: Integer;
        DeleteAllowed, ModifyAllowed : Boolean;
    procedure GetDetails(RecordIDToApprove: RecordId; var DocumentNo: Code[20]; TableID: Integer)
    begin
        GlobalDocNo := DocumentNo;
        GlobalRecordID := RecordIDToApprove;
        GlobalTableId := TableID;
    end;

}
