tableextension 50100 "Vendor" extends Vendor
{
    fields
    {
        modify(Blocked)
        {
            trigger OnAfterValidate()
            begin
                if Blocked = Blocked::" " then
                    "Blocked Start Date" := 0D
                else
                    "Blocked Start Date" := Today;
            end;
        }
        Modify("Phone No.")
        {
            trigger OnBeforeValidate()
            begin
                GeneralMgt.ValidatePhoneNo("Phone No.", FieldCaption("Phone No."));
                ValidateTextFieldValue("Phone No.", FieldNo("Phone No."));
            end;
        }
        Modify("Mobile Phone No.")
        {
            trigger OnBeforeValidate()
            begin
                GeneralMgt.ValidatePhoneNo("Mobile Phone No.", FieldCaption("Mobile Phone No."));
                ValidateTextFieldValue("Mobile Phone No.", FieldNo("Mobile Phone No."));
            end;
        }
        field(52167423; "Vendor Registration No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Registration No.';
        }
        field(52167424; "Vendor Status"; Enum "Vendor Status")
        {
            DataClassification = ToBeClassified;
            InitValue = Active;
            Caption = 'Vendor Status';
        }
        field(50000; "Vendor Type"; Enum "Vendor Type")
        {
            Caption = 'Vendor Type';
            DataClassification = ToBeClassified;
        }
        field(52167425; "Reason for Blocking"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason for Blocking';
        }
        field(52167426; "KRA Pin No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'KRA Pin No.';
            trigger OnValidate()
            begin
                ValidateTextFieldValue("KRA Pin No.", FieldNo("KRA Pin No."));
            end;
        }
        
        field(52167428; "Blocked Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Blocked Start Date';
        }
        field(52167429; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bank."Bank Code";
            Caption = 'Bank Code';
        }
        field(52167430; "Bank Branch Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branch"."Branch Code" where("Bank Code" = field("Bank Code"));
            Caption = 'Bank Branch Code';
        }
        field(52167431; "Bank Account Number"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Account Number';
        }
        modify("Preferred Bank Account Code")
        {
            trigger OnAfterValidate()
            var
                VendorBankCode: Record "Vendor Bank Account";
            begin
                if VendorBankCode.Get("No.", "Preferred Bank Account Code") then begin
                    "Bank Code" := VendorBankCode."Bank Code";
                    "Bank Branch Code" := VendorBankCode."Bank Branch No.";
                    "Bank Account Number" := VendorBankCode."Bank Account No.";
                end;
            end;
        }
    }
    keys
    {
        key(Key1Ext; "Vendor Status")
        {
        }
        key(key2Ext; "Phone No.")
        {
        }
        key(Key3Ext; "VAT Registration No.")
        {
        }
        key(key4Ext; "E-Mail")
        {
        }
        key(key5Ext; "Vendor Registration No.")
        {
        }
    }
    var
        GeneralMgt: Codeunit "General Management";

    Procedure ValidateMobilePhoneNumber(txt: Text)
    var
        Matches: Record Matches;
        Regex: Codeunit Regex;
        Pattern,
                Value : Text;
    begin
        //Pattern := '[A-Z]{3}\-[0-9,A-Z]{3}';
        Pattern := '[0-9]{10}';
        if (Regex.IsMatch("Mobile Phone No.", Pattern, 0)) and (strlen("Mobile Phone No.") = 10) then begin

            Message('Valid Mobile Phone Number');
        end

        else begin
            Error('Invalid Mobile Phone Number');
        end;

    end;

    Procedure ValidatePhoneNumber(txt: Text)
    var
        Matches: Record Matches;
        Regex: Codeunit Regex;
        Pattern,
                Value : Text;
    begin
        //Pattern := '[A-Z]{3}\-[0-9,A-Z]{3}';
        Pattern := '[0-9]{10}';
        if (Regex.IsMatch("Phone No.", Pattern, 0)) and (strlen("Phone No.") = 10) then begin

            Message('Valid Phone Number');
        end

        else begin
            Error('Invalid Phone Number');
        end;
    end;

    local procedure ValidateTextFieldValue(FieldValue: Text[80]; FieldNo: Integer)
    var
        VendorRec: Record Vendor;
        Text001: Label 'Vendor %1 has already been assigned %2 as %3.';
        FilterLbl: Label 'WHERE(%1=CONST(%2),%3 =FILTER(<>%4))';
        RecRef: RecordRef;
        FieldRef: FieldRef;
        ViewFilter: Text;
    begin
        if RecRef.Get(Rec.RecordId) then begin
            FieldRef := RecRef.Field(FieldNo);
            if FieldValue <> '' then begin
                ViewFilter := StrSubstNo(FilterLbl, FieldRef.Name, FieldValue, FieldName("No."), "No.");
                VendorRec.Reset();
                VendorRec.SetView(ViewFilter);
                if VendorRec.FindFirst() then
                    Error(Text001, VendorRec."No.", FieldRef.Caption, FieldValue);
            end;
        end;
    end;
}