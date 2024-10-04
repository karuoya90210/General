page 50100 "Document Preview"
{
    Caption = 'Document Preview';
    PageType = Card;

    layout
    {
        area(content)
        {
            usercontrol(Document; DocumentPreview)
            {
                ApplicationArea = all;
                trigger Ready()
                begin

                    TempBlob.CreateOutStream(OutStr);

                    DocumentAttachment."Document Reference ID".ExportStream(OutStr);

                    TempBlob.CreateInStream(InStr);
                    Base64Text := Convert.ToBase64(InStr);

                    DocumentValue := Base64Text;

                    CurrPage.Document.GetDocumentBase64(DocumentValue);
                end;

            }
        }
    }

    procedure GetDocument(var DocAttachement: Record "Document Attachment")
    begin
        DocumentAttachment := DocAttachement;
    end;

    var
        DocumentAttachment: Record "Document Attachment";
        TableId: Integer;
        DocNo: Code[20];
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        Convert: Codeunit "Base64 Convert";
        Base64Text: Text;
        Content: Label 'data:application/pdf;base64,%1';
        DocumentValue: Text;
}
