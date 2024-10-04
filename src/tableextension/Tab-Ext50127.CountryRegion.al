tableextension 50127 "Country/Region" extends "Country/Region"
{
    fields
    {
        field(52167423; "Local"; Boolean)
        {
            Caption = 'Local';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Country: Record "Country/Region";
                CountryErr: Label '%1 can only be set for one country.';
            begin
                if "Local" then begin
                    Country.Reset();
                    Country.SetRange(Local, true);
                    Country.SetFilter(Code, '<>%1', Code);
                    if Country.FindFirst() then
                        Error(CountryErr, FieldCaption("Local"));
                end;
            end;

        }
    }
}
