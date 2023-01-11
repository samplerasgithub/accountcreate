public class MyTaskRestServiceCallout {
 private final String clientId ='3MVG9fe4g9fhX0E5P2M6XFLDzpXuwhlkFmrylxuHCTt2u9i_0sc4JJw1yNO0c2nqcMzF.iFNynSEp16cewtNm';
    private final String clientsecret ='F3A38218D8BAB4F78AD6A743ED8992A859EBED260DF79A26EA7BC18F03BFF600';
    private final String username ='rasika.jadhav@gmail.com';
    private final String password ='Bfl@12345GR8Y3BlMYI7FGhtvbuh36yC4';
   
    public String returnAccessToken()
    {
        String reqBody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientsecret+'&username='+username+'&password='+password;
        HttpRequest req= new HttpRequest();
      	req.setMethod('POST');
        req.setBody(reqBody);
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        Http httpobj = new Http();
		HttpResponse res = httpobj.send(req); 
        System.debug(res.getBody());
        System.debug(res.getstatusCode());
        LoginResponse lr = (LoginResponse)JSON.deserialize(res.getBody(), LoginResponse.class);
        return lr.access_token;
        
    }
    public class LoginResponse
    {
        public String access_token; 
		 
		public String id;
    }
    public  httpResponse MyTaskRestService(String accesstoken)
    {
        String endpoint ='https://ap24.salesforce.com/services/apexrest/Task/';
       	HttpRequest req = new HttpRequest();
    	req.setEndpoint(endpoint);
        req.setHeader('Authorization', 'Bearer '+accesstoken);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept', 'application/json');
        req.setMethod('GET');
        req.setBody('{"Subject": "Call","Status": "Completed","Priority": "Normal"}');
        Http httpObj = new Http();
        return httpObj.send(req);
   
        
    }
}