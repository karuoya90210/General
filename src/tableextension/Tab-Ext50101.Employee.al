tableextension 50101 "Employee" extends Employee
{
    fields
    {
        modify("First Name")
        {
            trigger OnAfterValidate()
            begin
                Validate("Last Name");
            end;
        }
        modify("Middle Name")
        {
            trigger OnAfterValidate()
            begin
                Validate("Last Name");
            end;
        }
        modify("Last Name")
        {
            trigger OnAfterValidate()
            begin
                "Full Name" := GeneralMgt.GetFullName("First Name", "Middle Name", "Last Name");
            end;
        }
        modify("Social Security No.")
        {
            Caption = 'NSSF No.';
            trigger OnBeforeValidate()
            begin
                ValidateTextFieldValue("Social Security No.", FieldNo("Social Security No."));
            end;
        }
        modify("Phone No.")
        {
            Caption = 'Office Phone No.';
            trigger OnBeforeValidate()
            begin
                GeneralMgt.ValidatePhoneNo("Phone No.", FieldCaption("Phone No."));
                ValidateTextFieldValue("Phone No.", FieldNo("Phone No."));
            end;
        }
        modify("Mobile Phone No.")
        {
            trigger OnBeforeValidate()
            begin
                GeneralMgt.ValidatePhoneNo("Mobile Phone No.", FieldCaption("Mobile Phone No."));
                ValidateTextFieldValue("Mobile Phone No.", FieldNo("Mobile Phone No."));
            end;
        }
        modify("E-Mail")
        {
            trigger OnBeforeValidate()
            begin
                ValidateTextFieldValue("E-Mail", CurrFieldNo);
            end;
        }
        modify("Company E-Mail")
        {
            trigger OnBeforeValidate()
            begin
                ValidateTextFieldValue("Company E-Mail", CurrFieldNo);
            end;
        }
        /* modify("Global Dimension 2 Code")
        {
            trigger OnAfterValidate()
            var
                DimensionValue: Record "Dimension Value";
                DimensionMgt: Codeunit DimensionManagement;
                ShortcutDimCode: array[8] of Code[20];
            begin
                DimensionMgt.GetGLSetup(ShortcutDimCode);
                if DimensionValue.Get(ShortcutDimCode[2], "Global Dimension 2 Code") then
                    Directorate := DimensionValue.Directorate
                else
                    Directorate := '';

                CalcFields("Directorate Name")
            end;
        } */
        modify(Address)
        {
            Caption = 'Postal Address';
        }
        modify("Bank Account No.")
        {
            trigger OnBeforeValidate()
            begin
                if ("Bank Code" <> '') and ("Bank Branch Code" <> '') and ("Bank Account No." <> '') then
                    ValidateFieldValue("Bank Account No.", FieldNo("Bank Account No."));
            end;
        }
        field(52167423; "Full Name"; Text[100])
        {
            Editable = false;
            Caption = 'Full Name';
        }
        field(52167424; "ID Number"; Code[20])
        {
            Caption = 'ID Number';
            trigger OnValidate()
            begin
                GeneralMgt.ValidateIDNo("ID Number", FieldCaption("ID Number"));
                ValidateFieldValue("ID Number", FieldNo("ID Number"));
            end;
        }
        field(52167425; "Passport Number"; Code[20])
        {
            Caption = 'Passport Number';
            trigger OnValidate()
            begin
                ValidateFieldValue("Passport Number", CurrFieldNo);
            end;
        }
        field(52167426; "PIN Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PIN Number';
            trigger OnValidate()
            begin
                ValidateFieldValue("PIN Number", FieldNo("PIN Number"));
            end;
        }
        field(52167427; "NHIF Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'NHIF Number';
            trigger OnValidate()
            begin
                ValidateFieldValue("NHIF Number", FieldNo("NHIF Number"));
            end;
        }
        field(52167428; "Employee Type"; Enum "Employee Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Employee Type';
        }
        field(52167429; "Employee Status"; Enum "Employment Status")
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Employee Status';
        }
        field(52167430; "Marital Status"; Enum "Marital Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Marital Status';
        }
        field(52167431; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            Caption = 'Customer No.';
            trigger OnValidate()
            begin
                ValidateFieldValue("Customer No.", FieldNo("Customer No."));
            end;
        }
        field(52167432; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID';
            trigger OnValidate()
            begin
                ValidateFieldValue("User ID", FieldNo("User ID"));
            end;
        }
        field(52167433; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
            Caption = 'Responsibility Center';
        }
        field(52167434; "Supervisor Code"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Caption = 'Supervisor Code';
            trigger OnValidate()
            begin
                "Supervisor Name" := GeneralMgt.GetUserName("Supervisor Code");
            end;
        }
        field(52167435; "Supervisor Name"; Text[50])
        {
            Editable = false;
            Caption = 'Supervisor Name';
        }
        field(52167436; "Immediate Supervisor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where("Employee Status" = const(Active));
            Caption = 'Functional Supervisor';
            trigger OnValidate()
            var
                EmpRec: Record Employee;
            begin
                if EmpRec.get("Immediate Supervisor") then
                    "Immediate Supervisor name" := EmpRec.FullName()
                else
                    "Immediate Supervisor name" := '';
            end;
        }
        field(52167437; "Immediate Supervisor name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Functional Supervisor Name';
        }
        field(52167438; Manager; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where("Is HOD" = const(true), "Employee Status" = const(Active));
            Caption = 'Manager';
            trigger OnValidate()
            var
                EmplRec: Record Employee;
            begin
                if EmplRec.Get(Manager) then
                    "Manager Name" := EmplRec.FullName()
                else
                    "Manager Name" := '';
            end;
        }
        field(52167439; "Manager Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Manager Name';
        }
        field(52167440; "Admnistrative Supervisor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where("Employee Status" = const(Active));
            Caption = 'Administrative Supervisor';
            trigger OnValidate()
            var
                EmplRec: Record Employee;
            begin
                if EmplRec.Get("Admnistrative Supervisor") then
                    "Admin Supervisor Name" := EmplRec.FullName()
                else
                    "Admin Supervisor Name" := '';
            end;
        }
        field(52167441; "Admin Supervisor Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Administrator Supervisor Name';
        }
        field(52167442; "Alt. Phone No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Alternative Phone No.';
        }
        field(52167443; "ID Serial No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'ID Serial No.';
            trigger OnValidate()
            begin
                ValidateFieldValue("ID Serial No.", CurrFieldNo);
            end;
        }
        field(52167444; "Place Of Birth"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Place Of Birth';
        }
        field(52167445; District; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'District';
        }
        field(52167446; "Place of Issue"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Place of Issue';
        }
        field(52167447; "Date of Issue"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of Issue';
        }
        field(52167448; Division; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Division';
        }
        field(52167449; Location; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Location';
        }
        field(52167450; "Sub-Location"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sub-Location';
        }
        field(52167451; "Physical Address"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Physical Address';
        }
        field(52167452; Estate; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Estate';
        }
        field(52167453; "Residential Area"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Residential Area';
        }
        field(52167454; "House No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'House No.';
        }
        field(52167455; Country; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
            Caption = 'Country';
        }
        field(52167456; "Visa Terms"; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Visa Terms';
        }
        field(52167457; "Visa Expiry"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Visa Expiry';
        }
        field(52167458; "Work Permit No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Work Permit No.';
            trigger OnValidate()
            begin
                ValidateFieldValue("Work Permit No.", CurrFieldNo);
            end;
        }
        field(52167459; "Work Permit Expiry"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Work Permit Expiry';
        }
        field(52167460; "Other Immigration Notes"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Immigration Notes';
        }
        field(52167461; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(52167462; Signature; Media)
        {
            Caption = 'Signature';
            ExtendedDatatype = Person;
        }
        field(52167463; "Approval Status"; Enum "Document Approval Status")
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Approval Status';
        }
        field(52167464; "Salary Scale"; Code[20])
        {
            TableRelation = "Salary Scale"."Salary Scale";
            Caption = 'Job Grade';
        }
        field(52167465; "Salary Pointer"; Code[20])
        {
            Caption = 'Salary Spread';
            TableRelation = "Salary Pointer"."Salary Pointer" where("Salary Scale" = field("Salary Scale"));
        }
       /*  field(52167466; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
            Caption = 'Currency Code';
        } */
        field(52167467; "Is Supervisor"; Boolean)
        {
            Caption = 'Is Supervisor';
            Editable = false;
        }
        field(52167468; "Is HOD"; Boolean)
        {
            Caption = 'Is HOD';
            Editable = false;
        }
        field(52167469; "Is Regional Head"; Boolean)
        {
            Caption = 'Is Regional Office Coordinator';
            Editable = false;
        }
        /* field(52167470; "Directorate"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Directorate;
            Editable = false;
            Caption = 'Directorate';
        }
        field(52167471; "Directorate Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Directorate.Name where(Code = field(Directorate)));
            Editable = false;
            Caption = 'Directorate Name';
        } */
        field(52167472; "Job Title2"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Title";
            Caption = 'Job Title';
            trigger OnValidate()
            var
                JobTitles: Record "Job Title";
            begin
                "Job Description" := '';
                PopulateJobDetails(Rec);
            end;
        }
        field(52167473; "Job Description"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Job Description';
        }
        field(52167474; "Is Director"; Boolean)
        {
            Caption = 'Is Director';
            Editable = false;
        }
        field(52167475; "Imprest Posting Group1"; Code[20])
        {
            Caption = 'Imprest Posting Group';
            DataClassification = ToBeClassified;
        }
        field(52167476; "Is Regional HOD"; Boolean)
        {
            Caption = 'Is Regional HOD';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        /* field(52167477; "Headquarter"; Boolean)
        {
            Caption = 'Headquarter';
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Headquarter where(Code = field("Global Dimension 1 Code")));
            Editable = false;
        } */
        field(52167478; "Bank Code"; Code[20])
        {
            TableRelation = "Bank"."Bank Code";
            Caption = 'Bank Code';
            trigger OnValidate()
            var
                Banks: Record Bank;
            begin
                "Bank Name" := '';
                "Bank Branch Code" := '';
                "Bank Branch Name" := '';

                if Banks.Get("Bank Code") then begin
                    "Bank Name" := Banks."Bank Name";
                    Validate("Bank Account No.");
                end;
            end;
        }
        field(52167479; "Bank Name"; Text[100])
        {
            Editable = false;
            Caption = 'Bank Name';
        }
        field(52167480; "Bank Branch Code"; Code[20])
        {
            TableRelation = "Bank Branch"."Branch Code" where("Bank Code" = field("Bank Code"));
            Caption = 'Bank Branch Code';
            trigger OnValidate()
            var
                BankBranch: Record "Bank Branch";
            begin
                if BankBranch.Get("Bank Code", "Bank Branch Code") then begin
                    "Bank Branch Name" := BankBranch."Branch Name";
                    Validate("Bank Account No.");
                end;
            end;
        }
        field(52167481; "Bank Branch Name"; Text[100])
        {
            Editable = false;
            Caption = 'Bank Branch Name';
        }
        field(52167482; "Is CEO"; Boolean)
        {
            Caption = 'Is CEO';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(52167483; "NITA No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'NITA No.';
            trigger OnValidate()
            begin
                ValidateFieldValue("NITA No.", FieldNo("NITA No."));
            end;
        }
    }
    var
        GeneralMgt: Codeunit "General Management";

    trigger OnBeforeInsert()
    var
    begin
        if Rec."Job Title2" <> '' then
            PopulateJobDetails(Rec);
        if ("First Name" <> '') or ("Last Name" <> '') then
            Validate("Last Name");
    end;

    local procedure PopulateJobDetails(var Employee: Record Employee)
    var
        EmployeeRec, EmpCopy : Record Employee;
        JobTitle, JobTitleCopy : Record "Job Title";
        EmpCount: Integer;
        JobTitleErr: Label '%1 %2 cannot be assigned to multiple employees.';
    begin
        if JobTitle.Get(Employee."Job Title2") then begin
            EmployeeRec.Reset();
            EmployeeRec.SetFilter("No.", '<>%1', Employee."No.");
            EmployeeRec.SetRange("Job Title2", Employee."Job Title2");
            EmployeeRec.SetRange("Employee Status", EmployeeRec."Employee Status"::Active);
            EmpCount := EmployeeRec.Count;

            if (JobTitle."Is Supervisor" or JobTitle."Is HOD" or JobTitle."Is Director" or (JobTitle."Is CEO")) then begin
                EmployeeRec.Reset();
                EmployeeRec.SetFilter("No.", '<>%1', Employee."No.");
                EmployeeRec.SetRange("Job Title2", Employee."Job Title2");
                EmployeeRec.SetRange("Employee Status", EmployeeRec."Employee Status"::Active);
                if EmployeeRec.FindFirst() then
                    Error(JobTitleErr, Employee.FieldCaption("Job Title2"), Employee."Job Title2");
            end;

            if (JobTitle."Is Regional Head") or (JobTitle."Is Regional HOD") then begin
                EmployeeRec.Reset();
                EmployeeRec.SetFilter("No.", '<>%1', Employee."No.");
                EmployeeRec.SetRange("Job Title2", Employee."Job Title2");
                EmployeeRec.SetRange("Global Dimension 1 Code", Employee."Global Dimension 1 Code");
                EmployeeRec.SetRange("Employee Status", EmployeeRec."Employee Status"::Active);
                if EmployeeRec.FindFirst() then
                    Error(JobTitleErr, Employee.FieldCaption("Job Title2"), Employee."Job Title2");
            end;

            Employee."Is HOD" := JobTitle."Is HOD";
            Employee."Is Supervisor" := JobTitle."Is Supervisor";
            Employee."Is Director" := JobTitle."Is Director";
            Employee."Is Regional Head" := JobTitle."Is Regional Head";
            Employee."Is Regional HOD" := JobTitle."Is Regional HOD";
            Employee."Is CEO" := JobTitle."Is CEO";
            Employee."Job Description" := JobTitle.Description;
            Employee."Salary Scale" := JobTitle."Salary Scale";
            Employee.Manager := GetManager(Employee);

            Employee.Validate("Immediate Supervisor", JobTitle."Supervisor No.");

            if Employee."Is Supervisor" and (EmpCount = 0) then begin
                JobTitleCopy.Reset();
                JobTitleCopy.SetRange("Reports to", JobTitle.Code);
                if JobTitleCopy.FindSet() then
                    repeat
                        EmployeeRec.Reset();
                        EmployeeRec.SetRange("Job Title2", JobTitleCopy.Code);
                        EmployeeRec.SetRange("Employee Status", EmployeeRec."Employee Status"::Active);
                        if EmployeeRec.FindSet() then
                            repeat
                                EmployeeRec.Validate("Immediate Supervisor", Employee."No.");
                                EmployeeRec.Modify();
                            until EmployeeRec.Next() = 0;
                    until JobTitleCopy.Next() = 0;
            end;

            if JobTitle."Is HOD" then
                JobTitle."HOD No." := Employee."No.";
            if JobTitle."Is Supervisor" then
                JobTitle."Supervisor No." := Employee."No.";
            if JobTitle."Is Regional Head" then
                JobTitle."Regional Head No." := Employee."No.";
            if JobTitle."Is Regional HOD" then
                JobTitle."Regional HOD No." := Employee."No.";

            JobTitle.Modify();
        end else begin
            Validate("Immediate Supervisor", '');
            EmployeeRec.Reset();
            EmployeeRec.SetRange("Job Title2", xRec."Job Title2");
            EmployeeRec.SetRange("Employee Status", EmployeeRec."Employee Status"::Active);
            if EmployeeRec.FindFirst() then
                if (EmployeeRec.Count = 1) then begin
                    JobTitle.Reset();
                    JobTitle.SetRange("Reports to", xRec."Job Title2");
                    if JobTitle.FindSet() then
                        repeat
                            EmpCopy.Reset();
                            EmpCopy.SetRange("Job Title2", JobTitle.Code);
                            EmpCopy.SetRange("Employee Status", EmpCopy."Employee Status"::Active);
                            if EmpCopy.FindSet() then
                                repeat
                                    EmpCopy.Validate("Immediate Supervisor", '');
                                    EmpCopy.Modify();
                                until EmpCopy.Next() = 0;
                        until JobTitle.Next() = 0;
                end;
        end;

    end;

    procedure GetManager(Employee: Record Employee): Code[20]
    var
        EmployeeRec: Record Employee;
    begin
        EmployeeRec.Reset();
        EmployeeRec.SetRange("Is HOD", true);
        EmployeeRec.SetRange("Global Dimension 1 Code", Employee."Global Dimension 1 Code");
        EmployeeRec.SetRange("Global Dimension 2 Code", Employee."Global Dimension 2 Code");
        if EmployeeRec.FindFirst() then
            exit(EmployeeRec."No.")
        else
            exit('');
    end;

    procedure ValidateFieldValue(FieldValue: Code[50]; FieldNo: Integer)
    var
        Employee: Record Employee;
        Text001: Label 'Employee %1 has already been assigned %2 as %3.';
        FilterLbl: Label 'WHERE(%1=CONST(%2),%3 =FILTER(<>%4),%5=FILTER(%6|%7))';
        RecRef: RecordRef;
        FieldRef: FieldRef;
        ViewFilter: Text;
        Duplicate: Boolean;
    begin
        Duplicate := false;
        case FieldNo of
            Employee.FieldNo("Bank Account No."):
                begin
                    Employee.Reset();
                    Employee.SetFilter("No.", '<>%1', "No.");
                    Employee.SetRange("Bank Code", "Bank Code");
                    Employee.SetRange("Bank Branch Code", "Bank Branch Code");
                    Employee.SetRange("Bank Account No.", FieldValue);
                    if Employee.FindFirst() then
                        Duplicate := true;
                end;
            else begin
                if RecRef.Get(Rec.RecordId) then begin
                    FieldRef := RecRef.Field(FieldNo);
                    if FieldValue <> '' then begin
                        ViewFilter := StrSubstNo(FilterLbl, FieldRef.Name, FieldValue, FieldName("No."), "No.", FieldName("Employee Status"), Employee."Employee Status"::Active, Employee."Employee Status"::New);
                        Employee.Reset();
                        Employee.SetView(ViewFilter);
                        if Employee.FindFirst() then
                            Duplicate := true;
                    end;
                end;
            end;
        end;
        if Duplicate then
            Error(Text001, Employee."No.", FieldRef.Caption, FieldValue);
    end;

    procedure ValidateTextFieldValue(FieldValue: Text[80]; FieldNo: Integer)
    var
        Employee: Record Employee;
        Text001: Label 'Employee %1 has already been assigned %2 as %3.';
        FilterLbl: Label 'WHERE(%1=CONST(%2),%3 =FILTER(<>%4),%5=FILTER(%6|%7))';
        RecRef: RecordRef;
        FieldRef: FieldRef;
        ViewFilter: Text;
    begin
        if RecRef.Get(Rec.RecordId) then begin
            FieldRef := RecRef.Field(FieldNo);
            if FieldValue <> '' then begin
                ViewFilter := StrSubstNo(FilterLbl, FieldRef.Name, FieldValue, FieldName("No."), "No.", FieldName("Employee Status"), Employee."Employee Status"::Active, Employee."Employee Status"::New);
                Employee.Reset();
                Employee.SetView(ViewFilter);
                if Employee.FindFirst() then
                    Error(Text001, Employee."No.", FieldRef.Caption, FieldValue);
            end;
        end;
    end;

    procedure CheckCEOReport(Employee: Record Employee): Boolean
    var
        EmployeeRec: Record Employee;
        JobTitle: Record "Job Title";
    begin
        if EmployeeRec.Get(Employee."Immediate Supervisor") then
            if JobTitle.Get(EmployeeRec."Job Title2") then
                if JobTitle."Is CEO" then
                    exit(true);
    end;
}