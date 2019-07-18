pageextension 50100 MyCustomerCardExtension extends "Customer Card"
{
    layout
    {
        modify(Name)
        {
            trigger OnAfterValidate()
            var
                LookUpConfirm: TextConst ENU = 'Do you want to collect information about the company associated with %1?';
            begin
                if Name.EndsWith('.com') or Name.EndsWith('.dk') or name.EndsWith('.net') then begin
                    if Confirm(StrSubstNo(LookUpConfirm, Name)) then begin
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
        TCDomain: TextConst ENU = '{"domain"}:"%1"';
        DisplayText: Text;
    begin
        DisplayText := 'Local Lookup Proceedure - sending Domain Details:\' + StrSubstNo(TCDomain, Name);
        Message(DisplayText);

        Content.WriteFrom('{"domain"}:"' + Name + '"');
        Client.DefaultRequestHeaders().Add('Authorization', 'Bearer Y7NyypvOOliotov4jsDMu9dtUZ0bF0Nq');
        Client.Post('https://api.fullcontact.com/v3/company.enrich', Content, ResponseMessage);
        if not ResponseMessage.IsSuccessStatusCode then
            Error('Error connecting to Web Services');

        ResponseMessage.Content().ReadAs(Result);
    end;

}