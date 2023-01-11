@isTest
global class ContactExposeMock implements WebServiceMock{
    
    global void doInvoke(Object stub, Object request, Map<String,Object> response, String endPoint, String soapAction, String requestName,
                         String responseNs, String responseName, String responseType){
                             
                             if(request instanceOf PartnerSoapSforceCom.login_element){
                                  PartnerSoapSforceCom.loginResponse_element logines = new PartnerSoapSforceCom.loginResponse_element();
                                logines.result=new PartnerSoapSforceCom.LoginResult ();
                                response.put('response_x',logines);
                             }
                             else if(request instanceOf SoapSforceComSchemasClassExposecont.conList_element ){
                                   SoapSforceComSchemasClassExposecont.conListResponse_element  resp =new SoapSforceComSchemasClassExposecont.conListResponse_element ();
                                   resp.result= '0035g00000cRfTNAA0';
                                 response.put('response_x',resp);
                             }
                         
                         }
  
}