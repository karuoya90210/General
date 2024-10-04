tableextension 50133 "Customer" extends Customer
{
    fields
    {
        modify("VAT Registration No.")
        {
            Caption = 'KRA Pin Registration';
        }
        field(52167423; "Customer Type"; Enum "Customer Type")
        {
            Caption = 'Customer Type';
            DataClassification = ToBeClassified;
        }
        field(50100; EmpNo; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No." WHERE("Employee Status" = CONST(Active));
        }
    }
    trigger OnBeforeInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        gg: record "G/L Budget Entry";
        gg2: record "G/L Budget Name";
    begin
        if "No." = '' then begin
            case "Customer Type" of
            end;
        end;
    end;
}
