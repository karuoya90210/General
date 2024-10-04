/* pageextension 50101 "Document Attachment Details" extends "Document Attachment Details"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Attachment Type"; Rec."Attachment Type")
            {
                ApplicationArea = all;
                Visible = false;
            }
            
            field("Mail Attachment"; Rec."Mail Attachment")
            {
                ApplicationArea = all;
            }
        }

        addafter("File Type")
        {

            field("Send Attachment"; Rec."Send Attachment")
            {
                ToolTip = 'Specifies the value of the Send Attachment field.';
                ApplicationArea = All;
                Visible = SendAttachVisible;
            }
        }
    }
    actions
    {
        addafter(Preview)
        {
            action(PreviewDocument)
            {
                Caption = 'Preview Document';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = "Invoicing-MDL-PreviewDoc";

                trigger OnAction()
                var
                    DocumentPerview: Page "Document Preview";
                begin
                    Clear(DocumentPerview);
                    DocumentPerview.GetDocument(Rec);
                    DocumentPerview.Run();
                end;
            }
            action(BulkDownload)
            {
                Caption = 'Bulk Download';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    FileManagement: Codeunit "File Management";
                    DocumentOutStream: OutStream;
                    DocumentInStream: InStream;
                    ZipOutStream: OutStream;
                    ZipInStream: InStream;
                    FullFileName: Text;
                    DataCompression: Codeunit "Data Compression";
                    ZipFileName: Text[50];
                    DocumentAttachment: Record "Document Attachment";
                begin
                    ZipFileName := 'Attachments_' + Format(CurrentDateTime) + '.zip';
                    DataCompression.CreateZipArchive();
                    DocumentAttachment.Reset();
                    CurrPage.SetSelectionFilter(DocumentAttachment);
                    if DocumentAttachment.FindSet() then
                        repeat
                            if DocumentAttachment."Document Reference ID".HasValue then begin
                                TempBlob.CreateOutStream(DocumentOutStream);
                                DocumentAttachment."Document Reference ID".ExportStream(DocumentOutStream);
                                TempBlob.CreateInStream(DocumentInStream);
                                FullFileName := DocumentAttachment."File Name" + '.' + DocumentAttachment."File Extension";
                                DataCompression.AddEntry(DocumentInStream, FullFileName);
                            end;
                        until DocumentAttachment.Next() = 0;
                    TempBlob.CreateOutStream(ZipOutStream);
                    DataCompression.SaveZipArchive(ZipOutStream);
                    TempBlob.CreateInStream(ZipInStream);
                    DownloadFromStream(ZipInStream, '', '', '', ZipFileName);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        DowbloadEnabled := Rec."Document Reference ID".HasValue();
    end;

    var
        DowbloadEnabled: Boolean;

        trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetPageControl();
    end;

    var
        SendAttachVisible: Boolean;

    local procedure SetPageControl()
    var
        myInt: Integer;
    begin
        SendAttachVisible := true;
        case Rec."Table ID" of
            database::"RFQ Header":
                begin
                end;
            else
                SendAttachVisible := false;
        end;
    end;
}
 */