controladdin DocumentPreview
{
    VerticalStretch = true;
    HorizontalStretch = true;
    RequestedHeight = 600;
    VerticalShrink = true;
    HorizontalShrink = true;
    StartupScript = 'Startup.js';
    Scripts = 'LoadFile.js';
    event Ready();
    procedure GetDocumentBase64(DocumentValue: Text);
}