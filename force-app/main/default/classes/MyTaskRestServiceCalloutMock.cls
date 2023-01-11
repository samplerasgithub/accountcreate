@isTest
global class MyTaskRestServiceCalloutMock implements HttpCalloutMock {
global HTTPResponse respond(HTTPRequest req) {

       HTTPResponse res = new HTTPResponse();
       if(req.getEndpoint().equals('https://login.salesforce.com/services/oauth2/token')&& req.getMethod().equals('POST')){
           res.setHeader('Content-Type', 'application/json');
           res.setBody('{"access_token":"SESSION_ID_REMOVED","instance_url":"https://blueflamelabs38-dev-ed.develop.my.salesforce.com","id":"https://login.salesforce.com/id/00D5g00000HLqYaEAL/0055g00000F8d6OAAR","token_type":"Bearer","issued_at":"1664351613283","signature":"L0dD2FmUtpj0C4ucF/0Ic2N9mzSl/fgFC/xSikci4I0="}');
           res.setStatusCode(200);  
       }
       else if(req.getEndpoint().contains('https://ap24.salesforce.com/services/apexrest/Task/')&& req.getMethod().equals('GET')){
           res.setHeader('Content-Type', 'application/json');
           //res.setBody('');
           res.setStatusCode(200);      
       }
       return res;
   }

}