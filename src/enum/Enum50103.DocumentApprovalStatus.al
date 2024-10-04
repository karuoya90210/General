enum 50103 "Document Approval Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Open) { Caption = 'Open'; }
    value(1; "Pending Approval") { Caption = 'Pending Approval'; }
    value(2; Approved) { Caption = 'Approved'; }
    value(3; "Pending Award") { Caption = 'Pending Award'; }
    value(4; "Canceled") { Caption = 'Canceled'; }
    value(5; "Rejected") { Caption = 'Rejected'; }
}