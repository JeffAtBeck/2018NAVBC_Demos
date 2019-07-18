pageextension 50100 MyCustomerCardExtension extends "Customer Card"
{
    layout
    {
        modify(Name)
        {
            trigger OnAfterValidate()
            begin
                if Name.EndsWith('.com') or Name.EndsWith('.dk') or name.EndsWith('.net') then begin
                    if Confirm('Do you want to collect information about the company associated with ' + Name) then begin
                        //Message('should do a look up here');
                        LookupAddressInfo();
                    end;
                end;
            end;
        }
    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

    local procedure LookupAddressInfo()
    var
        Client: HttpClient;
        Content: HttpContent;
        ResponseMessage: HttpResponseMessage;
        Result: Text;
    begin
        Message('Local Lookup Proceedure called!!')
    end;

}