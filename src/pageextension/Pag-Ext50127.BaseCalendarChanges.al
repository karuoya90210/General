pageextension 50127 "Base Calendar Changes" extends "Base Calendar Changes"
{
    layout
    {
        addafter(Nonworking)
        {
            field(Holiday; Rec.Holiday)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Holiday field.';
            }
        }
    }
}
