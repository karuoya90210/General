codeunit 50100 "General Management"
{
    procedure GetFullName(FirstName: text; OtherName: Text; LastName: text): Text
    var
        FullName: Text;
    begin
        FullName := FirstName;
        if OtherName <> '' then begin
            if FullName <> '' then
                FullName += ' ' + OtherName
            else
                FullName := OtherName;
        end;
        if LastName <> '' then begin
            if FullName <> '' then
                FullName += ' ' + LastName
            else
                FullName := LastName;
        end;
        exit(FullName);
    end;

    procedure CheckUserSetup(UserName: Code[50])
    var
        UserSetup: Record "User Setup";
        Text001: Label 'User %1 is not added to the User Setup.';
    begin
        if not UserSetup.Get(UserName) then
            Error(Text001, UserName);
    end;

    procedure GetUserName(UserID: code[50]) UserName: Text[100]
    var
        Employee: Record Employee;
        User: Record User;
    begin
        UserName := '';
        Employee.Reset;
        Employee.SetRange(Employee."User ID", UserID);
        if Employee.Find('-') then
            UserName := Employee.FullName()
        else begin
            User.Reset();
            User.SetRange("User Name", UserID);
            if User.FindFirst() then UserName := User."Full Name";
        end;
    end;

    procedure GetEmployeeNo(UserID: code[50]) EmployeeNo: Code[20]
    var
        Employee: Record Employee;
        User: Record User;
    begin
        EmployeeNo := '';
        Employee.Reset;
        Employee.SetRange(Employee."User ID", UserID);
        Employee.SetRange("Employee Status", Employee."Employee Status"::Active);
        if Employee.Find('-') then
            EmployeeNo := Employee."No.";
    end;

    procedure GetUserName(UserGuid: Guid): Code[50]
    var
        User: Record User;
    begin
        if User.Get(UserGuid) then
            exit(User."User Name");
    end;

    procedure GetEmployeeSalaryScale(EmployeeNo: code[20]): Code[20]
    var
        Employee: Record Employee;
    begin
        if Employee.Get(EmployeeNo) then
            exit(Employee."Salary Scale");
    end;

    procedure GetEmployeeHOD(EmployeeNo: code[20]): Code[20]
    var
        Employee, EmployeeHOD : Record Employee;
    begin
        if Employee.Get(EmployeeNo) then begin
            EmployeeHOD.Reset();
            EmployeeHOD.SetRange("Is HOD", true);
            EmployeeHOD.SetRange("Global Dimension 1 Code", Employee."Global Dimension 1 Code");
            if EmployeeHOD.FindFirst() then
                exit(EmployeeHOD."No.");
        end;
    end;

    procedure CheckValidEmailAddress(EmailAddress: Text) Valid: Boolean
    var
        IsHandled: Boolean;
    begin
        if EmailAddress = '' then
            exit(false);

        EmailAddress := DelChr(EmailAddress, '<>');

        if EmailAddress.StartsWith('@') or EmailAddress.EndsWith('@') then
            exit(false);

        if EmailAddress.Contains(' ') then
            exit(false);

        if EmailAddress.Split('@').Count() <> 2 then
            exit(false);

        exit(true);
    end;


    //Date Validations
    procedure CheckFutureDate(DateEntered: Date)
    var
        DateErr: Label 'Date cannot be in the future';
    begin
        if DateEntered > Today then
            Error(DateErr);
    end;

    procedure CheckValidDate(StartDate: Date; EndDate: Date; StartCaption: Text[100]; EndCaption: Text[100])
    var
        DateErr: Label '%1 (%2) cannot be earlier than %3 (%4)';
    begin
        if (StartDate <> 0D) and (EndDate <> 0D) then
            if StartDate > EndDate then
                Error(DateErr, EndCaption, Format(EndDate), StartCaption, Format(StartDate));
    end;

    procedure CheckValidDate(StartDate: Date; EndDate: Date): Boolean
    var
        DateErr: Label '%1 (%2) cannot be earlier than %3 (%4)';
    begin
        if (StartDate <> 0D) and (EndDate <> 0D) then
            if StartDate <= EndDate then
                exit(true);
    end;

    procedure ValidatePhoneNo(PhoneNo: Text[30]; PhoneCaption: Text[50])
    var
        i: Integer;
        PlusFound: Boolean;
        PhoneNoLen: Integer;
        PhoneNoErr: Label '%1 cannot contain %2';
        PhoneLenErr: Label 'Invalid %1';
    begin
        if PhoneNo = '' then
            exit;
        PhoneNoLen := StrLen(PhoneNo);
        for i := 1 to PhoneNoLen do begin
            if PhoneNo[i] <> '+' then begin
                if not (PhoneNo[i] in ['0' .. '9']) then
                    Error(PhoneNoErr, PhoneCaption, PhoneNo[i]);
            end else
                PlusFound := true;
        end;

        if PlusFound then begin
            if PhoneNoLen <> 13 then
                Error(PhoneLenErr, PhoneCaption);
        end else
            if PhoneNoLen <> 10 then
                Error(PhoneLenErr, PhoneCaption);
    end;

    procedure ValidateIDNo(IDNo: Text[30]; IDCaption: Text[50])
    var
        i: Integer;
        IDNoLen: Integer;
        IDNoErr: Label '%1 cannot contain %2';
        IDLenErr: Label 'Invalid %1';
    begin
        if IDNo = '' then
            exit;
        IDNoLen := StrLen(IDNo);
        for i := 1 to IDNoLen do begin
            if not (IDNo[i] in ['0' .. '9']) then
                Error(IDNoErr, IDCaption, IDNo[i]);
        end;
    end;

    procedure GetDateFormulaText("DateFormula": DateFormula) DurationText: Text[50]
    var
    begin
        DurationText := Format("DateFormula");
        if DurationText.Contains('Y') then
            DurationText := DurationText.Replace('Y', ' Years');
        if DurationText.Contains('Q') then
            DurationText := DurationText.Replace('Q', ' Quarters');
        if DurationText.Contains('M') then
            DurationText := DurationText.Replace('M', ' Months');
        if DurationText.Contains('W') then
            DurationText := DurationText.Replace('W', ' Weeks');
        if DurationText.Contains('D') then
            DurationText := DurationText.Replace('D', ' Days');
    end;

    [EventSubscriber(ObjectType::Table, Database::Employee, 'OnBeforeGetFullName', '', false, false)]
    local procedure OnBeforeGetFullName(Employee: Record Employee; var NewFullName: Text[100]; var Handled: Boolean)
    begin
        Handled := true;
        NewFullName := GetFullName(Employee."First Name", Employee."Middle Name", Employee."Last Name")
    end;

    [EventSubscriber(ObjectType::Page, Page::"G/L Budget Names", 'OnAfterValidateEvent', 'Budget Start Date', true, true)]
    local procedure ExtractYearFromBudgetDatesBracketsBeforeValidateEvent(var Rec: Record "G/L Budget Name")
    var
        CurrentYear: Codeunit ReturnTheYear;
    begin
        if Rec."Budget Start Date" <> 0D then begin
            Rec.Year := CurrentYear.GetTheCurrentYear(Rec.Name);
            Rec.Modify();
        end;
    end;
}
