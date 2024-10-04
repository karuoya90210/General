xmlport 50102 "Payment Journal"
{
    Caption = 'Import Payments Transactions';
    Direction = Import;
    UseRequestPage = false;
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
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
                fieldelement(CurrencyCode; GenJournalLine."Currency Code")
                {
                }
                fieldelement(PaymentMethodCode; GenJournalLine."Payment Method Code")
                {
                }
                fieldelement(PaymentReference; GenJournalLine."Payment Reference")
                {
                }
                /*fieldelement(CreditorNo; GenJournalLine."Creditor No.")
                {
                }*/
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

                trigger OnAfterInitRecord()
                begin
                    If FirstRow then begin
                        FirstRow := false;
                        currXMLport.Skip();
                    end;
                end;

                trigger OnBeforeInsertRecord()
                begin
                    LastLineNo += 10000;
                    GenJournalLine."Line No." := LastLineNo;
                    GenJournalLine."Journal Template Name" := JournalTemplate;
                    GenJournalLine."Journal Batch Name" := JournalBatch;
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        FirstRow: Boolean;
        JournalTemplate, JournalBatch : Code[10];
        LastLineNo: Integer;
        GL: Record "Gen. Journal Line";

    trigger OnInitXmlPort()
    begin
        FirstRow := true;
    end;

    trigger OnPostXmlPort()
    begin
        GL.SetRange("Journal Template Name", JournalTemplate);
        GL.SetRange("Journal Batch Name", JournalBatch);
        If GL.FindFirst() then begin
            Message('Payments Imported Successfully.');
        end;
    end;

    procedure SetJournalTemplateBatch(Template: Code[20]; Batch: Code[20])
    begin
        JournalTemplate := Template;
        JournalBatch := Batch;
    end;

}
