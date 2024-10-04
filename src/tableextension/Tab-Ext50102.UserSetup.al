tableextension 50102 "User Setup" extends "User Setup"
{
    fields
    {
        field(52167423; "Allow Payroll"; Boolean)
        {
            Caption = 'Allow Payroll';
        }
        field(52167424; "Create Consolidation Plan"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Create Consolidation Plan';
        }
        field(52167425; "Activate Contract"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Activate Contract';
        }
        field(52167426; "Renew Contract"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Renew Contract';
        }
        field(52167427; "Close Contract"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Close Contract';
        }
        field(52167428; "Can Reverse"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Can Reverse';
        }
        field(52167429; "Allow Budget Edit"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Allow Budget Edit';
        }
        field(52167430; "Close RFQ"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Close RFQ';
        }
        field(52167431; "HR Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'HR Notification';
        }
        field(52167432; "Job Position"; Enum "Job Position")
        {
            DataClassification = ToBeClassified;
            Caption = 'Job Position';
        }
        field(52167433; "Tranfer Items"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52167434; "Purchase Order Roles"; Option)
        {
            Description = 'Restrict the permission to receive and invoice purchase order';
            OptionMembers = " ",Receive,Invoice,"Receive and Invoice";
        }
        field(52167435; "Show All"; Boolean)
        {
        }
        field(52167436; "Can Edit All Pages"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52167437; "Notify Requestor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52167438; "HR User"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52167439; "Finance User"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52167440; "Department Champion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52167441; "Clerk"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52167442; "Transport Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50201; "Procurement Officer"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Procurement Officer';
        }
        field(50000; "Inventory Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Inventory Notification';
        }
        field(50001; "Fixed Asset Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fixed Asset Notification';
        }

        field(52167444; AllowProcEditOnVendorCard; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52167445; AllowFinEditOnVendorCard; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52167446; Department; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation ="Dimension Value";
        }
    }
    procedure GetUserFullName(UserId: Code[40]): Text
    var
        Users: Record User;        
    begin
        Users.Reset();
        Users.SetRange("User Name", UserId);
        if Users.FindFirst() then
            exit(Users."Full Name");
    end;
}
