@isTest
public class EmailMessageHandlerTest {
    @isTest
    public static void SetBCCAddressTest()
    {
        List<CaseTeamMember> CaseTeamMemberList = new List<CaseTeamMember>();
        Id CaseTeamRoleId = [select Id from CaseTeamRole where name='Admin'].Id;
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User usr = new User(LastName = 'Test',
                            FirstName='Data',
                            Alias = 'demo',
                            Email = 'rasikajadhavid@gmail.com',
                            Username = 'abc@theblueflamelabs.com',
                            ProfileId = profileId.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US'
                           );
        insert usr;
        User usr2 = new User(LastName = 'Testing',
                             FirstName='Data',
                             Alias = 'demoex',
                             Email = 'rasikajadhav2109@gmail.com',
                             Username = 'rasika@theblueflamelabs.com',
                             ProfileId = profileId.id,
                             TimeZoneSidKey = 'GMT',
                             LanguageLocaleKey = 'en_US',
                             EmailEncodingKey = 'UTF-8',
                             LocaleSidKey = 'en_US'
                            );
        insert usr2;
        
        Case caseRecord = new Case();
        caseRecord.Status='New';
        caseRecord.Priority='Medium';
        caseRecord.Origin='Email';
        insert caseRecord;
        
        CaseTeamMember ctmadd = new CaseTeamMember();
        ctmadd.ParentId = caseRecord.id;
        ctmadd.MemberId = usr.Id;
        ctmadd.TeamRoleId = CaseTeamRoleId;
        insert ctmadd;
        CaseTeamMemberList.add(ctmadd);
        
        CaseTeamMember ctmaddObj = new CaseTeamMember();
        ctmaddObj.ParentId = caseRecord.id;
        ctmaddObj.MemberId = usr2.Id;
        ctmaddObj.TeamRoleId = CaseTeamRoleId;
        insert ctmaddObj;
        CaseTeamMemberList.add(ctmaddObj);
        
        List<EmailMessage> emailMessageList = new List<EmailMessage>();
        
        emailMessageList.add(new EmailMessage(FromAddress = 'rasika.jadhav@theblueflamelabs.com', Incoming = True, 
                                              ToAddress= 'kritika.sharma@theblueflamelabs.com', 
                                              Subject = 'Test email', TextBody = '23456',
                                              ParentId=caseRecord.Id,BccAddress=''));  
        emailMessageList.add(new EmailMessage(FromAddress = 'rasika.jadhav@theblueflamelabs.com', Incoming = True, 
                                              ToAddress= 'sonam.sharma@theblueflamelabs.com', 
                                              Subject = 'Test email', TextBody = '12345',
                                              ParentId=caseRecord.Id,BccAddress='')); 
        
        Test.startTest();
        insert emailMessageList; 
        Test.stopTest();
        
        for(EmailMessage emobj:[select BccAddress from EmailMessage])
        {
            System.assertEquals('rasikajadhavid@gmail.com; rasikajadhav2109@gmail.com', emobj.BccAddress);
        }
        
    }
    
    @isTest
    public static void SetBCCAddressTestNegative()
    {
        List<CaseTeamMember> CaseTeamMemberList = new List<CaseTeamMember>();
        Id CaseTeamRoleId = [select Id from CaseTeamRole where name='Admin'].Id;
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User usr = new User(LastName = 'Test',
                            FirstName='Data',
                            Alias = 'demo',
                            Email = 'rasikajadhavid@gmail.com',
                            Username = 'abc@theblueflamelabs.com',
                            ProfileId = profileId.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US'
                           );
        insert usr;
        User usr2 = new User(LastName = 'Testing',
                             FirstName='Data',
                             Alias = 'demoex',
                             Email = 'rasikajadhav2109@gmail.com',
                             Username = 'rasika@theblueflamelabs.com',
                             ProfileId = profileId.id,
                             TimeZoneSidKey = 'GMT',
                             LanguageLocaleKey = 'en_US',
                             EmailEncodingKey = 'UTF-8',
                             LocaleSidKey = 'en_US'
                            );
        insert usr2;
        
        Account acc= new Account();
        acc.Name='ABC';
        insert acc;
        
        List<EmailMessage> emailMessageList = new List<EmailMessage>();
        
        emailMessageList.add(new EmailMessage(FromAddress = 'rasika.jadhav@theblueflamelabs.com', Incoming = True, 
                                              ToAddress= 'kritika.sharma@theblueflamelabs.com', 
                                              Subject = 'Test email', TextBody = '23456',
                                              RelatedtoId=acc.Id));  
        emailMessageList.add(new EmailMessage(FromAddress = 'rasika.jadhav@theblueflamelabs.com', Incoming = True, 
                                              ToAddress= 'sonam.sharma@theblueflamelabs.com', 
                                              Subject = 'Test email', TextBody = '12345',
                                              RelatedtoId=acc.Id)); 
        Test.startTest();
        insert emailMessageList; 
        Test.stopTest();
        
        for(EmailMessage emobj:[select BccAddress from EmailMessage])
        {
            System.assertEquals(NULL, emobj.BccAddress);
        }  
    }
    
}