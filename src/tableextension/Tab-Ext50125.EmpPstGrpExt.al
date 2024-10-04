tableextension 50125 EmpPstGrpExt extends "Employee Posting Group"
{
    fields
    {
        // Add changes to table fields here
        field(52167423; "Imprest Account1"; Code[20])
        {
            Caption = 'Imprest Account';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Imprest Account1");
            end;
        }
    }
    local procedure CheckGLAcc(AccNo: Code[20])
    var
        GLAcc: Record "G/L Account";
    begin
        if AccNo <> '' then begin
            GLAcc.Get(AccNo);
            GLAcc.CheckGLAcc;
        end;
    end;



}