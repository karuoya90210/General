/* tableextension 50116 "ItemExt" extends Item
{
    fields
    {
        //Begin Budget
        field(50081; "G/L Budget Account"; Code[20])
        {
            Caption = 'Budget Account';
            DataClassification = ToBeClassified;
            TableRelation = "Item Budget A/C".Code;
            NotBlank = true;
        }
        //End Budget

        //Begin Finance 
        field(50000; "Vendor Category"; Code[20])
        {
            Caption = 'Vendor Category';
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Category";
        }
        field(50001; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Expiry Date';
        }
        field(50002; "Insurance Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Insurance Date';
        }
        //End Finance
        modify(Description)
        {
            trigger OnBeforeValidate()
            var
                Items: Record Item;
            begin
                Items.Reset();
                Items.SetCurrentKey(Description);
                Items.SetFilter(Description, '@' + Description);
                if Items.FindFirst() then begin
                    Error('An item %1 with the description %2 is already defined', Items."No.", Items.Description);
                end;
            end;
        }
    }
    keys
    {
        key(KeyExt; Description)
        {
        }
    }
} */