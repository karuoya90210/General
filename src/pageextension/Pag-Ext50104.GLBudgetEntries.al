pageextension 50104 "GLBudget Entries" extends "G/L Budget Entries"
{

    layout
    {
        modify("Budget Dimension 1 Code")
        {
            Visible = true;
            Enabled = true;
            Editable = true; 
            /* trigger OnLookup(var Text: Text): Boolean
            var
                DimV: Record "Dimension Value";
            begin
                // Custom lookup logic
                DimV.Reset();
                DimV.SetRange("Global Dimension No.", 3); // Example filter
                if Page.RunModal(Page::"Dimension Value List", DimV) = Action::LookupOK then begin
                    Rec."Budget Dimension 1 Code" := DimV."Code";

                    // Debug before and after the assignment
                    Message('Before Assignment1: %1', Rec."Budget Dimension 1 Code");
                    Rec.Modify(); // Persist change
                    Rec.Validate("Budget Dimension 1 Code"); // Validate
                    Message('After Assignment2: %1', Rec."Budget Dimension 1 Code");

                    CurrPage.Update(); // Refresh the page
                    exit(true); // Exit and mark as successful
                end;
                exit(false); // Exit without any changes
            end; */
        }
        modify("Budget Dimension 2 Code")
        {
            Visible = true;
            Enabled = true;
            Editable = true;

            /* trigger OnLookup(var Text: Text): Boolean
            var
                DimV: Record "Dimension Value";
            begin
                // Custom lookup logic
                DimV.Reset();
                DimV.SetRange("Global Dimension No.", 4); // Example filter
                if Page.RunModal(Page::"Dimension Value List", DimV) = Action::LookupOK then begin
                    Rec."Budget Dimension 2 Code" := DimV.Code; // Assign the selected value
                    exit(true); // Exit and mark as successful
                end;
                exit(false); // Exit without any changes
            end; */
        }
        modify("Budget Dimension 3 Code")
        {
            Visible = true;
            Enabled = true;
            Editable = true;
            
            /* trigger OnLookup(var Text: Text): Boolean
            var
                DimV: Record "Dimension Value";
            begin
                // Custom lookup logic
                DimV.Reset();
                DimV.SetRange("Global Dimension No.", 5); // Example filter
                if Page.RunModal(Page::"Dimension Value List", DimV) = Action::LookupOK then begin
                    Rec."Budget Dimension 3 Code" := DimV.Code; // Assign the selected value
                    exit(true); // Exit and mark as successful
                end;
                exit(false); // Exit without any changes
            end; */
        }

        addafter("Global Dimension 2 Code")
        {
            /* field("Budget Dime K Code";Rec."Budget Dimension 1 Code")
            {
                ToolTip = 'Specifies the value of Budget Dimension 2 Code field.';
                ApplicationArea = All;
            } */

            /* field("Budget Dimension 2  Code";Rec."Budget Dimension 2 Code")
            {
                ToolTip = 'Specifies the value of Budget Dimension 2 Code field.';
                ApplicationArea = All;
                //ShowMandatory = true;
            }
            field("Budget Dimension 3  Code";Rec."Budget Dimension 3 Code")
            {
                ToolTip = 'Specifies the value of Budget Dimension 2 Code field.';
                ApplicationArea = All;
                //ShowMandatory = true;
            }
            field("Budget Dimension 4  Code";Rec."Budget Dimension 4 Code")
            {
                ToolTip = 'Specifies the value of Budget Dimension 2 Code field.';
                ApplicationArea = All;
                //ShowMandatory = true;
            } */
        }
    }
}
