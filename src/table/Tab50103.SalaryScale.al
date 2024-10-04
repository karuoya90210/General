table 50103 "Salary Scale"
{
    DrillDownPageID = "Salary Scale";
    LookupPageID = "Salary Scale";

    fields
    {
        field(1; "Salary Scale"; Code[20])
        {
            Caption = 'Salary Scale';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Minimum Amount"; Decimal)
        {
            Caption = 'Minimum Amount';
        }
        field(4; "Maximum Amount"; Decimal)
        {
            Caption = 'Maximum Amount';
        }
        field(5; "Priority"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Priority';
        }
        field(6; "No. Of Emloyees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee where("Salary Scale" = field("Salary Scale")));
            Caption = 'No. Of Emloyees';
        }
        field(7; "Loan Threshold"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Loan Threshold';
        }
    }

    keys
    {
        key(Key1; "Salary Scale")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

