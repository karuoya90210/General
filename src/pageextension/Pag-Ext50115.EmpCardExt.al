pageextension 50115 EmpCardExt extends "Employee Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Employee Posting Group")
        {
            field("Imprest Posting Group"; Rec."Imprest Posting Group1")
            {
                ApplicationArea = all;
                Caption = 'Imprest Posting Group';
            }
        }

        addafter("Imprest Posting Group")
        {
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = all;
                Caption = 'Employee as a Customer No.';
            }
        }
        addlast(content)
        {
            part("Assets Assigned"; "Assets Assigned")
            {
                Caption = 'Assets Assigned';
                SubPageLink = "Responsible Employee" = field("No.");
                ApplicationArea = all;
                Editable = false;
            }
        }

    }
}