xmlport 50105 PurchaseJournalExp
{
    Caption = 'PurchaseJournalExp';
    Direction = Export;
    UseRequestPage = false;
    Format = VariableText;
    TextEncoding = UTF8;
    //TableSeparator = '';//New line
    //TableSeparator = '<NewLine>';
    TableSeparator = '<NewLine>';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Integer; Integer)
            {
                SourceTableView = where(Number = filter(1 .. 2));
                textelement(PostingDateCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PostingDateCaption := GenJournalLine.FieldCaption("Posting Date");
                    end;
                }
                textelement(DocumentTypeCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DocumentTypeCaption := GenJournalLine.FieldCaption("Document Type");
                    end;
                }
                textelement(DocumentNoCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DocumentNoCaption := GenJournalLine.FieldCaption("Document No.");
                    end;
                }
                textelement(DocumentExternalDocumentNoCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DocumentNoCaption := GenJournalLine.FieldCaption("External Document No.");
                    end;
                }
                textelement(AccountTypeCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        AccountTypeCaption := GenJournalLine.FieldCaption("Account Type");
                    end;
                }
                textelement(AccountNoCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        AccountNoCaption := GenJournalLine.FieldCaption("Account No.");
                    end;
                }
                textelement(DescriptionCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DescriptionCaption := GenJournalLine.FieldCaption(Description);
                    end;
                }

                textelement(AmountCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        AmountCaption := GenJournalLine.FieldCaption(Amount);
                    end;
                }
                textelement(BalAccountTypeCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BalAccountTypeCaption := GenJournalLine.FieldCaption("Bal. Account Type");
                    end;
                }
                textelement(BalAccountNoCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BalAccountNoCaption := GenJournalLine.FieldCaption("Bal. Account No.");
                    end;
                }
                textelement(ShortcutDimension1CodeCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ShortcutDimension1CodeCaption := GenJournalLine.FieldCaption("Shortcut Dimension 1 Code");
                    end;
                }
                textelement(ShortcutDimension2CodeCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ShortcutDimension2CodeCaption := GenJournalLine.FieldCaption("Shortcut Dimension 2 Code");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    If Integer.Number = 2 then
                        currXMLport.Skip();
                end;
            }

            tableelement(GenJournalLine; "Gen. Journal Line")
            {
                fieldelement(PostingDate; GenJournalLine."Posting Date")
                {
                }
                fieldelement(DocumentType; GenJournalLine."Document Type")
                {
                }
                fieldelement(DocumentNo; GenJournalLine."Document No.")
                {
                }
                fieldelement(ExternalDocumentNo; GenJournalLine."External Document No.")
                {
                }
                fieldelement(AccountType; GenJournalLine."Account Type")
                {
                }
                fieldelement(AccountNo; GenJournalLine."Account No.")
                {
                }
                fieldelement(Description; GenJournalLine.Description)
                {
                }
                fieldelement(Amount; GenJournalLine.Amount)
                {
                }
                fieldelement(BalAccountType; GenJournalLine."Bal. Account Type")
                {
                }
                fieldelement(BalAccountNo; GenJournalLine."Bal. Account No.")
                {
                }
                fieldelement(ShortcutDimension1Code; GenJournalLine."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(ShortcutDimension2Code; GenJournalLine."Shortcut Dimension 2 Code")
                {
                }
                trigger OnPreXmlItem()
                begin
                    GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                end;
            }
        }
    }

    trigger OnPostXmlPort()
    begin
        currXMLport.Filename := 'Purchase Journal Import.Csv';
    end;

    procedure SetJournalTemplateBatch(Template: Code[20]; Batch: Code[20])
    begin
        JournalTemplate := Template;
        JournalBatch := Batch;
    end;

    var
        JournalTemplate: Code[10];
        JournalBatch: Code[10];
}