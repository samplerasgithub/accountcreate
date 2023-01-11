@isTest
public class AccountUpdateHandlerTest {
    //Single Record positive scenario for update expiry date on account and it will update closedate on related opportunity
    @isTest
    public static void UpdateCloseDateOnOppSinglePostitive()
    {
        Account acc= new Account(Name='Acc1',SLAExpirationDate__c=Date.newInstance(2022, 2, 12));
        insert acc;
        Opportunity opp = new Opportunity(Name='opp1',StageName='Closed Lost',CloseDate=Date.newInstance(2023, 1, 11),AccountId=acc.Id);
        Test.startTest();
        insert opp;
        acc.SLAExpirationDate__c=Date.newInstance(2024, 1, 5);
        update acc;
        Test.stopTest();
        for(Opportunity opportunityObj:[SELECT CloseDate FROM Opportunity Where AccountId=:acc.Id])
            System.assertEquals(acc.SLAExpirationDate__c, opportunityObj.Closedate);
    } 
    //Single Record negative scenario for update Other field on account and it will not update closedate on related opportunity
    @isTest
    public static void UpdateCloseDateOnOppSingleNegative()
    {
        Account acc= new Account(Name='Acc1',SLAExpirationDate__c=Date.newInstance(2022, 2, 12));
        insert acc;
        Opportunity opp = new Opportunity(Name='opp1',StageName='Closed Lost',CloseDate=Date.newInstance(2023, 1, 11),AccountId=acc.Id);
        Test.startTest();
        insert opp;
        acc.Name='Account2';
        update acc;
        Test.stopTest();
        for(Opportunity opportunityObj:[SELECT CloseDate FROM Opportunity Where AccountId=:acc.Id])
            System.assertEquals(Date.newInstance(2023, 1, 11), opportunityObj.Closedate);
    } 
    //Bulk Record positive scenario for update expiry date on account and it will update closedate on related opportunity
    @isTest
    public static void UpdateCloseDateOnOppSBulkPostitive()
    {
        List<Account> accountList = new  List<Account>();
        for(Integer i =1;i<5;i++)
        {
            Account acc= new Account();
            acc.Name='Test dummy'+i;
            acc.SLAExpirationDate__c=Date.newInstance(2022, 2, 12);
            accountList.add(acc);
        }
        insert accountList;
        List<Opportunity> oppList = new  List<Opportunity>();
        for(Account acc:accountList)
        {
            Opportunity opp = new Opportunity(Name='opp',StageName='Closed Lost',CloseDate=Date.newInstance(2023, 1, 11),AccountId=acc.Id);
            oppList.add(opp); 
        }
        insert oppList;
        Set<Id> accId = new Set<Id>();
        for(Account accobj:accountList)
        {
            accobj.SLAExpirationDate__c=Date.newInstance(2024, 1, 22);
            accId.add(accobj.Id);
        }
        Test.startTest();
        Update accountList;
        Test.stopTest();
        for(Opportunity opportunityObj:[SELECT CloseDate FROM Opportunity Where AccountId IN:accId])
            System.assertEquals(Date.newInstance(2024, 1, 22), opportunityObj.Closedate);
    } 
    //Bulk Record Negative scenario for update another field on account and it will not update closedate on related opportunity
    @isTest
    public static void UpdateCloseDateOnOppSBulkNegative()
    {
        List<Account> accountList = new  List<Account>();
        for(Integer i =1;i<5;i++)
        {
            Account acc= new Account();
            acc.Name='Test dummy'+i;
            acc.SLAExpirationDate__c=Date.newInstance(2022, 2, 12);
            accountList.add(acc);
        }
        insert accountList;
        List<Opportunity> oppList = new  List<Opportunity>();
        for(Account acc:accountList)
        {
            Opportunity opp = new Opportunity(Name='opp',StageName='Closed Lost',CloseDate=Date.newInstance(2023, 1, 11),AccountId=acc.Id);
            oppList.add(opp); 
        }
        insert oppList;
        Set<Id> accId = new Set<Id>();
        for(Account accobj:accountList)
        {
            accobj.Name='Account Test';
            accId.add(accobj.Id);
        }
        Test.startTest();
        Update accountList;
        Test.stopTest();
        for(Opportunity opportunityObj:[SELECT CloseDate FROM Opportunity Where AccountId IN:accId])
            System.assertEquals(Date.newInstance(2023, 1, 11), opportunityObj.Closedate);
    } 
}