Page 50105 "Salary Pointer"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Salary Pointer";
    SourceTableView = sorting(Priority) order(ascending);
    UsageCategory = Tasks;
    Caption = 'Salary Pointer';

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Salary Pointer"; Rec."Salary Pointer")
                {
                    ToolTip = 'Specifies the value of the Salary Pointer field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.';
                    ApplicationArea = All;
                }
                field("No. Of Emloyees"; Rec."No. Of Emloyees")
                {
                    ToolTip = 'Specifies the value of the No. Of Emloyees field';
                    ApplicationArea = All;
                }
                // field("Annual Leave Days"; Rec."Annual Leave Days")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Entitled Annual Leave Days field.';
                // }
                // field("Monthly Leave Days"; Rec."Monthly Leave Days")v
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Entitled Monthly Leave Days field.';
                // }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            /*   group(Pointer)
              {
                  action(Transactions)
                  {
                      ApplicationArea = Basic;
                      Caption = 'Transactions';
                      Image = Trace;
                      Promoted = true;
                      PromotedIsBig = true;
                      PromotedCategory = Process;
                      RunObject = Page "Scale Transactions";
                      RunPageLink = "Salary Scale" = field("Salary Scale"),
                                    "Salary Pointer" = field("Salary Pointer");
                  }
                  action("Update Employee Transactions")
                  {
                      ApplicationArea = All;
                      Promoted = true;
                      PromotedIsBig = true;
                      PromotedCategory = Process;
                      Image = UpdateDescription;

                      trigger OnAction()
                      var
                          PayrollProcessing: Codeunit "Payroll Processing";
                          Text001: Label 'Are you sure you want to update Scale %1 Pointer %2 employees with the current Scale transactions?';
                          Text002: Label 'Update completed successfully.';
                      begin
                          if Confirm(Text001, false, Rec."Salary Scale", Rec."Salary Pointer") then begin
                              PayrollProcessing.UpdateEmployeeScaleBenefits(Rec."Salary Scale", Rec."Salary Pointer", '', false);
                              Message(Text002);
                          end;
                      end;
                  }

              } */
        }
    }

    var
        Employee: Record Employee;
}

