pageextension 50117 PurchaseJournal extends "Purchase Journal"
{
    actions
    {
        addafter("P&osting")
        {
            action("Import Purchase Journal Lines")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Import Purchase Journal Lines';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;
                ToolTip = 'Import Purchase Journal Lines';

                trigger OnAction()
                var
                    PurchJnrImport: XmlPort "Purchase Journal Imp";
                begin
                    PurchJnrImport.SetJournalTemplateBatch(Rec."Journal Template Name", Rec."Journal Batch Name");
                    PurchJnrImport.Run();
                    Message('File Imported Successfully');
                End;
            }

            action("Export Purchase Journal Lines")
            {
                Caption = 'Export Purchase Journal Lines';
                Promoted = true;
                PromotedCategory = Process;
                Image = Export;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchJnrExport: XmlPort PurchaseJournalExp;
                begin
                    PurchJnrExport.SetJournalTemplateBatch(Rec."Journal Template Name", Rec."Journal Batch Name");
                    PurchJnrExport.Run();
                end;
            }
        }
    }
}
