pageextension 50118 PaymentJournal extends "Payment Journal"
{
    actions
    {
        addafter("P&osting")
        {
            action("Import Payment Journal Lines")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Import Payment Journal Lines';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;
                ToolTip = 'Import Payment Journal Lines';

                trigger OnAction()
                var
                    PmtJnrImport: XmlPort "Payment Journal";
                begin
                    PmtJnrImport.SetJournalTemplateBatch(Rec."Journal Template Name", Rec."Journal Batch Name");
                    PmtJnrImport.Run();
                    Message('File Imported Successfully');
                End;
            }

            action("Export Payment Journal Lines")
            {
                Caption = 'Export Payment Journal Lines';
                Promoted = true;
                PromotedCategory = Process;
                Image = Export;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PmtJnrExport: XmlPort PaymentJournalExp;
                begin
                    PmtJnrExport.SetJournalTemplateBatch(Rec."Journal Template Name", Rec."Journal Batch Name");
                    PmtJnrExport.Run();
                end;
            }
        }
        addafter(CancelApprovalRequest)
        {
            action("View Approvals")
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category9;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    GetCurrentlySelectedLines(GenJournalLine);
                    ApprovalsMgmt.ShowJournalApprovalEntries(GenJournalLine);
                end;
            }
        }


        modify(Approvals)
        {
            Visible = false;
        }

    }

    local procedure GetCurrentlySelectedLines(var GenJournalLine: Record "Gen. Journal Line"): Boolean
    begin
        CurrPage.SetSelectionFilter(GenJournalLine);
        exit(GenJournalLine.FindSet);
    end;

}
