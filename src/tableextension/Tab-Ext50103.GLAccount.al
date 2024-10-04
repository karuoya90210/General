tableextension 50103 "G/L Account" extends "G/L Account"
{
    fields
    {
        //Begin Budget
        field(50081; Budgeted; Boolean)
        {
            Caption = 'Budgeted';
            DataClassification = ToBeClassified;
        }
        field(50082; "Disbursed Budget"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                              "G/L Account No." = FIELD(FILTER(Totaling)),
                                                              "Business Unit Code" = FIELD("Business Unit Filter"),
                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                              Date = FIELD("Date Filter"),
                                                              "Budget Name" = FIELD("Budget Filter"),
                                                              "Budget Dimension 1 Code" = FIELD("Shortcut Dimension 3 Filter"),
                                                              "Budget Dimension 2 Code" = FIELD("Shortcut Dimension 4 Filter"),
                                                              "Budget Dimension 3 Code" = FIELD("Shortcut Dimension 3 Filter"),
                                                              "Budget Dimension 4 Code" = FIELD("Shortcut Dimension 6 Filter"),
                                                              "Dimension Set ID" = FIELD("Dimension Set ID Filter")));
            Editable = false;
            Caption = 'Disbursed Budget';
        }
        field(50083; "Approved Budget"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                              "G/L Account No." = FIELD(FILTER(Totaling)),
                                                              "Business Unit Code" = FIELD("Business Unit Filter"),
                                                              Date = FIELD("Date Filter"),
                                                              "Budget Name" = FIELD("Budget Filter"),
                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                              "Budget Dimension 1 Code" = FIELD("Shortcut Dimension 3 Filter"),
                                                              "Budget Dimension 2 Code" = FIELD("Shortcut Dimension 4 Filter"),
                                                              "Budget Dimension 3 Code" = FIELD("Shortcut Dimension 5 Filter"),
                                                              "Budget Dimension 4 Code" = FIELD("Shortcut Dimension 6 Filter"),
                                                              "Dimension Set ID" = FIELD("Dimension Set ID Filter")));
            Editable = false;
            Caption = 'Approved Budget';
        }
        field(50084; Commitment; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE("G/L Account No." = FIELD("No."),
                                                                            "Commitment Date" = FIELD("Date Filter"),
                                                                            "Global Dimension 1" = FIELD("Global Dimension 1 Filter"),
                                                                            "Global Dimension 2" = FIELD("Global Dimension 2 Filter"),
                                                                            "G/L Account No." = FIELD(FILTER(Totaling)),
                                                                            "Commitment Type" = FILTER(Commitment | "Commitment Reversal"),
                                                                            "Dimension Set ID" = FIELD("Dimension Set ID Filter"),
                                                                            "Budget Code" = FIELD("Budget Filter")));
            Editable = false;
            Caption = 'Commitment';
        }
        field(50085; Encumberance; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE("G/L Account No." = FIELD("No."),
                                                                            "Commitment Date" = FIELD("Date Filter"),
                                                                            "Global Dimension 1" = FIELD("Global Dimension 1 Filter"),
                                                                            "Global Dimension 2" = FIELD("Global Dimension 2 Filter"),
                                                                            "G/L Account No." = FIELD(FILTER(Totaling)),
                                                                            "Commitment Type" = FILTER(Encumberance | "Encumberance Reversal"),
                                                                            "Dimension Set ID" = FIELD("Dimension Set ID Filter"),
                                                                            "Budget Code" = FIELD("Budget Filter")));
            Editable = false;
            Caption = 'Encumberance';
        }
        field(50086; "Shortcut Dimension 3 Filter"; Code[20])
        {
            TableRelation = "Dimension Value" where("Global Dimension No." = const(3));
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Filter';
        }
        field(50087; "Shortcut Dimension 4 Filter"; Code[20])
        {
            TableRelation = "Dimension Value" where("Global Dimension No." = const(4));
            CaptionClass = '1,3,2';
            Caption = 'Shortcut Dimension 4 Filter';
        }

        field(50088; "Shortcut Dimension 5 Filter"; Code[20])
        {
            TableRelation = "Dimension Value" where("Global Dimension No." = const(5));
            CaptionClass = '1,3,2';
            Caption = 'Shortcut Dimension 5 Filter';
        }
        field(50089; "Shortcut Dimension 6 Filter"; Code[20])
        {
            TableRelation = "Dimension Value" where("Global Dimension No." = const(6));
            CaptionClass = '1,3,2';
            Caption = 'Shortcut Dimension 6 Filter';
        }
        field(50091; "Check Budget Dimension"; Enum "Check Budget Dimension")
        {
            DataClassification = ToBeClassified;
            Caption = 'Check Budget Dimension';
        }
        field(50092; "Check Budget Period"; Enum "Check Budget Period")
        {
            DataClassification = ToBeClassified;
            Caption = 'Check Budget Period';
        }
        //End Budget
    }
}



