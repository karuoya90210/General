pageextension 50106 "G/L Budget Names" extends "G/L Budget Names"
{
    layout
    {
         /*Modify("Budget Dimension 1 Code")
        {
            Visible = false;
        }        
        Modify("Budget Dimension 2 Code")
        {
            Visible = false;
        }
        Modify("Budget Dimension 3 Code")
        {
            Visible = false;
        }
        Modify("Budget Dimension 4 Code")
        {
            Visible = false;
        } */
        addafter(Description)
        {
            field("Budget Start Date"; Rec."Budget Start Date")
            {
                ApplicationArea = Basic, Suite;
                ShowMandatory = true;
            }
            field("Budget End Date"; Rec."Budget End Date")
            {
                ApplicationArea = Basic, Suite;
                ShowMandatory = true;
                Editable = false;
            }
            /* field(Year; Rec.Year)
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            } */
        }

    }

}
