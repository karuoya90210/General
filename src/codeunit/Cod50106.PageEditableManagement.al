codeunit 50106 "Page Editable Management"
{
    var
        GeneralMgt: Codeunit "General Management";
    procedure CanEditPage(CreatedBy: Code[30]) CanEdit: Boolean
    var
        UserSetUp: Record "User Setup";
    begin
        GeneralMgt.CheckUserSetup(UserId);
        UserSetUp.Get(UserId);
        CanEdit := (CreatedBy = UserId) or UserSetUp."Can Edit All Pages";
    end;

    procedure CanEditPage(CreatedByGUID: Guid) CanEdit: Boolean
    var
        User: Record User;
        UserSetUp: Record "User Setup";
        TextCreatedUID: Text;
    begin
        TextCreatedUID := format(CreatedByGUID).ToUpper();
        //if Created By is Blank
        if CreatedByGUID = '00000000-0000-0000-0000-000000000000' then
            exit(true);
        GeneralMgt.CheckUserSetup(UserId);
        UserSetUp.Get(UserId);
        User.Reset();
        User.SetRange("User Name", UserId);
        if User.FindFirst() then begin
            CanEdit := (TextCreatedUID = User."User Security ID") or UserSetUp."Can Edit All Pages";
        end;
    end;
}
