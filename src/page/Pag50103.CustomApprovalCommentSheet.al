page 50103 "Custom Approval Comment Sheet"
{
    AutoSplitKey = true;
    Caption = 'Comment Sheet';
    DataCaptionFields = "Document Type", "Document No.";
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    Editable = false;
    PageType = List;
    SourceTable = "Approval Comment Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("Date and Time"; Rec."Date and Time")
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies the date the comment was created.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies the comment itself.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies a code for the comment.';
                }
            }
        }
    }
    actions
    {
    }
    var
        hhf: Page "Purchase Order";
}
