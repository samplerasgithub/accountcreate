@isTest
public class CreateAccountUsingSoapTest {
    @isTest
    public static void loginAccount()
    {
        Test.setMock(WebServiceMock.class, new CreateAccountRecordusingSOAPMock());
        CreateAccountRecordusingSOAP accobj = new CreateAccountRecordusingSOAP();
        PartnerSoapSforceCom.LoginResult lr =accobj.loginIntoNewOrg('rasika.jadhav@gmail.com','Bfl@12345');
        System.assertEquals(lr.userId, NULL);
        
    }
 @isTest
    public static void createAcc()
    {
         Test.setMock(WebServiceMock.class, new CreateAccountRecordusingSOAPMock());
        CreateAccountRecordusingSOAP accobj = new CreateAccountRecordusingSOAP();
        Id accId = accobj.createAccountInNewOrg('123er', 'Demo Four');
        System.assertNotEquals(accId, Null);
    }
}