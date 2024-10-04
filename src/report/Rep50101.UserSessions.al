report 50101 "User Sessions"
{
    ApplicationArea = All;
    Caption = 'User Sessions';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/Rep52167424.UserSessions.rdl';
    dataset
    {
        dataitem(UserSession; "User Session")
        {
            RequestFilterFields = "User ID";
            column(UserID; "User ID")
            {
            }
            column(LoginDate; "Login Date")
            {
            }
            column(LoginTime; "Login Time")
            {
            }
            column(LogoutDate; "Logout Date")
            {
            }
            column(LogoutTime; "Logout Time")
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoAddress2; CompInfo."Address 2")
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            trigger OnPreDataItem()
            begin
                if FromDate <> 0D then begin
                    if ToDate <> 0D then begin
                        UserSession.SetRange("Login Date", FromDate, ToDate);
                    end else
                        UserSession.SetFilter("Login Date", '%1..', FromDate);
                end else
                    if ToDate <> 0D then
                        UserSession.SetFilter("Login Date", '..%1', ToDate);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(FromDate; FromDate)
                {
                    Caption = 'From Date';
                    ApplicationArea = All;
                }
                field(ToDate; ToDate)
                {
                    Caption = 'To Date';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        FromDate, ToDate : date;
}
