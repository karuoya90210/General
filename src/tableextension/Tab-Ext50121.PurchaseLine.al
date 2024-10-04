/* tableextension 50121 "Purchase Line" extends "Purchase Line"
{
    fields
    {
        field(50000; "Posting Description"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Description';
        }

        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            begin
                Validate("Line Amount");
            end;
        }
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnAfterValidate()
            begin
                Validate("Line Amount");
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                ItemBudgetAcc: Record "Item Budget A/C";
                Item: Record Item;
            begin
                if Type = Type::Item then begin
                    //Populate the Item Budget A/C
                    if "Item Budget A/C Code" = '' then begin
                        if Item.Get("No.") then;
                        if ItemBudgetAcc.Get(Item."G/L Budget Account") then begin
                            "Item Budget A/C Code" := ItemBudgetAcc.Code;
                        end;
                    end;
                end;
            end;
        }
        field(50001; "Item Budget A/C Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Budget A/C".Code;
        }
        //
         //Start Budget
        field(50081; Committment; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Committment';
        }
        //End Budget

        //Start Procurement
        field(50201; "Procurement Plan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan";
            Editable = false;
            Caption = 'Procurement Plan No.';
        }
        field(50202; "Procurement Plan Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan Lines"."Line No." where("Document No." = field("Procurement Plan No."));
            Editable = false;
            Caption = 'Procurement Plan Line No.';
        }
        field(50203; "Requisition No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Requisition";
            Editable = false;
            Caption = 'Requisition No.';
        }
        field(50204; "Requisition Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Requisition Lines"."Line No." where("Document No." = field("Requisition No."));
            Editable = false;
            Caption = 'Requisition Line No.';
        }
        field(50205; "RFQ No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "RFQ Header";
            Editable = false;
            Caption = 'RFQ No.';
        }
        field(50206; "RFQ Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "RFQ Requisitions"."Line No." where("Document No." = field("RFQ No."));
            Editable = false;
            Caption = 'RFQ Line No.';
        }
        field(50207; "Procurement Method"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Method";
            Editable = false;
            Caption = 'Procurement Method';
        }
        //End Procurement

        //
    }

    trigger OnAfterInsert()
    var
        PurchHeader: Record "Purchase Header";
        DimensionMgt: Codeunit DimensionManagement;
        DimensionCodes: array[8] of Code[20];
    begin
        PurchHeader.Reset();
        PurchHeader.SetRange("No.", "Document No.");
        PurchHeader.SetRange("Document Type", "Document Type");
        if PurchHeader.FindFirst() theN begin
            DimensionMgt.GetShortcutDimensions(PurchHeader."Dimension Set ID", DimensionCodes);
            "Dimension Set ID" := PurchHeader."Dimension Set ID";
            "Shortcut Dimension 1 Code" := DimensionCodes[1];
            "Shortcut Dimension 2 Code" := DimensionCodes[2];
        end;
    end;
}

 */