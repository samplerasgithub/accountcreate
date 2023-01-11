@isTest
global class CreateAccountRecordusingSOAPMock implements WebServiceMock {
  
    global void doInvoke(
        Object stub,
        Object request,
        Map<String,Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType
        
    )
    {
        if(request instanceOf PartnerSoapSforceCom.login_element)
        {
        PartnerSoapSforceCom.loginResponse_element responseelement = new PartnerSoapSforceCom.loginResponse_element();
        responseelement.result = new PartnerSoapSforceCom.LoginResult();
       response.put('response_x',responseelement);
        }
        else if(request instanceOf SoapSforceComSchemasClassMysoapwebs.createAccount_element)
        {
            SoapSforceComSchemasClassMysoapwebs.createAccountResponse_element resp = new SoapSforceComSchemasClassMysoapwebs.createAccountResponse_element();
            resp.result= '0015i00000Nyv19AAB';
            response.put('response_x',resp);
        }
        
    }
      
    

}