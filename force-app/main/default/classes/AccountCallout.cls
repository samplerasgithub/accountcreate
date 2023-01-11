public class AccountCallout {
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
    public  httpResponse getContacts(String accesstoken,String accountId)
    {
        String endpoint ='https://ap24.salesforce.com/services/apexrest/v1/GetContacts/'+accountId;
       	HttpRequest req = new HttpRequest();
    	req.setEndpoint(endpoint);
        req.setHeader('Authorization', 'Bearer '+accesstoken);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept', 'application/json');
        req.setMethod('GET');
        Http httpObj = new Http();
        return httpObj.send(req);
   
        
    }
    public static list<Contact> parseContacts(String contactJSON){
           
       list<Contact> contactList = new List<Contact>();

       JSONParser parser = JSON.createParser(contactJSON);
       set<Contact> contSet = new set<Contact>();
       Contact contactObj;
       
       while (parser.nextToken() != null) {
           
           if((parser.getCurrentToken() == JSONToken.FIELD_NAME) ){
               System.debug('Current token text '+parser.getText());
               //Id
               if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Id')) {
                   // Get the value.
                   parser.nextToken();
                   
                   string sId= parser.getText();
                   contactObj = new Contact();
                   contactObj.Id = sId;
                   system.debug('Id ' + sId);
                   
                   parser.nextToken();
                   if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                       (parser.getText() == 'Name')) {
                           // Get the value.
                           parser.nextToken();
                           
                           string sName = parser.getText();
                           contactObj.LastName = sName;
                           system.debug('Name ' + sName );
                       }
                   
                   //Phone
                   parser.nextToken();
                   if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                       (parser.getText() == 'Phone')) {
                           // Get the value.
                           parser.nextToken();
                           string phone = parser.getText();
                           contactObj.Phone = phone;
                           system.debug('Phone ' + phone);
                       }
                   
                   //Fax
                   parser.nextToken();
                   if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                       (parser.getText() == 'Fax')) {
                           // Get the value.
                           parser.nextToken();
                           string fax = parser.getText();
                           contactObj.Fax = fax;
                           system.debug('Fax ' + fax);
                       }
                   
                   //Email
                   parser.nextToken();
                   if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                       (parser.getText() == 'Email')) {
                           // Get the value.
                           parser.nextToken();
                           string sEmail = parser.getText();
                           contactObj.Email = sEmail;
                           system.debug('Email ' + sEmail);
                       }
                       
                       
                   }
                   contSet.add(contactObj); 
               }
               contSet.remove(null);
           }
           contactList.addAll(contSet);
           system.debug('Contact List '+Json.serialize(contactList));
           return contactList;
       }

}