codeunit 50104 "Approval Management"
{

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt.", 'OnBeforeRejectApprovalRequests', '', false, false)]
    local procedure OnRejectApprovalRequest(VAR ApprovalEntry: Record "Approval Entry")
    var
        RejectionComments: Page "Rejection Comments";
        Comment: Text;
        Text001: Label 'Please input rejection comment.';
        Text002: Label 'Please confirm rejection comment.';
    begin
        if ApprovalEntry.FindFirst() then;
        if RejectionComments.RunModal() = ACTION::OK THEN begin
            Comment := RejectionComments.GetRejectComment;
            if Comment = '' then
                Error(Text001);
            InsertRejectionComment(Comment, ApprovalEntry);
        end;
        if Comment = '' then
            Error(Text001);
    end;

    local procedure InsertRejectionComment(Comment: Text; ApprovalEntry: Record "Approval Entry")
    var
        CommentLine: Record "Approval Comment Line";
        LineNo: Integer;
    begin
        IF CommentLine.FINDLAST THEN
            LineNo := CommentLine."Entry No." + 1
        ELSE
            LineNo := 1;

        CommentLine.INIT;
        CommentLine."Entry No." := LineNo;
        CommentLine."Table ID" := ApprovalEntry."Table ID";
        CommentLine."Document No." := ApprovalEntry."Document No.";
        CommentLine."Document Type" := ApprovalEntry."Document Type";
        CommentLine."Date and Time" := CREATEDATETIME(TODAY, TIME);
        CommentLine.Comment := CopyStr(Comment, 1, MaxStrLen(CommentLine.Comment));
        CommentLine."Approval Comment" := Comment;
        CommentLine."Record ID to Approve" := ApprovalEntry."Record ID to Approve";
        CommentLine."Workflow Step Instance ID" := ApprovalEntry."Workflow Step Instance ID";
        CommentLine."User ID" := USERID;
        CommentLine.INSERT;
    end;

    procedure AddComments(var ApprovalEntry: Record "Approval Entry")
    var
        Comment: Text;
        ApprovalCommentLine: Record "Approval Comment Line";
        Comments: Page "Rejection Comments";
        EntryNo: Integer;
    begin
        //Get the comments
        Clear(Comments);
        Comments.Caption := 'Approval Comment';
        if Comments.RunModal() = Action::OK then
            Comment := Comments.GetRejectComment();

        if Comment <> '' then begin
            ApprovalCommentLine.LockTable();
            if ApprovalCommentLine.FindLast() then
                EntryNo := ApprovalCommentLine."Entry No.";

            if ApprovalEntry.FindSet() then begin
                repeat
                    EntryNo += 1;
                    ApprovalCommentLine.Init();
                    ApprovalCommentLine."Entry No." := EntryNo;
                    ApprovalCommentLine.Comment := CopyStr(Comment, 1, MaxStrLen(ApprovalCommentLine.Comment));
                    ApprovalCommentLine."Approval Comment" := Comment;
                    ApprovalCommentLine."Record ID to Approve" := ApprovalEntry."Record ID to Approve";
                    ApprovalCommentLine."Workflow Step Instance ID" := ApprovalEntry."Workflow Step Instance ID";
                    ApprovalCommentLine."Document No." := ApprovalEntry."Document No.";
                    ApprovalCommentLine."Document Type" := ApprovalEntry."Document Type";
                    ApprovalCommentLine."Date and Time" := CurrentDateTime;
                    ApprovalCommentLine."Table ID" := ApprovalEntry."Table ID";
                    ApprovalCommentLine."User ID" := UserId;
                    ApprovalCommentLine.Insert();
                until ApprovalEntry.Next() = 0;
            end;
        end;
    end;

    //Replace Custon Approval Comments Lines
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeRunApprovalCommentsPage', '', true, true)]
    local procedure UpdateCommentsPage(var ApprovalCommentLine: Record "Approval Comment Line"; var IsHandle: Boolean; WorkflowStepInstanceID: Guid)
    var
        ApprovalComments: Page "Approval Comment Line Cust";
    begin
        IsHandle := true;
        ApprovalComments.SetTableView(ApprovalCommentLine);
        ApprovalComments.SetWorkflowStepInstanceID(WorkflowStepInstanceID);
        ApprovalComments.Run;
    end;

    //Add Approval Entry Rejector
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterRejectSelectedApprovalRequest', '', false, false)]
    local procedure UpdateApprovalEntryRejector(var ApprovalEntry: Record "Approval Entry")
    begin
        ApprovalEntry.Validate("Rejected By", UserId);
        ApprovalEntry.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeDelegateApprovalRequests', '', false, false)]
    procedure ConfirmDelegate(var IsHandled: Boolean)
    var
        ConfirmTxt: Label 'Are you sure you want to delegate this approval entry?';
    begin
        if not Confirm(ConfirmTxt, false) then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure DelegateMessage(var ApprovalEntry: Record "Approval Entry")
    var
        DelegateTxt: Label 'The approval entry has been delegated to %1.';
    begin
        Message(DelegateTxt, ApprovalEntry."Approver ID");
    end;
}
