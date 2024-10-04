tableextension 50117 "General Ledger Setup" extends "General Ledger Setup"
{
    fields
    {
        //Begin Budget
        field(50081; "Current Budget"; Code[20])
        {
            Caption = 'Current Budget';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
        }
        field(50082; "Budget Start Date"; Date)
        {
            Caption = 'Budget Start Date';
            DataClassification = ToBeClassified;
        }
        field(50083; "Budget End Date"; Date)
        {
            Caption = 'Budget End Date';
            DataClassification = ToBeClassified;
        }
        field(50084; "Check Yearly Budget"; Boolean)
        {
            Caption = 'Check Yearly Budget';
            DataClassification = ToBeClassified;
        }
        /* field(50100; "Check Budget Period"; Boolean)
        {
            Caption = 'Check Budget Period';
            DataClassification = ToBeClassified;
        }
        field(50085; "Check Budget Dimension"; Boolean)
        {
            Caption = 'Check Budget Dimension';
            DataClassification = ToBeClassified;
        } */
        //End Budget
        field(50086; "Enforce Workflow"; Boolean)
        {
            Caption = 'Enforce Workflow';
            DataClassification = ToBeClassified;
        }

         field(50091; "Check Budget Dimension"; Enum "Check Budget Dimension")
        {
            Caption = 'Check Budget Dimension';
            DataClassification = ToBeClassified;
        }
        field(50092; "Check Budget Period"; Enum "Check Budget Period")
        {
            DataClassification = ToBeClassified;
            Caption = 'Check Budget Period';
        }
    }
}
