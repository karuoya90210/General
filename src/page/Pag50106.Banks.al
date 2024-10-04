page 50106 Banks
{
    //ApplicationArea = Basic;
    ApplicationArea = Payroll;
    PageType = List;
    SourceTable = Bank;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(BankCode; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BankName; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Modified At"; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified At';
                    Editable = false;
                }
                field("Last Modified By"; GeneralMgt.GetUserName(Rec.SystemModifiedBy))
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified By';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Branches)
            {
                ApplicationArea = Basic;
                Image = BankAccount;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Bank Branches";
                RunPageLink = "Bank Code" = field("Bank Code");
            }
            action(Import)
            {
                ApplicationArea = Basic;
                Caption = 'Import';
                Promoted = true;
                PromotedCategory = Category4;
                //RunObject = XMLport UnknownXMLport50076;
            }
        }
    }
    var
        GeneralMgt: Codeunit "General Management";
}
