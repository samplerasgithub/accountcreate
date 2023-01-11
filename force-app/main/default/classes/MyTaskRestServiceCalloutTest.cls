@isTest
public class MyTaskRestServiceCalloutTest {
    @isTest
    public static void loginTest()
        {
            Test.setMock(HttpCalloutMock.class,new MyTaskRestServiceCalloutMock());
            MyTaskRestServiceCallout obj = new MyTaskRestServiceCallout();
            String accessToken = obj.returnAccessToken();
            System.assertNotEquals(accessToken,NULL,'Successfully Login with new org');
        }
     @isTest
    public static void createTaskrecordTest()
        {
    		Test.setMock(HttpCalloutMock.class,new MyTaskRestServiceCalloutMock());
            MyTaskRestServiceCallout obj = new MyTaskRestServiceCallout();
            HttpResponse res = obj.MyTaskRestService('1234');
            System.assertEquals(200,res.getStatusCode(),'Task record created Successfully');  
        }

}