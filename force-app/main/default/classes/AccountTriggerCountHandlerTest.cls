@isTest
public class AccountTriggerCountHandlerTest {
    //single record positive scenario for insertion
    @isTest
    public static void createContactSinglePositive()
    {
        Account accountList = new Account(Name='ABC',count_of_contact__c=3);
        Test.startTest();
        insert accountList;
        Test.stopTest();
        List<AggregateResult> results=[SELECT count(Id)cnt FROM Contact Where AccountId=:accountList.Id];
        for(AggregateResult a : results) {     
            System.assertEquals(3, a.get('cnt'));  
        }  
    }
    //single record negative scenario for insertion
    @isTest
    public static void createContactSingleNegative()
    {
        Account accountList = new Account(Name='PQR');
        Test.startTest();
        insert accountList;
        Test.stopTest();
        List<AggregateResult> results=[SELECT count(Id)cnt FROM Contact Where AccountId=:accountList.Id];
        for(AggregateResult a : results) {     
            System.assertEquals(0, a.get('cnt'));  
        }  
    }
    //Bulk record positive scenario for insertion
    @isTest
    public static void createContactBulkPositive()
    {
        List<Account> accountList = new List<Account>{new Account(Name='ABC',count_of_contact__c=4)};
            Set<Id> accountId = new Set<Id>();
        Test.startTest();
        insert accountList;
        Test.stopTest();
        for(Account acc:accountList){
            accountId.add(acc.Id); 
        }
        List<AggregateResult> results=[SELECT count(Id)cnt FROM Contact Where AccountId=:accountId];
        for(AggregateResult a : results) {     
            System.assertEquals(4, a.get('cnt'));  
        }  
    }
    //Bulk record negative scenario for insertion
    @isTest
    public static void createContactBulkNegative()
    {
        List<Account> accountList = new List<Account>{new Account(Name='XYZ')};
            Set<Id> accountId = new Set<Id>();
        Test.startTest();
        insert accountList;
        Test.stopTest();
        for(Account acc:accountList){
            accountId.add(acc.Id); 
        }
        List<AggregateResult> results=[SELECT count(Id)cnt FROM Contact Where AccountId=:accountId];
        for(AggregateResult a : results) {     
            System.assertEquals(0, a.get('cnt'));  
        }  
    }
    //single record positive scenario for update
    @isTest
    public static void updateContactSinglePositiveIncrease()
    {
        Account accountList = new Account(Name='ABC',count_of_contact__c=3);
        Test.startTest();
        insert accountList;
        accountList.count_of_contact__c=5;
        update accountList;
        Test.stopTest();
        List<AggregateResult> results=[SELECT count(Id)cnt FROM Contact Where AccountId=:accountList.Id];
        for(AggregateResult a : results) {     
            System.assertEquals(5, a.get('cnt'));  
        }  
    }
    //single record negative scenario for update
    @isTest
    public static void updateContactSingleNegative()
    {
        Account accountList = new Account(Name='ABC',count_of_contact__c=3);
        Test.startTest();
        insert accountList;
        accountList.Name='XYZ';
        update accountList;
        Test.stopTest();
        List<AggregateResult> results=[SELECT count(Id)cnt FROM Contact Where AccountId=:accountList.Id];
        for(AggregateResult a : results) {     
            System.assertEquals(3, a.get('cnt'));  
        }  
    }
    //single record positive scenario for update
    @isTest
    public static void updateContactSinglePositivedecrease()
    {
        Account accountList = new Account(Name='ABC',count_of_contact__c=5);
        Test.startTest();
        insert accountList;
        accountList.count_of_contact__c=3;
        update accountList;
        Test.stopTest();
        List<AggregateResult> results=[SELECT count(Id)cnt FROM Contact Where AccountId=:accountList.Id];
        for(AggregateResult a : results) {     
            System.assertEquals(3, a.get('cnt'));  
        }  
    }
    //Bulk record positive scenario for updation
    @isTest
    public static void updateContactBulkPositive()
    {
        List<Account> accountList = new List<Account>{new Account(Name='XYZ',count_of_contact__c=5)};
        Set<Id> accountId = new Set<Id>();
        Test.startTest();
        insert accountList;
        for(Account acc:accountList) {
            acc.count_of_contact__c=3;
            accountId.add(acc.Id); 
        }
        update accountList;
        Test.stopTest();
        List<AggregateResult> results=[SELECT count(Id)cnt FROM Contact Where AccountId=:accountId];
        for(AggregateResult a : results) {     
            System.assertEquals(3, a.get('cnt'));  
        }  
    }
    //Bulk record negative scenario for updation
    @isTest
    public static void updateContactBulkNegative()
    {
        List<Account> accountList = new List<Account>{new Account(Name='XYZ',count_of_contact__c=5)};
        Set<Id> accountId = new Set<Id>();
        Test.startTest();
        insert accountList;
        for(Account acc:accountList){
            acc.Name='Demo';
            accountId.add(acc.Id); 
        }
        update accountList;
        Test.stopTest();
        List<AggregateResult> results=[SELECT count(Id)cnt FROM Contact Where AccountId=:accountId];
        for(AggregateResult a : results) {     
            System.assertEquals(5, a.get('cnt'));  
        }  
    } 
}