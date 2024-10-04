table 50107 "Job Title"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Job Titles";
    DrillDownPageId = "Job Titles";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(3; "Reports to"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Title";
            Caption = 'Reports to';

            trigger OnValidate()
            var
                Employee, EmployeeRec : Record Employee;
                Found: Boolean;
            begin
                if "Reports to" <> '' then begin
                    if "Reports to" = Code then
                        Error('Select another position to report to!');

                    EmployeeRec.Reset();
                    EmployeeRec.SetRange("Job Title2", "Reports to");
                    EmployeeRec.SetRange("Employee Status", EmployeeRec."Employee Status"::Active);
                    if EmployeeRec.FindFirst() then
                        if (EmployeeRec.Count = 1) then begin
                            "Supervisor No." := EmployeeRec."No.";
                            Found := true;
                            Employee.Reset();
                            Employee.SetRange("Job Title2", Code);
                            if Employee.FindSet() then
                                repeat
                                    Employee.Validate("Immediate Supervisor", EmployeeRec."No.");
                                    Employee.Modify();
                                until Employee.Next() = 0;
                        end;
                end else begin
                    EmployeeRec.Reset();
                    EmployeeRec.SetRange("Job Title2", xRec."Reports to");
                    EmployeeRec.SetRange("Employee Status", EmployeeRec."Employee Status"::Active);
                    if EmployeeRec.FindFirst() then
                        if (EmployeeRec.Count = 1) then begin
                            Employee.Reset();
                            Employee.SetRange("Job Title2", Code);
                            if Employee.FindSet() then
                                repeat
                                    Employee.Validate("Immediate Supervisor", '');
                                    Employee.Modify();
                                until Employee.Next() = 0;
                        end;
                end;
                if not Found then
                    "Supervisor No." := '';
            end;

        }
        field(4; "Notice Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Caption = 'Notice Period';
        }
        field(5; "Probation Notice Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Caption = 'Probation  Termination Period';
        }
        field(6; "Salary Scale"; Code[20])
        {
            TableRelation = "Salary Scale"."Salary Scale";
            Caption = 'Job Group';
        }
        field(7; "Is Supervisor"; Boolean)
        {
            Caption = 'Is Supervisor';
            trigger OnValidate()
            begin
                if "Is Supervisor" then begin
                    Employee.Reset();
                    Employee.SetRange("Job Title2", Code);
                    if Employee.FindFirst() then begin
                        Employee."Is Supervisor" := true;
                        Employee.Modify();
                    end;
                end else begin
                    Employee.Reset();
                    Employee.SetRange("Job Title2", Code);
                    if Employee.FindSet() then begin
                        Employee.ModifyAll("Is Supervisor", false);
                    end;
                end;
            end;
        }
        field(8; "Supervisor No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            Caption = 'Supervisor No.';
            Editable = false;
        }
        field(9; "Supervisor Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Full Name" where("No." = field("Supervisor No.")));
            Editable = false;
            Caption = 'Supervisor Name';
        }
        field(10; "Is HOD"; Boolean)
        {
            Caption = 'Is HOD';
            trigger OnValidate()
            begin
                if "Is HOD" then begin
                    Employee.Reset();
                    Employee.SetRange("Job Title2", Code);
                    if Employee.FindFirst() then begin
                        "HOD No." := Employee."No.";
                        Employee."Is HOD" := true;
                        Employee.Modify();
                    end else
                        "HOD No." := '';
                end else begin
                    "HOD No." := '';
                    Employee.Reset();
                    Employee.SetRange("Job Title2", Code);
                    if Employee.FindSet() then begin
                        Employee.ModifyAll("Is HOD", false);
                    end;
                end;
            end;
        }
        field(11; "HOD No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            Caption = 'HOD No.';
            Editable = false;
        }
        field(12; "HOD Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Full Name" where("No." = field("HOD No.")));
            Editable = false;
            Caption = 'HOD Name';
        }
        field(13; "Is Regional Head"; Boolean)
        {
            Caption = 'Is Regional Office Coordinator';
            trigger OnValidate()
            begin
                if "Is Regional Head" then begin
                    Employee.Reset();
                    Employee.SetRange("Job Title2", Code);
                    if Employee.FindFirst() then begin
                        "Regional Head No." := Employee."No.";
                        repeat
                            Employee."Is Regional Head" := true;
                            Employee.Modify();
                        until Employee.Next() = 0;
                    end else
                        "Regional Head No." := '';
                end else begin
                    "Regional Head No." := '';
                    Employee.Reset();
                    Employee.SetRange("Job Title2", Code);
                    if Employee.FindSet() then begin
                        Employee.ModifyAll("Is Regional Head", false);
                    end;
                end;
            end;
        }
        field(14; "Regional Head No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            Caption = 'Regional Head No.';
            Editable = false;
        }
        field(15; "Regional Head Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Full Name" where("No." = field("Regional Head No.")));
            Editable = false;
            Caption = 'Regional Head Name';
        }
        field(16; "Employee Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Job Title2" = field(Code), "Employee Status" = const(Active)));
        }
        field(17; "Is Director"; Boolean)
        {
            Caption = 'Is Director';
            trigger OnValidate()
            begin
                if "Is Director" then begin
                    Employee.Reset();
                    Employee.SetRange("Job Title2", Code);
                    if Employee.FindFirst() then begin
                        "Director No." := Employee."No.";
                        Employee."Is Director" := true;
                        Employee.Modify();
                    end else
                        "Director No." := '';
                end else begin
                    "Director No." := '';
                    Employee.Reset();
                    Employee.SetRange("Job Title2", Code);
                    if Employee.FindSet() then begin
                        Employee.ModifyAll("Is Director", false);
                    end;
                end;
            end;
        }
        field(18; "Director No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            Caption = 'Director No.';
            Editable = false;
        }
        field(19; "Director Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Full Name" where("No." = field("Director No.")));
            Editable = false;
            Caption = 'Director Name';
        }
        field(20; "Is Regional HOD"; Boolean)
        {
            Caption = 'Is Regional HOD';
            trigger OnValidate()
            begin
                if "Is Regional HOD" then begin
                    Employee.Reset();
                    Employee.SetRange("Job Title2", Code);
                    if Employee.FindFirst() then begin
                        "Regional HOD No." := Employee."No.";
                        Employee."Is Regional HOD" := true;
                        Employee.Modify();
                    end else
                        "Regional HOD No." := '';
                end else begin
                    "Regional HOD No." := '';
                    Employee.Reset();
                    Employee.SetRange("Job Title2", Code);
                    if Employee.FindSet() then begin
                        Employee.ModifyAll("Is Regional HOD", false);
                    end;
                end;
            end;
        }
        field(21; "Regional HOD No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            Caption = 'Regional HOD No.';
            Editable = false;
        }
        field(22; "Regional HOD Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Full Name" where("No." = field("Regional HOD No.")));
            Editable = false;
            Caption = 'Regional HOD Name';
        }
        field(23; "Is CEO"; Boolean)
        {
            Caption = 'Is CEO';
            trigger OnValidate()
            begin
                if "Is CEO" then begin
                    Employee.Reset();
                    Employee.SetRange("Job Title2", Code);
                    if Employee.FindFirst() then begin
                        "CEO No." := Employee."No.";
                        Employee."Is CEO" := true;
                        Employee.Modify();
                    end else
                        "CEO No." := '';
                end else begin
                    "CEO No." := '';
                    Employee.Reset();
                    Employee.SetRange("Job Title2", Code);
                    if Employee.FindSet() then begin
                        Employee.ModifyAll("Is CEO", false);
                    end;
                end;
            end;
        }
        field(24; "CEO No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            Caption = 'CEO No.';
            Editable = false;
        }
        field(25; "CEO Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Full Name" where("No." = field("CEO No.")));
            Editable = false;
            Caption = 'CEO Name';
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
    var
        Employee: Record Employee;
}