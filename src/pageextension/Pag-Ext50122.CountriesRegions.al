pageextension 50122 "Countries/Regions" extends "Countries/Regions"
{
    layout
    {
        addafter(Name)
        {
            field("Local"; Rec."Local")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Local field.';
            }
        }
    }
}
