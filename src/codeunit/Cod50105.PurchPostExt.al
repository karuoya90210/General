/* codeunit 50105 "Purch Post Ext"
{
    //Restrict user roles to invoice & receive on purchase order
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeSelectPostOrderOption', '', false, false)]
    local procedure CheckReceiveInvoiceRoles(DefaultOption: Integer; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header"; var Result: Boolean)
    var
        UserSetUpErr: Label 'The user %1 has not ben set up under user set up, Please contact your system administrator!';
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
        Selection: Integer;
        UserSetUp: Record "User Setup";
    begin
        if not UserSetUp.Get(UserId) then
            Error(UserSetUpErr, UserId);
        with PurchaseHeader do begin
            Selection := StrMenu(ReceiveInvoiceQst, DefaultOption);
            if Selection = 0 then
                Result := false;
            //Check Permissions
            case
                Selection of
                1:
                    begin
                        if not (UserSetUp."Purchase Order Roles" in [UserSetUp."Purchase Order Roles"::Receive, UserSetUp."Purchase Order Roles"::"Receive and Invoice"]) then
                            Error('You do not the permissions to receive! Please contact your system administrator');
                    end;
                2:
                    begin
                        if not (UserSetUp."Purchase Order Roles" in [UserSetUp."Purchase Order Roles"::Invoice, UserSetUp."Purchase Order Roles"::"Receive and Invoice"]) then
                            Error('You do not the permissions to Invoice! Please contact your system administrator');
                    end;
                3:
                    begin
                        if not (UserSetUp."Purchase Order Roles" in [UserSetUp."Purchase Order Roles"::"Receive and Invoice"]) then
                            Error('You do not the permissions to receive and Invoice! Please contact your system administrator');
                    end;
            end;
            Receive := Selection in [1, 3];
            Invoice := Selection in [2, 3];
            Result := true;
            IsHandled := true;
        end;
    end;

}
 */