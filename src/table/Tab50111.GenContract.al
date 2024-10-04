table 50111 "Gen. Contract"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Validate(Validity);
            end;
        }
        field(3; Validity; DateFormula)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if ("Start Date" <> 0D) or (Format(Validity) <> '') then
                    Rec."Expiry Date" := CalcDate(Rec.Validity, Rec."Start Date")
                else
                    Rec."Expiry Date" := 0D;
            end;
        }
        field(4; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,"Pending Approval",Approved;
            Editable = false;
        }
        field(6; "Contract Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,Active,Renewed,Expired,Closed;
        }
        field(7; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(8; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
            trigger OnValidate()
            var
                VendorRec: Record Vendor;
            begin
                if VendorRec.Get("Vendor No.") then begin
                    "Vendor Name" := VendorRec.Name;
                    if VendorRec."Primary Contact No." <> '' then begin
                        "Vendor Contact" := VendorRec."Primary Contact No.";
                        Validate("Vendor Contact");
                    end else begin
                        "Vendor Contact Name" := VendorRec.Contact;
                        "Vendor Contact E-mail" := VendorRec."E-Mail";
                    end;
                end else
                    if xRec."Vendor Name" <> '' then
                        "Vendor Name" := '';
            end;
        }
        field(9; "Vendor Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Contract Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
            CaptionClass = '1,1,1';
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), "Dimension Value Type" = CONST(Standard), Blocked = const(false));
            CaptionClass = '1,2,2';
        }
        field(15; "Vendor Reference No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Contract Priority"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Low,High;
        }
        field(17; "Contract Owner"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No." where(Status = const(Active));
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Contract Owner") then begin
                    "Contact Name" := Employee.FullName();
                    "Contact E-mail" := Employee."E-Mail";
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                end else
                    if xRec."Contract Owner" <> '' then begin
                        "Contact Name" := '';
                        "Contact E-mail" := '';
                        "Global Dimension 1 Code" := '';
                        "Global Dimension 2 Code" := '';
                    end;
            end;
        }
        field(18; "Contact Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Contact E-mail"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Vendor Contact"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact."No.";
            trigger OnValidate()
            var
                ContactRec: Record Contact;
            begin
                if xRec."Vendor Contact" <> '' then begin
                    "Vendor Contact Name" := '';
                    "Vendor Contact E-mail" := '';
                end;
                if ContactRec.Get("Vendor Contact") then begin
                    "Vendor Contact Name" := ContactRec.Name;
                    "Vendor Contact E-mail" := ContactRec."E-Mail";
                end;
            end;
        }
        field(21; "Vendor Contact Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Vendor Contact E-mail"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "External Contact"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "External Contact E-mail"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Renewal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Validate("Actual Amount", Amount);
                Validate("Tax Rate");
                Validate(Discount);
            end;
        }
        field(27; "Tax Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tax Rate(%)';
            trigger OnValidate()
            begin
                if Amount <> 0 then
                    Tax := ("Tax Rate" / 100) * Amount;

                Validate(Discount);
            end;
        }
        field(28; Tax; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Payment Terms"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Weekly,Monthly,Quarterly,Yearly;
            trigger OnValidate()
            begin
                TestField(Amount);
            end;
        }
        field(30; Discount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount(%)';
            trigger OnValidate()
            begin
                Clear("Actual Amount");
                Clear("Discount Amount");
                if Amount <> 0 then begin
                    "Discount Amount" := (Discount / 100) * (Amount - Tax);
                    "Actual Amount" := (Amount - Tax - "Discount Amount");
                end;
            end;
        }
        field(31; "Actual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Installment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Date Filter"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Vendor Contact II"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = const(Person));
            trigger OnValidate()
            begin
                if "Vendor Contact II" = '' then begin
                    "Vendor Contact II E-mail" := '';
                    "Vendor Contact II Name" := '';
                end;
                if Contact.Get("Vendor Contact II") then begin
                    "Vendor Contact II E-mail" := Contact."E-Mail";
                    "Vendor Contact II Name" := Contact.Name;
                end;
            end;
        }
        field(37; "Vendor Contact II E-mail"; Text[80])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(38; "Vendor Contact II Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Renewable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Contract File No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Contact Department"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "RFQ File No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Scope of Works"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Specifications"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Created By"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup";
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(key2; "Contract Status")
        {
        }
        key(key3; Status)
        {
        }
        key(key4; "Contract Status", Status)
        {
        }
        key(key5; "Renewal Date")
        {
        }
    }

    var
        PurchPaySetUp: Record "Purchases & Payables Setup";
        NoseriesMgt: Codeunit NoSeriesManagement;
        Contact: Record Contact;

    trigger OnInsert()
    var
        Employee: Record Employee;
        GeneralMgt: Codeunit "General Management";
    begin
        IF "No." = '' THEN BEGIN
            PurchPaySetUp.GET();
            PurchPaySetUp.TESTFIELD("Contract Nos");
            NoseriesMgt.InitSeries(PurchPaySetUp."Contract Nos", Xrec."No Series", 0D, "No.", "No Series");
        END;
        if Employee.Get(GeneralMgt.GetEmployeeNo(UserId)) then
            Validate("Contract Owner", Employee."Immediate Supervisor");
        "Created By" := UserId;
    end;

    trigger OnDelete()
    begin
        if ("Contract Status" <> "Contract Status"::New) or (Status <> Status::New) then
            Error('You cannot delete an %1 %2 contract', Status, "Contract Status");
    end;
}