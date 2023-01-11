@isTest
global class AccountCalloutMock implements HttpCalloutMock {
   global HTTPResponse respond(HTTPRequest req) {

       HTTPResponse res = new HTTPResponse();
       if(req.getEndpoint().equals('https://login.salesforce.com/services/oauth2/token')&& req.getMethod().equals('POST')){
           res.setHeader('Content-Type', 'application/json');
           res.setBody('{"access_token":"SESSION_ID_REMOVED","instance_url":"https://blueflamelabs41-dev-ed.my.salesforce.com","id":"https://login.salesforce.com/id/00D5g000004F9IKEA0/0055g000003pml8AAA","token_type":"Bearer","issued_at":"1617681905840","signature":"FQCf4k3f9KTk+djWCImi3q8u3UZPsQFD2A/Shw3Cty8="}');
           res.setStatusCode(200);  
       }
       else if(req.getEndpoint().contains('https://ap24.salesforce.com/services/apexrest/v1/GetContacts/')&& req.getMethod().equals('GET')){
           res.setHeader('Content-Type', 'application/json');
           res.setBody('[ {"attributes" : {"type" : "Contact","url" : "/services/data/v51.0/sobjects/Contact/0035g00000356yXAAQ"},"Id" : "0035g00000356yXAAQ","Name" : "Jack Rogers","Phone" : "(336) 222-7000","Fax" : "(336) 222-8000","Email" : "jrogers@burlington.com", {  "attributes" : {"type" : "Contact","url" : "/services/data/v51.0/sobjects/Contact/0035g000003IcdRAAS"},"Id" : "0035g000003IcdRAAS","Name" : "Tim Kelly","Phone" : "1234566789","Email" : "tim.kelly@gmail.com"} ]');
           res.setStatusCode(200);      
       }
       return res;
   }
}