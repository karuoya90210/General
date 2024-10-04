pageextension 50102 "User Setup" extends "User Setup"
{
    layout
    {
        addafter("Allow Deferral Posting To")
        {
            field("Allow Payroll";Rec."Allow Payroll")
            {
                ToolTip = 'Specifies the value of Allow Payroll field.';
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Job Position";Rec."Job Position")
            {
                ToolTip = 'Specifies the value of ob Position field.';
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("HR User";Rec."HR User")
            {
                ToolTip = 'Specifies the value of Allow Payroll field.';
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("HR Notification";Rec."HR Notification")
            {
                ToolTip = 'Specifies the value of Notification field.';
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Finance User";Rec."Finance User")
            {
                ToolTip = 'Specifies the value of Finance User field.';
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Procurement Officer";Rec."Procurement Officer")
            {
                ToolTip = 'Specifies the value of Procurement User field.';
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field(Department;Rec.Department)
            {
                ToolTip = 'Specifies the value of Department field.';
                ApplicationArea = All;
                ShowMandatory = true;
            }
             field("Inventory Notification"; Rec."Inventory Notification")
            {
                ToolTip = 'Specifies the value of the Inventory Notification field.';
                ApplicationArea = All;
            }
            field("Fixed Asset Notification"; Rec."Fixed Asset Notification")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fixed Asset Notification field.';
            }
            
        }
    }
}
