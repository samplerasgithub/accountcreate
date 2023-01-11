@isTest
public class OpportunityTriggerHandlerTest {
    @isTest
    public static void beforeInsertOpportunityTest()
    {
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        
        User usr = new User(LastName = 'Test',
                            FirstName='Kritika',
                            Alias = 'demo',
                            Email = 'kritika.sharma@theblueflamelabs.com',
                            Username = 'abc@theblueflamelabs.com',
                            ProfileId = profileId.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US'
                           );
        insert usr;
        Account acc=new Account(Name='TestAccount1',OwnerId=usr.Id);
        insert acc;
        List<Opportunity> oppList = new  List<Opportunity>();
        for(Integer i =1;i<5;i++)
        {
            Opportunity opp= new Opportunity();
            opp.Name='Test dummy'+i;
            opp.StageName='Prosepcting';
            opp.CloseDate=date.newInstance(2022, 8, 9);
            opp.AccountId= acc.Id;
            oppList.add(opp);
        }
        
        insert oppList;
        
        test.startTest(); 
        OpportunityTriggerHandler.beforeInsertOpportunity(oppList);
        System.assertEquals(1, Limits.getEmailInvocations(), 'Emails should be sent');
        test.stoptest();
        
    }
    
    
    @isTest
    public static void updateStageTest2()
    {
        //List<Opportunity> newList,Map<Id,Opportunity> oldMap
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        
        User usr = new User(LastName = 'Test',
                            FirstName='Kritika',
                            Alias = 'demo',
                            Email = 'kritika.sharma@theblueflamelabs.com',
                            Username = 'abc@theblueflamelabs.com',
                            ProfileId = profileId.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US'
                           );
        insert usr;
        Account acc=new Account(Name='TestAccountdemo',OwnerId=usr.Id);
        insert acc;
        List<Opportunity> oppList = new  List<Opportunity>();
        for(Integer i =1;i<=5;i++)
        {
            Opportunity opp= new Opportunity();
            opp.Name='Testing dummy'+i;
            opp.StageName='Prospecting';
            opp.CloseDate=date.newInstance(2022, 8, 9);
            opp.AccountId= acc.Id;
            oppList.add(opp);
        }
        insert oppList;
        
        
        Map<Id,Opportunity> oldMap = new Map<Id,Opportunity>();
        for(Opportunity opp:oppList)
        {
            oldMap.put(opp.Id,opp);
            
        }
        List<Opportunity> oppnewList = new  List<Opportunity>(oppList);
        
        
        
        test.startTest();
        oppnewList[0].StageName='Needs Analysis';
        update oppnewList;         
        OpportunityTriggerHandler.updateStage(oppnewList,oldMap);
        System.assertEquals(0, Limits.getEmailInvocations(), 'Emails should not be sent');        
        test.stoptest();
        
    }
    @isTest
    public static void updateStageTest1()
    {
        //List<Opportunity> newList,Map<Id,Opportunity> oldMap
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        
        User usr = new User(LastName = 'Test',
                            FirstName='Kritika',
                            Alias = 'demo',
                            Email = 'kritika.sharma@theblueflamelabs.com',
                            Username = 'abc@theblueflamelabs.com',
                            ProfileId = profileId.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US'
                           );
        insert usr;
        Account acc=new Account(Name='TestAccountdemo',OwnerId=usr.Id);
        insert acc;
        List<Opportunity> oppList = new  List<Opportunity>();
        for(Integer i =1;i<=5;i++)
        {
            Opportunity opp= new Opportunity();
            opp.Name='Testing dummy data'+i;
            opp.StageName='Needs Analysis';
            opp.CloseDate=date.newInstance(2022, 8, 9);
            opp.AccountId= acc.Id;
            oppList.add(opp);
        }
        insert oppList;
        
        
        Map<Id,Opportunity> oldMap = new Map<Id,Opportunity>();
        for(Opportunity opp:oppList)
        {
            oldMap.put(opp.Id,opp);
            
        }
        List<Opportunity> oppnewList = new  List<Opportunity>(oppList);
        
        test.startTest();
        oppnewList[0].StageName='Closed Won';
        update oppnewList;
        OpportunityTriggerHandler.updateStage(oppnewList,oldMap);
        System.assertEquals(1, Limits.getEmailInvocations(), 'emails should be sent');
        
        test.stoptest();
        
    } 
}