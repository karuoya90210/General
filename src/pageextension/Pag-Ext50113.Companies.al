pageextension 50113 Companies extends Companies
{
    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Name = 'KCDF LIVE' then
            Error('You cannot delete KCDF LIVE');
    end;
}
