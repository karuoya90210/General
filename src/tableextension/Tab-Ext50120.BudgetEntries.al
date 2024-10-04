tableextension 50120 BudgetEntries extends "G/L Budget Entry"
{
    
    fields
    {
        modify("Budget Dimension 1 Code")
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), "Dimension Value Type" = CONST(Standard), Blocked = const(false));
            CaptionClass = '1,2,3';
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                
            end;
        }
        modify("Budget Dimension 2 Code")
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), "Dimension Value Type" = CONST(Standard), Blocked = const(false));
            CaptionClass = '1,2,4';
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                
            end;
        }
        modify("Budget Dimension 3 Code")
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), "Dimension Value Type" = CONST(Standard), Blocked = const(false));
            CaptionClass = '1,2,5';
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                
            end;
        }
    }
}
