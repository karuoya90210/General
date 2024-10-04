tableextension 50129 "Vendor Bank Account" extends "Vendor Bank Account"
{
    fields
    {
        modify("Bank Branch No.")
        {
            TableRelation = "Bank Branch"."Branch Code" where("Bank Code" = field("Bank Code"));
            Caption = 'Bank Branch Code';
        }
        field(52167453; "Bank Code"; Code[20])
        {
            TableRelation = Bank."Bank Code";
            trigger OnValidate()
            var
                Bank: Record Bank;
            begin
                if Bank.Get("Bank Code") then
                    Name := Bank."Bank Name";

            end;
        }
        field(52167454; "No Series"; Code[20])
        {
            TableRelation = Bank."Bank Code";
        }
    }

    trigger OnBeforeInsert()
    var
        PurchPayableSetUp: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if Code = '' then begin
            PurchPayableSetUp.Get();
            PurchPayableSetUp.TestField("Vendor Bank Acc Nos");
            NoSeriesMgt.InitSeries(PurchPayableSetUp."Vendor Bank Acc Nos", xRec."No Series", 0D, Code, "No Series");
        end;
    end;
}
