Codeunit 50108 ReturnTheYear
{
    procedure GetTheCurrentYear(Budget_Name: Code[10]) CurrentYear: Text
    var
        BudgetName: Record "G/L Budget Name";
        PrevYrEndDate, CurrYrStartDate, CurrYrEndDate : Date;
        PrevYrStartDate: Date;
        PrevYrStartDate1: Date;
        PrevYearStart: Integer;
        PrevYearEnd: Integer;
        CurrYearStart: Integer;
        CurrYearEnd: Integer;
        CurrYr: Text;
        PrevYr: Text;
    begin
        if BudgetName.Get(Budget_Name) then begin
            //BudgetName.Reset();
            CurrYrStartDate := BudgetName."Budget Start Date";
            CurrYrEndDate := BudgetName."Budget End Date";
            //Message('CurrYrEndDate %1', CurrYrEndDate);

            IF CurrYrStartDate <> 0D THEN BEGIN
                PrevYrEndDate := CalcDate('<-1D>', CurrYrStartDate);
                PrevYrStartDate := CalcDate('<-1Y>', PrevYrEndDate);
                PrevYrStartDate1 := CalcDate('<+1D>', PrevYrStartDate);

                //kk with the rest of the code...
                PrevYearStart := DATE2DMY(PrevYrStartDate1, 3);
                PrevYearEnd := DATE2DMY(PrevYrEndDate, 3);
                CurrYearStart := DATE2DMY(CurrYrStartDate, 3);
                CurrYearEnd := DATE2DMY(CurrYrEndDate, 3);
                PrevYr := FORMAT(PrevYearStart) + '/' + FORMAT(PrevYearEnd);
                CurrYr := FORMAT(CurrYearStart) + '/' + FORMAT(CurrYearEnd);
                //Message('%1 and %2', PrevYr, CurrYr);
                CurrentYear := CurrYr;
            End
        end;
    end;

}