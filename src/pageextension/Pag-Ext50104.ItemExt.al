/* pageextension 50104 "ItemExt" extends "Item Card"
{
    layout
    {
        addlast("Costs & Posting")
        {
            field("G/L Budget Account"; Rec."G/L Budget Account")
            {
                ToolTip = 'Specifies the value of the G/L Budget Account field.';
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
    }
} */