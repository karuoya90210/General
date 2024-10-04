table 50102 "Commitment Entries"
{
    Caption = 'Commitment Entries';
    DataClassification = ToBeClassified;
    LookupPageId = "Commitment Entries";
    DrillDownPageId = "Commitment Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
            AutoIncrement = false;
        }
        field(2; "Commitment No."; Code[20])
        {
            Caption = 'Commitment No';
            DataClassification = ToBeClassified;
        }
        field(3; "Commitment Date"; Date)
        {
            Caption = 'Commitment Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Commitment Type"; Enum "Commitment Type")
        {
            Caption = 'Commitment Type';
            DataClassification = ToBeClassified;
        }
        field(5; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(6; "Committed Amount"; Decimal)
        {
            Caption = 'Committed Amount';
            DataClassification = ToBeClassified;
        }
        field(7; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(8; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(9; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Global Dimension 1"; Code[20])
        {
            Caption = 'Global Dimension 1';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(11; "Global Dimension 2"; Code[20])
        {
            Caption = 'Global Dimension 2';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(12; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(13; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = CONST("G/L Account")) "G/L Account"
            else
            if ("Account Type" = CONST(Customer)) Customer
            else
            if ("Account Type" = CONST(Vendor)) Vendor
            else
            if ("Account Type" = CONST("Fixed Asset")) "Fixed Asset";
        }
        field(14; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }
        field(15; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(16; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(17; "Uncommittment Date"; Date)
        {
            Caption = 'Uncommittment Date';
            DataClassification = ToBeClassified;
        }
        field(18; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(19; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(20; "Document Type"; Enum "Commitment Document Type")
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
        }
        field(21; "Global Dimension 3"; Code[20])
        {
            Caption = 'Global Dimension 3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(22; "Global Dimension 4"; Code[20])
        {
            Caption = 'Global Dimension 4';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(23; "Global Dimension 5"; Code[20])
        {
            Caption = 'Global Dimension 5';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(24; "Global Dimension 6"; Code[20])
        {
            Caption = 'Global Dimension 6';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(25; "Global Dimension 7"; Code[20])
        {
            Caption = 'Global Dimension 7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(26; "Global Dimension 8"; Code[20])
        {
            Caption = 'Global Dimension 8';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        /*  field(27; "Payment Posted"; Boolean)
         {
             Caption = 'Payment Posted';
             FieldClass = FlowField;
             CalcFormula = lookup("Payment Voucher Header".Posted where(No = field("Commitment No.")));
         } */
        field(28; "Budget Code"; Code[20])
        {
            Caption = 'Budget Code';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name".Name;
        }
        field(29; Type; Enum "Purchase Line Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
            SumIndexFields = "Committed Amount";
        }
        key(Key2; "Commitment No.", "Commitment Type", "No.")
        {
            SumIndexFields = "Committed Amount";
        }
        key(Key3; "Document No.", "Commitment Type")
        {
            SumIndexFields = "Committed Amount";
        }
        key(Key4; "G/L Account No.", "Commitment Date", "Global Dimension 1", "Global Dimension 2")
        {
            SumIndexFields = "Committed Amount";
        }
        key(Key5; "No.", "Commitment Date")
        {
            SumIndexFields = "Committed Amount";
        }
    }
    var
        DimMgt: Codeunit DimensionManagement;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1', "Entry No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1", "Global Dimension 2");
    end;

}



