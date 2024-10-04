/* codeunit 50101 "Commitment Management"
{
    var
        CashMgtSetup: Record "Cash Management Setup";

    procedure IsAccountBudgeted(GLAccount: Code[20]): Boolean
    var
        GLAccountRec: Record "G/L Account";
    begin
        if GLAccountRec.Get(GLAccount) then
            if GLAccountRec.Budgeted then
                exit(true);
    end;

    local procedure GetPurchaseAccountNo(LineType: Enum "Purchase Line Type"; LineNo: Code[20]; PostingGroup: Code[20]): Code[20]
    var
        Items: Record Item;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
    begin
        case LineType of
            LineType::"G/L Account":
                exit(LineNo);
            LineType::Item:
                begin
                    Items.Get(LineNo);
                    if Items."G/L Budget Account" <> '' then
                        exit(Items."G/L Budget Account");
                end;
            LineType::"Fixed Asset":
                begin
                    if FAPostingGroup.Get(PostingGroup) then
                        if FAPostingGroup."Acquisition Cost Account" <> '' then
                            exit(FAPostingGroup."Acquisition Cost Account");
                end;
        end;
    end;

    procedure LineCommitted(var CommittmentNo: Code[20]; var No: Code[20]; var LineNo: Integer) Exists: Boolean
    var
        Committed: Record "Commitment Entries";
    begin
        Exists := false;
        Committed.Reset;
        Committed.SetRange(Committed."Commitment No.", CommittmentNo);
        Committed.SetRange(Committed."No.", No);
        Committed.SetRange(Committed."Line No.", LineNo);
        if Committed.Find('-') then
            Exists := true;
    end;

    procedure CheckCommittment(InventoryAccount: code[20]; CommittmentDate: date; LineAmount: Decimal; Dimension1Code: Code[20]; Dimension2Code: Code[20]; DimensionSetID: Integer; var BudgetCode: Code[20])
    var
        CommitmentEntries: Record "Commitment Entries";
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommitedAmount: Decimal;
        ErrorMsg: Label 'You have Exceeded Budget for G/L Account No %1 Dimension %5 By %2 Budget Available %3 Committed Amount %4';
    begin
        if IsAccountBudgeted(InventoryAccount) then begin
            GenLedSetup.Get;
            GenLedSetup.TestField("Current Budget");
            GenLedSetup.TestField("Budget Start Date");
            GenLedSetup.TestField("Budget End Date");
            if BudgetCode = '' then
                BudgetCode := GenLedSetup."Current Budget";

            GLAccount.Get(InventoryAccount);
            GLAccount.SetFilter(GLAccount."Budget Filter", BudgetCode);
            if GenLedSetup."Check Budget Dimension" then
                GLAccount.SetRange(GLAccount."Dimension Set ID Filter", DimensionSetID);
            if GenLedSetup."Check Yearly Budget" then
                GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Budget Start Date", GenLedSetup."Budget End Date")
            else
                GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Budget Start Date", CommittmentDate);
            GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", Commitment);
            BudgetAmount := GLAccount."Budgeted Amount";
            Expenses := GLAccount."Net Change";
            CommitedAmount := GLAccount.Commitment;
            BudgetAvailable := BudgetAmount - (CommitedAmount + Expenses);

            if LineAmount > BudgetAvailable then
                Error(ErrorMsg, InventoryAccount, Abs(BudgetAvailable - (CommitedAmount + LineAmount)), BudgetAvailable, CommitedAmount, Dimension1Code);
        end;
    end;

    procedure PurchaseReqCommittment(var PurchaseReq: Record "Purchase Requisition")
    var
        PurchaseReqLines: Record "Purchase Requisition Lines";
        Committments: Record "Commitment Entries";
        FixedAsset: Record "Fixed Asset";
        LineType: Enum "Purchase Line Type";
        PostingGroup: Code[20];
        InventoryAccount: Code[20];
        BudgetCode: Code[20];
        CommitmentDate: Date;
        EntryNo: Integer;
        LineError: Boolean;
        Text001: Label 'Please enter the %1';
    begin
        PurchaseReqLines.Reset;
        PurchaseReqLines.SetRange(PurchaseReqLines."Document No.", PurchaseReq."No.");
        if PurchaseReqLines.FindFirst then begin
            if PurchaseReq."Expected Delivery Date" = 0D then
                Error(Text001, PurchaseReq.FieldCaption("Expected Delivery Date"));

            CommitmentDate := PurchaseReq."Expected Delivery Date";

            Committments.LockTable();
            if Committments.FindLast then
                EntryNo := Committments."Entry No.";
            repeat
                PostingGroup := '';
                PurchaseReqLines.TestField("No.");

                case PurchaseReqLines."Line Type" of
                    PurchaseReqLines."Line Type"::"Direct Expense":
                        LineType := LineType::"G/L Account";
                    PurchaseReqLines."Line Type"::"Inventory Item":
                        LineType := LineType::Item;
                    PurchaseReqLines."Line Type"::"Fixed Asset":
                        begin
                            LineType := LineType::"Fixed Asset";
                            FixedAsset.Get(PurchaseReqLines."No.");
                            PostingGroup := FixedAsset."FA Posting Group";
                        end;

                end;
                InventoryAccount := GetPurchaseAccountNo(LineType, PurchaseReqLines."No.", PostingGroup);
                if IsAccountBudgeted(InventoryAccount) then begin
                    BudgetCode := PurchaseReq."Budget Code";
                    CheckCommittment(InventoryAccount, CommitmentDate, PurchaseReqLines.Amount, PurchaseReqLines."Global Dimension 1 Code", PurchaseReqLines."Global Dimension 2 Code", PurchaseReqLines."Dimension Set ID", BudgetCode);

                    Committments.Reset;
                    Committments.SetRange("Commitment No.", PurchaseReq."No.");
                    Committments.SetRange("No.", PurchaseReqLines."No.");
                    Committments.SetRange("Line No.", PurchaseReqLines."Line No.");
                    if not Committments.FindFirst() then begin
                        EntryNo := EntryNo + 1;
                        Committments.Init;
                        Committments."Entry No." := EntryNo;
                        Committments."Commitment No." := PurchaseReq."No.";
                        Committments."Document No." := PurchaseReq."No.";
                        Committments.Type := LineType;
                        Committments."No." := PurchaseReqLines."No.";
                        Committments."Line No." := PurchaseReqLines."Line No.";
                        Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                        Committments."Document Type" := Committments."Document Type"::"Purchase Requisition";
                        Committments.Insert;
                        PurchaseReqLines.Modify;
                    end;

                    Committments."G/L Account No." := InventoryAccount;
                    Committments."Commitment Date" := CommitmentDate;
                    Committments."Global Dimension 1" := PurchaseReqLines."Global Dimension 1 Code";
                    Committments."Global Dimension 2" := PurchaseReqLines."Global Dimension 2 Code";
                    Committments."Dimension Set ID" := PurchaseReqLines."Dimension Set ID";
                    Committments."Committed Amount" := PurchaseReqLines.Amount;
                    Committments."User ID" := UserId;
                    Committments."Account Type" := Committments."Account Type"::Vendor;
                    Committments.Description := PurchaseReqLines.Description;
                    Committments."Budget Code" := BudgetCode;
                    Committments.Modify();

                    PurchaseReqLines.Validate("Budget Account", InventoryAccount);
                    PurchaseReqLines.Modify();
                end;
            until PurchaseReqLines.Next = 0;
        end;
    end;

    procedure CancelPurchaseReqCommitments(PurchaseReq: Record "Purchase Requisition")
    var
        CommitmentEntries: Record "Commitment Entries";
    begin
        CommitmentEntries.Reset;
        CommitmentEntries.SetRange("Commitment No.", PurchaseReq."No.");
        CommitmentEntries.SetRange("Document Type", CommitmentEntries."Document Type"::"Purchase Requisition");
        CommitmentEntries.SetRange("Commitment Type", CommitmentEntries."Commitment Type"::Commitment);
        CommitmentEntries.DeleteAll;
    end;

    procedure PurchaseReqCommitmentReversal(DocumentNo: Code[20]; LineNo: Integer; OrderDate: date; EntryNo: Integer)
    var
        Commitment, CommitmentEntries : Record "Commitment Entries";
    begin
        CommitmentEntries.Reset;
        CommitmentEntries.SetRange("Document Type", CommitmentEntries."Document Type"::"Purchase Requisition");
        CommitmentEntries.SetRange("Document No.", DocumentNo);
        CommitmentEntries.SetRange("Line No.", LineNo);
        if CommitmentEntries.Find('-') then begin
            Commitment.Init;
            Commitment.Copy(CommitmentEntries);
            Commitment."Entry No." := EntryNo;
            Commitment."Commitment Type" := Commitment."Commitment Type"::"Commitment Reversal";
            Commitment."Commitment Date" := OrderDate;
            Commitment."Committed Amount" := -CommitmentEntries."Committed Amount";
            Commitment."User ID" := UserId;
            Commitment.Insert;

            CommitmentEntries."Uncommittment Date" := Today;
            CommitmentEntries.Modify();
        end;
    end;

    procedure PurchaseCommittment(var PurchHeader: Record "Purchase Header"; var ErrorMsg: Text)
    var
        PurchaseLines: Record "Purchase Line";
        Committments: Record "Commitment Entries";
        BudgetCode: Code[20];
        InventoryAccount: Code[20];
        CommitmentDate: Date;
        EntryNo: Integer;
        LineError: Boolean;
        Text001: Label 'Please enter the %1';
    begin
        PurchaseLines.Reset;
        PurchaseLines.SetRange(PurchaseLines."Document No.", PurchHeader."No.");
        PurchaseLines.SetRange(PurchaseLines."Document Type", PurchHeader."Document Type");
        if PurchaseLines.FindFirst then begin
            if PurchHeader."Order Date" = 0D then
                Error(Text001, PurchHeader.FieldCaption("Order Date"));

            CommitmentDate := PurchHeader."Order Date";

            Committments.LockTable();
            if Committments.FindLast then
                EntryNo := Committments."Entry No.";
            repeat
                InventoryAccount := GetPurchaseAccountNo(PurchaseLines.Type, PurchaseLines."No.", PurchaseLines."Posting Group");
                if IsAccountBudgeted(InventoryAccount) then begin
                    PurchaseLines.TestField("Buy-from Vendor No.");

                    //Reverse Requisition Commitment
                    if (PurchaseLines."Requisition No." <> '') and (PurchaseLines."Requisition Line No." <> 0) then begin
                        EntryNo := EntryNo + 1;
                        PurchaseReqCommitmentReversal(PurchaseLines."Requisition No.", PurchaseLines."Requisition Line No.", PurchHeader."Order Date", EntryNo);
                    end;

                    BudgetCode := PurchHeader."Budget Code";
                    CheckCommittment(InventoryAccount, CommitmentDate, PurchaseLines."Amount Including VAT", PurchaseLines."Shortcut Dimension 1 Code", PurchaseLines."Shortcut Dimension 2 Code", PurchaseLines."Dimension Set ID", BudgetCode);

                    Committments.Reset;
                    Committments.SetRange("Commitment No.", PurchHeader."No.");
                    Committments.SetRange("No.", PurchaseLines."No.");
                    Committments.SetRange("Line No.", PurchaseLines."Line No.");
                    if not Committments.FindFirst() then begin
                        EntryNo := EntryNo + 1;
                        Committments.Init;
                        Committments."Entry No." := EntryNo;
                        Committments."Commitment No." := PurchHeader."No.";
                        Committments."Document No." := PurchHeader."No.";
                        Committments.Type := PurchaseLines.Type;
                        Committments."No." := PurchaseLines."No.";
                        Committments."Line No." := PurchaseLines."Line No.";
                        Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                        case PurchHeader."Document Type" of
                            PurchHeader."Document Type"::Order:
                                Committments."Document Type" := Committments."Document Type"::"Purchase Order";
                            PurchHeader."Document Type"::Invoice:
                                Committments."Document Type" := Committments."Document Type"::"Purchase Invoice";
                        end;
                        Committments.Insert;
                        PurchaseLines.Committment := true;
                        PurchaseLines.Modify;
                    end;

                    PurchHeader.Validate("Order Date");
                    Committments."G/L Account No." := InventoryAccount;
                    Committments."Commitment Date" := CommitmentDate;
                    Committments."Global Dimension 1" := PurchaseLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2" := PurchaseLines."Shortcut Dimension 2 Code";
                    Committments."Dimension Set ID" := PurchaseLines."Dimension Set ID";
                    Committments."Committed Amount" := PurchaseLines."Amount Including VAT";
                    Committments."User ID" := UserId;
                    Committments."Account Type" := Committments."Account Type"::Vendor;
                    Committments."Account No." := PurchaseLines."Buy-from Vendor No.";
                    Committments."Account Name" := PurchHeader."Buy-from Vendor Name";
                    Committments.Description := PurchaseLines.Description;
                    Committments."Budget Code" := BudgetCode;
                    Committments.Modify();

                end;
            until PurchaseLines.Next = 0;
        end;
    end;

    procedure CancelPurchaseCommitments(PurchaseHeader: Record "Purchase Header")
    var
        CommitmentEntries: Record "Commitment Entries";
    begin
        CommitmentEntries.Reset;
        CommitmentEntries.SetRange("Commitment No.", PurchaseHeader."No.");
        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Order:
                CommitmentEntries.SetRange("Document Type", CommitmentEntries."Document Type"::"Purchase Order");
            PurchaseHeader."Document Type"::Invoice:
                CommitmentEntries.SetRange("Document Type", CommitmentEntries."Document Type"::"Purchase Invoice");
        end;
        CommitmentEntries.SetRange("Commitment Type", CommitmentEntries."Commitment Type"::Commitment);
        CommitmentEntries.DeleteAll;
    end;

    procedure PurchaseInvoiceCommitmentReversal(PurchInvHeader: Record "Purch. Inv. Header")
    var
        Commitment, CommitmentEntries : Record "Commitment Entries";
        PurchInvLine: Record "Purch. Inv. Line";
        EntryNo: Integer;
    begin
        Commitment.Reset();
        if Commitment.FindLast() then
            EntryNo := Commitment."Entry No."
        else
            EntryNo := 0;
        PurchInvLine.Reset;
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.Find('-') then
            repeat
                CommitmentEntries.Reset;
                CommitmentEntries.SetRange("Document Type", CommitmentEntries."Document Type"::"Purchase Invoice");
                CommitmentEntries.SetRange("Document No.", PurchInvHeader."No.");
                CommitmentEntries.SetRange("Line No.", PurchInvLine."Line No.");
                if CommitmentEntries.Find('-') then begin
                    EntryNo := EntryNo + 1;
                    Commitment.Init;
                    Commitment.Copy(CommitmentEntries);
                    Commitment."Entry No." := EntryNo;
                    Commitment."Commitment Type" := Commitment."Commitment Type"::"Commitment Reversal";
                    Commitment."Commitment Date" := PurchInvHeader."Posting Date";
                    Commitment."Committed Amount" := -PurchInvLine."Amount Including VAT";
                    Commitment."User ID" := UserId;
                    Commitment.Insert;

                    CommitmentEntries."Uncommittment Date" := Today;
                    CommitmentEntries.Modify();
                end;

            until PurchInvLine.Next() = 0;

    end;

    procedure PurchaseOrderCommitmentReversal(PurchInvHeader: Record "Purch. Inv. Header")
    var
        Commitment, CommitmentEntries : Record "Commitment Entries";
        PurchInvLine: Record "Purch. Inv. Line";
        EntryNo: Integer;
    begin
        Commitment.Reset();
        if Commitment.FindLast() then
            EntryNo := Commitment."Entry No."
        else
            EntryNo := 0;
        PurchInvLine.Reset;
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.Find('-') then
            repeat
                CommitmentEntries.Reset;
                CommitmentEntries.SetRange("Document Type", CommitmentEntries."Document Type"::"Purchase Order");
                CommitmentEntries.SetRange("Document No.", PurchInvHeader."Order No.");
                CommitmentEntries.SetRange("Line No.", PurchInvLine."Line No.");
                if CommitmentEntries.Find('-') then begin
                    EntryNo := EntryNo + 1;
                    Commitment.Init;
                    Commitment.Copy(CommitmentEntries);
                    Commitment."Entry No." := EntryNo;
                    Commitment."Commitment Type" := Commitment."Commitment Type"::"Commitment Reversal";
                    Commitment."Commitment Date" := PurchInvHeader."Posting Date";
                    Commitment."Committed Amount" := -PurchInvLine."Amount Including VAT";
                    Commitment."User ID" := UserId;
                    Commitment.Insert;

                    CommitmentEntries."Uncommittment Date" := Today;
                    CommitmentEntries.Modify();
                end;

            until PurchInvLine.Next() = 0;

    end;

    procedure ImprestCommittment(var Imprest: Record Payment)
    var
        ImprestLines: Record "Payment Line";
        Committments: Record "Commitment Entries";
        FixedAsset: Record "Fixed Asset";
        LineType: Enum "Purchase Line Type";
        PostingGroup: Code[20];
        InventoryAccount: Code[20];
        BudgetCode: Code[20];
        CommitmentDate: Date;
        EntryNo: Integer;
        LineError: Boolean;
        Text001: Label 'Please enter the %1';
    begin
        ImprestLines.Reset;
        ImprestLines.SetRange("No.", Imprest."No.");
        if ImprestLines.FindFirst then begin
            if Imprest."Posting Date" <> 0D then
                CommitmentDate := Imprest."Posting Date"
            else
                CommitmentDate := Imprest."Start Date";

            Committments.LockTable();
            if Committments.FindLast then
                EntryNo := Committments."Entry No.";
            repeat
                PostingGroup := '';
                ImprestLines.TestField("Account No.");

                case ImprestLines."Account Type" of
                    ImprestLines."Account Type"::"G/L Account":
                        LineType := LineType::"G/L Account";
                    ImprestLines."Account Type"::"Fixed Asset":
                        begin
                            LineType := LineType::"Fixed Asset";
                            FixedAsset.Get(ImprestLines."Account No.");
                            PostingGroup := FixedAsset."FA Posting Group";
                        end;
                end;
                InventoryAccount := GetPurchaseAccountNo(LineType, ImprestLines."Account No.", PostingGroup);
                if IsAccountBudgeted(InventoryAccount) then begin
                    BudgetCode := Imprest."Budget Code";
                    CheckCommittment(InventoryAccount, CommitmentDate, ImprestLines."Total Amount", ImprestLines."Global Dimension 1 Code", ImprestLines."Global Dimension 2 Code", ImprestLines."Dimension Set ID", BudgetCode);

                    Committments.Reset;
                    Committments.SetRange("Commitment No.", Imprest."No.");
                    Committments.SetRange("No.", ImprestLines."Account No.");
                    Committments.SetRange("Line No.", ImprestLines."Line No.");
                    if not Committments.FindFirst() then begin
                        EntryNo := EntryNo + 1;
                        Committments.Init;
                        Committments."Entry No." := EntryNo;
                        Committments."Commitment No." := Imprest."No.";
                        Committments."Document No." := Imprest."No.";
                        Committments.Type := LineType;
                        Committments."No." := ImprestLines."Account No.";
                        Committments."Line No." := ImprestLines."Line No.";
                        Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                        Committments."Document Type" := Committments."Document Type"::Imprest;
                        Committments.Insert;
                    end;

                    Committments."G/L Account No." := InventoryAccount;
                    Committments."Commitment Date" := CommitmentDate;
                    Committments."Global Dimension 1" := ImprestLines."Global Dimension 1 Code";
                    Committments."Global Dimension 2" := ImprestLines."Global Dimension 2 Code";
                    Committments."Dimension Set ID" := ImprestLines."Dimension Set ID";
                    Committments."Committed Amount" := ImprestLines."Total Amount";
                    Committments."User ID" := UserId;
                    Committments."Account Type" := Imprest."Account Type";
                    Committments.Description := ImprestLines.Description;
                    Committments."Budget Code" := BudgetCode;
                    Committments.Modify();

                    ImprestLines."Budget Account No." := InventoryAccount;
                    ImprestLines.Modify();
                end;
            until ImprestLines.Next = 0;
        end;
    end;

    procedure CancelImprestCommitments(Imprest: Record Payment)
    var
        CommitmentEntries: Record "Commitment Entries";
    begin
        CommitmentEntries.Reset;
        CommitmentEntries.SetRange("Commitment No.", Imprest."No.");
        CommitmentEntries.SetRange("Document Type", CommitmentEntries."Document Type"::Imprest);
        CommitmentEntries.SetRange("Commitment Type", CommitmentEntries."Commitment Type"::Commitment);
        CommitmentEntries.DeleteAll;
    end;

    procedure ImprestCommitmentReversal(DocumentNo: Code[20]; LineNo: Integer; ImprestDate: date; EntryNo: Integer)
    var
        Commitment, CommitmentEntries : Record "Commitment Entries";
    begin
        CommitmentEntries.Reset;
        CommitmentEntries.SetRange("Document Type", CommitmentEntries."Document Type"::Imprest);
        CommitmentEntries.SetRange("Document No.", DocumentNo);
        CommitmentEntries.SetRange("Line No.", LineNo);
        if CommitmentEntries.Find('-') then begin
            Commitment.Init;
            Commitment.Copy(CommitmentEntries);
            Commitment."Entry No." := EntryNo;
            Commitment."Commitment Type" := Commitment."Commitment Type"::"Commitment Reversal";
            Commitment."Commitment Date" := ImprestDate;
            Commitment."Committed Amount" := -CommitmentEntries."Committed Amount";
            Commitment."User ID" := UserId;
            Commitment.Insert;

            CommitmentEntries."Uncommittment Date" := Today;
            CommitmentEntries.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Post", 'OnAfterProcessPurchLines', '', false, false)]
    local procedure OnAfterProcessPurchLines(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShipmentHeader: Record "Return Shipment Header"; WhseShip: Boolean; WhseReceive: Boolean; var PurchLinesProcessed: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean)
    begin
        if PurchHeader.Invoice then begin
            PurchaseOrderCommitmentReversal(PurchInvHeader);
            PurchaseInvoiceCommitmentReversal(PurchInvHeader);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCheckPurchaseApprovalPossible', '', false, false)]
    local procedure OnAfterCheckPurchaseApprovalPossible(PurchaseHeader: Record "Purchase Header")
    var
        myInt: Integer;
    begin
        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::Order:
                begin
                    PurchaseCommittment(PurchaseHeader, ErrorMsg);
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterManualReleasePurchaseDoc', '', true, true)]
    local procedure OnAfterManualReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    begin
        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::Order:
                begin
                    PurchaseCommittment(PurchaseHeader, ErrorMsg);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelPurchaseApprovalRequest', '', false, false)]
    local procedure OnCancelPurchaseApprovalRequest(var PurchaseHeader: Record "Purchase Header")
    var
        myInt: Integer;
    begin
        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::Order:
                begin
                    CancelPurchaseCommitments(PurchaseHeader);
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterManualReopenPurchaseDoc', '', true, true)]
    local procedure OnAfterManualReopenPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    begin
        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::Order:
                begin
                    CancelPurchaseCommitments(PurchaseHeader);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeStartPosting', '', true, true)]
    local procedure OnBeforeStartPosting(var GenJournalLine: Record "Gen. Journal Line")
    begin
        if (GenJournalLine.Amount > 0) and (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account") then
            CheckCommittment(GenJournalLine."Account No.", GenJournalLine."Posting Date", GenJournalLine.Amount, GenJournalLine."Shortcut Dimension 1 Code", GenJournalLine."Shortcut Dimension 2 Code", GenJournalLine."Dimension Set ID", GenJournalLine."Budget Code")
        else
            if (GenJournalLine.Amount < 0) and (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::"G/L Account") then
                CheckCommittment(GenJournalLine."Bal. Account No.", GenJournalLine."Posting Date", -GenJournalLine.Amount, GenJournalLine."Shortcut Dimension 1 Code", GenJournalLine."Shortcut Dimension 2 Code", GenJournalLine."Dimension Set ID", GenJournalLine."Budget Code")
    end;

    //Purchase Requisition
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Custom", 'OnSendPurchaseRequisitionForApproval', '', false, false)]
    procedure RunWorkflowOnSendPurchaseRequisitionForApproval(var PurchaseRequisition: Record "Purchase Requisition")
    var
    begin
        PurchaseReqCommittment(PurchaseRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Custom", 'OnCancelPurchaseRequisitionApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequest(var PurchaseRequisition: Record "Purchase Requisition")
    var
        PurchaseRequisitionRec: Record "Purchase Requisition";
    begin
        CancelPurchaseReqCommitments(PurchaseRequisition);
    end;

    //Payment
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Custom", 'OnSendPaymentForApproval', '', false, false)]
    procedure RunWorkflowOnSendPaymentForApproval(var Payment: Record Payment)
    var
    begin
        case Payment."Payment Type" of
            Payment."Payment Type"::Imprest:
                begin
                    CashMgtSetup.Get();
                    if CashMgtSetup."Commit Imprest" then
                        ImprestCommittment(Payment);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Custom", 'OnCancelPaymentApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelPaymentApprovalRequest(var Payment: Record Payment)
    var
    begin
        case Payment."Payment Type" of
            Payment."Payment Type"::Imprest:
                begin
                    CashMgtSetup.Get();
                    if CashMgtSetup."Commit Imprest" then
                        CancelImprestCommitments(Payment);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', true, true)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseReq: Record "Purchase Requisition";
        Payment: Record Payment;
    begin
        case ApprovalEntry."Table ID" of
            database::"Purchase Header":
                begin
                    PurchaseHeader.Get(ApprovalEntry."Document Type", ApprovalEntry."Document No.");
                    case PurchaseHeader."Document Type" of
                        PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::Order:
                            begin
                                CancelPurchaseCommitments(PurchaseHeader);
                            end;
                    end;
                end;
            database::"Purchase Requisition":
                begin
                    PurchaseReq.Get(ApprovalEntry."Document No.");
                    CancelPurchaseReqCommitments(PurchaseReq);
                end;
            database::Payment:
                begin
                    Payment.Get(ApprovalEntry."Document No.");
                    case Payment."Payment Type" of
                        Payment."Payment Type"::Imprest:
                            begin
                                Payment.Get(ApprovalEntry."Document No.");
                                CashMgtSetup.Get();
                                if CashMgtSetup."Commit Imprest" then
                                    CancelImprestCommitments(Payment);
                            end;
                    end;
                end;
        end
    end;



    var
        ErrorMsg: Text;
}



 */