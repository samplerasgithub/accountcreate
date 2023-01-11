@isTest
public class ContactExposeTest {
    
  @isTest
    public static void loginTest(){
        System.Test.setMock(WebServiceMock.class,new ContactExposeMock());
        ContactExposeCallout obj = new ContactExposeCallout();
        PartnerSoapSforceCom.LoginResult lr=obj.loginIntoNewOrg('rasika.jadhav@gmail.com', 'Bfl@12345GR8Y3BlMYI7FGhtvbuh36yC4');
        System.assertEquals(lr.userId, NULL);
           
    }
    
    @isTest
    public static void exposeContactDetailsTest(){
        System.Test.setMock(WebServiceMock.class,new ContactExposeMock());
        ContactExposeCallout conObj =  new ContactExposeCallout();
        String conId = conobj.creationOfContactInNewOrg('sessionId', '0035g00000cRbHMAA0');
        System.assertNotEquals(conId, NULL);
    }
}