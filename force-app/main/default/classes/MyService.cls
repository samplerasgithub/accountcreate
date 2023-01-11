@RestResource(urlMapping='/myservice')
global class MyService {
    @HttpPost
    global static void doPost () {
        try
        {
            RestRequest request = RestContext.request;
            RestResponse response = RestContext.response;
            String hashedval = request.headers.get('X-Hub-Signature-256');
            System.debug('hashedval'+hashedval);
            Blob bB= request.requestBody;
            System.debug(bB.toString());
            System.debug('Secret value matched and souce can be trusted');
            JSONParser parser =JSON.createParser(request.requestBody.toString());
            pusher ps;
            head_commit hc;
            String repo;
            while(parser.nextToken()!=NULL)
            {
                if(parser.getText()=='pusher')
                {
                    System.debug('Inside Pusher');
                    parser.nextToken();
                    ps=(pusher)parser.readValueAs(pusher.class);
                    System.debug(ps);
                }
                if(parser.getText()=='head_commit')
                {
                    System.debug('Inside head_commit');
                    parser.nextToken();
                    hc=(head_commit)parser.readValueAs(head_commit.class);
                    System.debug(hc);
                }
                if(parser.getText()=='full_name')
                {
                    System.debug('Inside full_name');
                    parser.nextToken();
                    repo=parser.getText();
                    System.debug(repo);
                }
            }
            Account acc= new Account();
            acc.Name=ps!=null?ps.name:'';
            acc.Site=hc!=null?hc.url:'';
            acc.AccountNumber=repo;
            insert acc;
            response.statusCode=200;
            
            response.responseBody=Blob.valueOf(JSON.serialize(new SFDCResponse('Success','processed successfully')));
        }
        catch(Exception e)
        {
            System.debug('Exception handle'+e.getMessage());
        }
        
        
    }
    public class SFDCResponse
    {
        string response;
        string message;
        public SFDCResponse(String resp,String msg)
        {
            response=resp;
            message=msg;
        }
    }
    public class pusher
    {
        public string name;
        public pusher(String name)
        {
            name=name;
        }
    }
    public class head_commit
    {
        public string url;
        public head_commit(String url)
        {
            url=url;
        }
    }
}