page 50102 "Rejection Comments"
{
    PageType = StandardDialog;
    Caption = 'Comments';

    layout
    {
        area(content)
        {
            group(Control2)
            {
                ShowCaption = false;

                field(RejectComment; RejectComment)
                {
                    Caption = 'Comment';
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Comment field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var
        RejectComment: Text;

    procedure GetRejectComment(): Text
    begin
        exit(RejectComment);
    end;

    procedure SetRejectComment(Comment: Text)
    begin
        RejectComment := Comment;
    end;
}
