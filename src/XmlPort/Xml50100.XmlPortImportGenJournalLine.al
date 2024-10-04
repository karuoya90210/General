xmlport 50100 XmlPortImportGenJournalLine
{
    Caption = 'Import GL Transactions';
    Direction = Import;
    UseRequestPage = false;
    Format = VariableText;
    //TableSeparator = '';//New line
    schema
    {
        textelement(Root)
        {
            tableelement(GenJournalLine; "Gen. Journal Line")
            {
                fieldelement(PostingDate; GenJournalLine."Posting Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(DocumentNo; GenJournalLine."Document No.")
                {
                }
                fieldelement(AccountType; GenJournalLine."Account Type")
                {
                }
                fieldelement(AccountNo; GenJournalLine."Account No.")
                {
                    FieldValidate = Yes;
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
            Message('Journal Imported Successfully.');
        end;
    end;

    procedure SetJournalTemplateBatch(Template: Code[20]; Batch: Code[20])
    begin
        JournalTemplate := Template;
        JournalBatch := Batch;
    end;
}