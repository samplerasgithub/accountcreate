@isTest
public class AccounTriggerHandlerTest {
    @isTest
    //insert and update scenario for System Administrator profile
    public static void InsertAndUpdateTest1()
    {
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
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
        system.runAs(usr)
        {
            List<Account> accList = new  List<Account>();
            Map<Id,Account> oldMap = new Map<Id,Account>();
            for(Integer i =1;i<=3;i++)
            {
                Account accobj= new Account();
                accobj.Name='Test'+i;
                accobj.Notes__c='Hi';
                accList.add(accobj);
            }
            List<Account> accnewList = new  List<Account>();
            test.startTest();
            insert accList;
            for(Account accrec:accList)
            {
                oldMap.put(accrec.Id,accrec);
            }
            accnewList.addAll(accList);
            String newNote=accList[0].Notes__c+ ' '+'Bye';
            accnewList[0].Notes__c=newNote;
            update accnewList;  
            AccounTriggerHandler.ChangeNotesColor(accList);  
            AccounTriggerHandler.UpdateOwner(accnewList, oldMap);
            Test.stopTest();
            for(Account acc:accList)
            {
                System.assertEquals('<div style="color:blue;">'+ acc.Notes__c.stripHtmlTags() +'</div>', acc.Notes__c);
            }
            for(Account accob:accnewList)
            {
                System.assertEquals('<div style="color:blue;">'+ accob.Notes__c.stripHtmlTags() +'</div>', accob.Notes__c);
            }
        }
        
    }
    @isTest
    //insert and update scenario for standard user profile
    public static void InsertAndUpdateTest2()
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
        system.runAs(usr)
        {
            List<Account> accList = new  List<Account>();
            Map<Id,Account> oldMap = new Map<Id,Account>();
            for(Integer i =1;i<=3;i++)
            {
                Account accobj= new Account();
                accobj.Name='Test'+i;
                accobj.Notes__c='Hi';
                accList.add(accobj);
            }
            List<Account> accnewList = new  List<Account>();
            test.startTest();
            insert accList;
            for(Account accrec:accList)
            {
                oldMap.put(accrec.Id,accrec);
            }
            accnewList.addAll(accList);
            String newNote=accList[0].Notes__c+ ' '+'Bye';
            accnewList[0].Notes__c=newNote;
            update accnewList;  
            AccounTriggerHandler.ChangeNotesColor(accList);  
            AccounTriggerHandler.UpdateOwner(accnewList, oldMap);
            Test.stopTest();
            for(Account acc:accList)
            {
                System.assertEquals('<div style="color:green;">'+ acc.Notes__c.stripHtmlTags() +'</div>', acc.Notes__c);
            }
            for(Account accob:accnewList)
            {
                System.assertEquals('<div style="color:green;">'+ accob.Notes__c.stripHtmlTags() +'</div>', accob.Notes__c);
            }
        }
        
    }
    
     @isTest
    //insert and update scenario for other than standard user and system Administrator
    public static void InsertAndUpdateTest3()
    {
        Profile profileId = [SELECT Id FROM Profile WHERE Name != 'Standard User' AND Name != 'System Administrator' LIMIT 1];
        
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
        system.runAs(usr)
        {
            List<Account> accList = new  List<Account>();
            Map<Id,Account> oldMap = new Map<Id,Account>();
            for(Integer i =1;i<=3;i++)
            {
                Account accobj= new Account();
                accobj.Name='Test'+i;
                accobj.Notes__c='Hi';
                accList.add(accobj);
            }
            List<Account> accnewList = new  List<Account>();
            test.startTest();
            insert accList;
            for(Account accrec:accList)
            {
                oldMap.put(accrec.Id,accrec);
            }
            accnewList.addAll(accList);
            String newNote=accList[0].Notes__c+ ' '+'Bye';
            accnewList[0].Notes__c=newNote;
            update accnewList;  
            AccounTriggerHandler.ChangeNotesColor(accList);  
            AccounTriggerHandler.UpdateOwner(accnewList, oldMap);
            Test.stopTest();
            for(Account acc:accList)
            {
                System.assertEquals('<div style="color:black;">'+ acc.Notes__c.stripHtmlTags() +'</div>', acc.Notes__c);
            }
            for(Account accob:accnewList)
            {
                System.assertEquals('<div style="color:black;">'+ accob.Notes__c.stripHtmlTags() +'</div>', accob.Notes__c);
            }
        }
    }
    
}