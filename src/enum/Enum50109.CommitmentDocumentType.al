enum 50109 "Commitment Document Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; " ") { Caption = ' '; }
    value(1; "Payment Vouche") { Caption = 'Payment Vouche'; }
    value(2; "Purchase Order") { Caption = 'Purchase Order'; }
    value(3; "Purchase Invoice") { Caption = 'Purchase Invoice'; }
    value(4; "Purchase Requisition") { Caption = 'Purchase Requisition'; }
    value(5; Imprest) { Caption = 'Imprest'; }
}
