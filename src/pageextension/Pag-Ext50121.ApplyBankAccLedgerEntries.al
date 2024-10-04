pageextension 50121 ApplyBankAccLedgerEntries extends "Apply Bank Acc. Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("Reference Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                Visible = true;
                Caption = 'Reference No.';
                ToolTip = 'Specifies the value of the Reference No field.';
            }
        }
    }
}
