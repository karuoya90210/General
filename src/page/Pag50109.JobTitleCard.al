page 50109 "Job Title Card"
{
    Caption = 'Job Title Card';
    PageType = Card;
    SourceTable = "Job Title";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notice Period field.';
                }
                field("Probation Notice Period"; Rec."Probation Notice Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Probation Notice Period field.';
                }
                field("Salary Scale"; Rec."Salary Scale")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salary Scale field.';
                }
            }
            group(Leadership)
            {
                field("Is Supervisor"; Rec."Is Supervisor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Is Supervisor field.';
                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Supervisor Name");
                    end;
                }
                field("Reports to"; Rec."Reports to")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reports to field.';
                }
                field("Supervisor No."; Rec."Supervisor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor No. field.';
                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Supervisor Name");
                    end;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor Name field.';
                }
                field("Is HOD"; Rec."Is HOD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Is HOD field.';
                    trigger OnValidate()
                    begin
                        Rec.CalcFields("HOD Name");
                    end;
                }
                field("HOD No."; Rec."HOD No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD No. field.';
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD Name field.';
                }
                field("Is Director"; Rec."Is Director")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Is Director field.';
                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Director Name");
                    end;
                }
                field("Director No."; Rec."Director No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Director No. field.';
                }
                field("Director Name"; Rec."Director Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Director Name field.';
                }
                field("Is Regional Head"; Rec."Is Regional Head")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Is Regional Office Coordinator field.';
                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Regional Head Name");
                    end;
                }
                field("Regional Head No."; Rec."Regional Head No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Regional Head No. field.';
                }
                field("Regional Head Name"; Rec."Regional Head Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Regional Head Name field.';
                }
                field("Is Regional HOD"; Rec."Is Regional HOD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Is Regional HOD field.';
                }
                field("Regional HOD No."; Rec."Regional HOD No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Regional HOD No. field.';
                }
                field("Regional HOD Name"; Rec."Regional HOD Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Regional HOD Name field.';
                }
                field("Is CEO"; Rec."Is CEO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Is CEO field.';
                }
                field("CEO No."; Rec."CEO No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CEO No. field.';
                }
                field("CEO Name"; Rec."CEO Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CEO Name field.';
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        BlankErr: Label '%1 cannot be blank.';
    begin
        if (CloseAction = CloseAction::LookupOK) or (CloseAction = CloseAction::OK) then begin
            if Format(Rec."Probation Notice Period") = '' then
                Error(BlankErr, Rec.FieldCaption("Probation Notice Period"));
        end;
    end;
}
