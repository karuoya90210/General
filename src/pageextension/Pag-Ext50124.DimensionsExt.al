pageextension 50124 DimensionsExt extends Dimensions
{
    layout
    {
        Modify(Code)
        {
            trigger OnDrillDown()
            begin
                DisplayDimensionValues(Rec);
            end;
        }
    }

    procedure DisplayDimensionValues(Var DimensionsRec: Record Dimension)
    var
        DimenSionValueRec: Record "Dimension Value";
    begin
        DimenSionValueRec.Reset();
        DimenSionValueRec.SetRange("Dimension Code", DimensionsRec.Code);
        if not DimenSionValueRec.FindSet then
            exit;
        OpenDimensionValuesPageForSelectedDimension(DimenSionValueRec);
    end;

    local procedure OpenDimensionValuesPageForSelectedDimension(var DimenSionValue: Record "Dimension Value")
    var
        DimenSionValueLookup: Page "Dimension Values";
    begin
        DimenSionValueLookup.Editable := false;
        DimenSionValueLookup.SetTableView(DimenSionValue);
        DimenSionValueLookup.RunModal;
    end;
}
