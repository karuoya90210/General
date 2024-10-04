pageextension 50108 "Customer Templ. Card" extends "Customer Templ. Card"
{
    layout
    {
        addafter("Contact Type")
        {
            field("Customer Type"; Rec."Customer Type")
            {
                ToolTip = 'Specifies the value of the Customer Type field.';
                ApplicationArea = All;
            }

        }
    }
}
