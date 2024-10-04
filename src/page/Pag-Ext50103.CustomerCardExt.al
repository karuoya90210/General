pageextension 50103 CustomerCardExt extends "Customer Card"
{
    layout
    {
        /* modify(Name)
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Emp: Record Employee;
            begin
                Emp.Reset();
                Emp.SetRange(Status, Emp.Status::Active);
                If Page.RunModal(Page::"Employee List", Emp) = Action::LookupOK then
                    Rec.Name := Emp.FullName();
            end;
        } */
        addafter("No.")
        {
            field("Customer Type"; Rec."Customer Type")
            {
                ToolTip = 'Specifies the value of Customer Type field.';
                ApplicationArea = All;
            }

            group(Employee)
            {
                Visible = Rec."Customer Type" = Rec."Customer Type"::Employee;
                Caption = 'Employee';
                field("Emp No."; Rec.EmpNo)
                {
                    //Caption = 'Name';
                    ApplicationArea = All;

                    /* trigger OnLookup(var Text: Text): Boolean
                    var
                        Emp: Record Employee;
                    begin
                        Emp.Reset();
                        Emp.SetRange(Status, Emp.Status::Active);
                        If Page.RunModal(Page::"Employee List", Emp) = Action::LookupOK then
                            Rec.Name := Emp.FullName();
                    end; */
                }
            }
        }
    }

    /* trigger OnOpenPage()
    begin
        IsNameVisible := true; 
    end; */


}
