codeunit 50103 "VAT Registration No. Format"
{


    [EventSubscriber(ObjectType::Table, Database::"VAT Registration No. Format", 'OnBeforeCheckVend', '', false, false)]
    local procedure CheckVendorVAT(Number: Code[20]; var IsHandled: Boolean; VATRegNo: Text[20])
    begin
        CheckVendor(VATRegNo, Number);
        IsHandled := true;
    end;

    local procedure CheckVendor(VATRegNo: Text[20]; Number: Code[20]): Boolean
    var
        Vend: Record Vendor;
        Check: Boolean;
        Finish: Boolean;
        TextString: TextBuilder;
        IsHandled: Boolean;
    begin
        Check := true;
        Clear(TextString);
        Vend.SetCurrentKey("VAT Registration No.");
        Vend.SetRange("VAT Registration No.", VATRegNo);
        Vend.SetFilter("No.", '<>%1', Number);
        if Vend.FindSet then begin
            Check := false;
            Finish := false;
            repeat
                AppendString(TextString, Finish, Vend."No." + ' - ' + Vend.Name);
            until (Vend.Next() = 0) or Finish;
        end;
        if not Check then begin
            ShowCheckVendMessage(TextString);
            exit(false);
        end;
        exit(true);
    end;

    local procedure ShowCheckVendMessage(TextString: TextBuilder)
    var
        IsHandled: Boolean;
        Text003: Label 'This VAT registration number has already been entered for the following vendors:\ %1';
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        Message(StrSubstNo(Text003, TextString.ToText()));
    end;

    local procedure AppendString(var String: TextBuilder; Finish: Boolean; AppendText: Text)
    begin
        case true of
            Finish:
                exit;
            String.ToText() = '':
                String.AppendLine(AppendText);
            else begin
                String.AppendLine(AppendText);
                Finish := true;
            end;
        end;
    end;


}
