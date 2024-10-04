pageextension 50114 GeneralJournal extends "General Journal"
{
    layout
    {
        modify("Document Type")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        

    }
    actions
    {
        addafter("Opening Balance")
        {
            action("Import Journal Lines")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Import Journal Lines';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;
                ToolTip = 'Import Journal Lines';

                trigger OnAction()
                var
                    GlJnrImport: XmlPort XmlPortImportGenJournalLine;
                begin
                    GlJnrImport.SetJournalTemplateBatch(Rec."Journal Template Name", Rec."Journal Batch Name");
                    GlJnrImport.Run();
                    Message('File Imported Successfully');
                End;
            }
            action("Export Journal Lines")
            {
                Caption = 'Export Journal Lines';
                Promoted = true;
                PromotedCategory = Process;
                Image = Export;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GlJnrExport: XmlPort XmlPortExportGenJournalLine;
                begin
                    GlJnrExport.SetJournalTemplateBatch(Rec."Journal Template Name", Rec."Journal Batch Name");
                    GlJnrExport.Run();

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
                PromotedCategory = Category10;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    [SecurityFiltering(SecurityFilter::Filtered)]
                    GenJournalLine: Record "Gen. Journal Line";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    GetCurrentlySelectedLines(GenJournalLine);
                    ApprovalsMgmt.ShowJournalApprovalEntries(GenJournalLine);
                end;
            }
        }

        Modify(Approvals)
        {
            Visible = False;
        }
    }

    local procedure GetCurrentlySelectedLines(var GenJournalLine: Record "Gen. Journal Line"): Boolean
    begin
        CurrPage.SetSelectionFilter(GenJournalLine);
        exit(GenJournalLine.FindSet());
    end;


}
