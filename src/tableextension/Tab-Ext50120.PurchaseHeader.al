/* tableextension 50120 "Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(51002; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(51003; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        //Begin Budget
        field(50081; "Budget Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
            Caption = 'Budget Code';
        }

        field(50202; "Total Quantity "; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Quantity where("Document No." = field("No."), "Document Type" = filter(Order)));
            Caption = 'Total Quantity ';
        }
        field(50203; "Total Quantity Received "; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Quantity Received" where("Document No." = field("No."), "Document Type" = filter(Order)));
            Caption = 'Total Quantity Received ';
        }
        field(50204; Contract; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Contract';
        }
        field(50205; "Inspection Cert RecordID"; RecordId)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50206; "Pending Approver"; Code[50])
        {
            Caption = 'Pending Approver';
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Approver ID" where("Document No." = field("No."), Status = const(Open)));
            Editable = false;
        }
        modify("Vendor Invoice No.")
        {
            trigger OnAfterValidate()
            var
                ph: Record "Purchase Header";
            begin
                ph.Reset();
                ph.SetRange("Vendor Invoice No.", Rec."Vendor Invoice No.");
                if ph.FindFirst() then begin
                    Error('Invoice No. already exists');
                    Rec."Vendor Invoice No." := '';
                end
            end;
        }
    }

   
}
 */