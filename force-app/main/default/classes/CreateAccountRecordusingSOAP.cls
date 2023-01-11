public class CreateAccountRecordusingSOAP {
    public PartnerSoapSforceCom.LoginResult loginIntoNewOrg(String userName, String password)
    {
      PartnerSoapSforceCom.Soap sforce = new PartnerSoapSforceCom.Soap();
        PartnerSoapSforceCom.LoginResult lr = sforce.login(userName,password);
	 // PartnerSoapSforceCom.LoginResult lr = sforce.login('rasika.jadhav@gmail.com','Bfl@12345GR8Y3BlMYI7FGhtvbuh36yC4');
      return lr;
    }
	public Id createAccountInNewOrg(String sessionId,String AccName)
    {
      	SoapSforceComSchemasClassMysoapwebs.SessionHeader_element header = new SoapSforceComSchemasClassMysoapwebs.SessionHeader_element();
		header.sessionId = sessionId;
		SoapSforceComSchemasClassMysoapwebs.MySOAPWebService myservice = new SoapSforceComSchemasClassMysoapwebs.MySOAPWebService();
		myservice.SessionHeader = header;
		Id myaccount = myservice.createAccount(AccName);
		System.debug('Account Id'+myaccount);
        return myaccount;
  
    }
}