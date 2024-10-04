pageextension 50101 "Vendor Templ. PagExt" extends "Vendor Templ. Card"
{
    layout
    {
        addafter("Contact Type")
        {
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Type field.';
            }
        }
    }
}
