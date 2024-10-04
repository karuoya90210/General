table 50104 "Salary Pointer"
{
    DrillDownPageID = "Salary Pointer";
    LookupPageID = "Salary Pointer";

    fields
    {
        field(1; "Salary Scale"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Salary Scale"."Salary Scale";
            Caption = 'Salary Scale';
        }
        field(2; "Salary Pointer"; Code[20])
        {
            NotBlank = true;
            Caption = 'Salary Pointer';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Priority"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Priority';
        }
        field(5; "No. Of Emloyees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Salary Scale" = field("Salary Scale"), "Salary Pointer" = field("Salary Pointer")));
            Caption = 'No. Of Emloyees';
        }
        // field(6; "Annual Leave Days"; Decimal)
        // {
        //     Caption = 'Entitled Annual Leave Days';
        // }
        // field(7; "Monthly Leave Days"; Decimal)
        // {
        //     Caption = 'Entitled Monthly Leave Days';
        //     DataClassification = ToBeClassified;
        // }
    }

    keys
    {
        key(Key1; "Salary Scale", "Salary Pointer")
        {
            Clustered = true;
        }
        key(Key2; Priority)
        {

        }
    }

    fieldgroups
    {
    }
}

