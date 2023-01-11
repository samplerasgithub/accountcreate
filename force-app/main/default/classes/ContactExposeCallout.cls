public class ContactExposeCallout {
public PartnerSoapSforceCom.LoginResult loginIntoNewOrg(String userName, String password){
        PartnerSoapSforceCom.Soap obj = new PartnerSoapSforceCom.Soap();
        PartnerSoapSforceCom.LoginResult lr=obj.login(userName, password);
        //PartnerSoapSforceCom.LoginResult lr=obj.login('manasi.niravane@bfl.com', 'Bfl@12345rnC6v1POAE8FM3XMy22pqfx1');
        return lr;
    }
    
    public String creationOfContactInNewOrg(String sessionId, String conId){
        SoapSforceComSchemasClassExposecont.SessionHeader_element header = new SoapSforceComSchemasClassExposecont.SessionHeader_element();
        header.sessionId=sessionId;
        SoapSforceComSchemasClassExposecont.ExposeContactDetailsSoap myService = new SoapSforceComSchemasClassExposecont.ExposeContactDetailsSoap();
        myService.SessionHeader=header;
        String conName = myService.conList(conId);
        System.debug(conName);
        return conName;
        
    }
}