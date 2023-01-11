@isTest
public class OpportunityLineItemHandlerCountTest {
    @testsetup public static void setup() {
        Account objAccount = new Account();
        objAccount.Name = 'Test';
        Insert objAccount;
        
        Opportunity objOpporunity = new Opportunity();
        objOpporunity.Name = 'Test Opporutnity';
        objOpporunity.AccountId = objAccount.Id;
        objOpporunity.StageName = 'Closed Won';
        objOpporunity.CloseDate = system.Today();
        Insert objOpporunity;
        
        Product2 objProduct = new Product2();
        objProduct.Name = 'Test';
        objProduct.Description = 'Test';
        Insert objProduct; 
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        Update standardPricebook;
        PricebookEntry objPBEntry = new PricebookEntry(Pricebook2Id = standardPricebook.Id, Product2Id=objProduct.Id,UnitPrice=500,IsActive=true);
        Insert objPBEntry;
        
    }
    //Insert scenario
    //positive scenario for bulkified testing
    @isTest
    public static void opportunityLisumCountTestbulk()
    {
        List<OpportunityLineItem> oppLiList = new List<OpportunityLineItem>(); 
        Id oppId =[select Id from Opportunity where Name=:'Test Opporutnity'].Id;
        Id proId =[select Id from Product2 where Name=:'Test'].Id;
        Id objPBEntry=[select Id from PricebookEntry where Product2Id=:proId].Id;
        for(Integer i=1;i<=10;i++){
            oppLiList.add(new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500,Amount__c=10)); 
        }
        Test.startTest();
        insert oppLiList;
        Test.stopTest();
        for(Opportunity opp:[select Amount__c,Max_Amount__c from Opportunity where Id=:oppId]){
            System.assertEquals(100, opp.Amount__c);
            System.assertEquals(10, opp.Max_Amount__c);}  
    }
    //Insert scenario
    //positive scenario for single testing
    @isTest
    public static void opportunityLisumCountTestpossingle()
    {
        Id oppId =[select Id from Opportunity where Name=:'Test Opporutnity'].Id;
        Id proId =[select Id from Product2 where Name=:'Test'].Id;
        Id objPBEntry=[select Id from PricebookEntry where Product2Id=:proId].Id;
        
        OpportunityLineItem oppLi = new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500,Amount__c=10); 
        Test.startTest();
        insert oppLi;
        Test.stopTest();
        for(Opportunity opp:[select Amount__c,Max_Amount__c from Opportunity where Id=:oppId]){
            System.assertEquals(10, opp.Amount__c);
            System.assertEquals(10, opp.Max_Amount__c);}  
    }
    //Insert scenario
    //negative scenario for bulkified testing
    @isTest
    public static void opportunityLisumCountTestbulkneg()
    {
        List<OpportunityLineItem> oppLiList = new List<OpportunityLineItem>(); 
        Id oppId =[select Id from Opportunity where Name=:'Test Opporutnity'].Id;
        Id proId =[select Id from Product2 where Name=:'Test'].Id;
        Id objPBEntry=[select Id from PricebookEntry where Product2Id=:proId].Id;
        for(Integer i=1;i<=10;i++){
            oppLiList.add(new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500)); 
        }
        Test.startTest();
        insert oppLiList;
        Test.stopTest();
        for(Opportunity opp:[select Amount__c,Max_Amount__c from Opportunity where Id=:oppId]){
            System.assertEquals(0.00, opp.Amount__c);
            System.assertEquals(0.00, opp.Max_Amount__c);}  
    }
    //Negative scenario for single test data insert
    @isTest
    public static void opportunityLisumCountTestsinglekneg()
    {
        Id oppId =[select Id from Opportunity where Name=:'Test Opporutnity'].Id;
        Id proId =[select Id from Product2 where Name=:'Test'].Id;
        Id objPBEntry=[select Id from PricebookEntry where Product2Id=:proId].Id;
        
        OpportunityLineItem oppLi = new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500); 
        Test.startTest();
        insert oppLi;
        Test.stopTest();
        for(Opportunity opp:[select Amount__c,Max_Amount__c from Opportunity where Id=:oppId]){
            System.assertEquals(0.00, opp.Amount__c);
            System.assertEquals(0.00, opp.Max_Amount__c);
        }  
    }
    //delete positive scenario for bulk testing
    @isTest
    public static void opportunityLisumCountTestbulkposdelete()
    {
        List<OpportunityLineItem> oppLiList = new List<OpportunityLineItem>();
        List<OpportunityLineItem> oppLiList1 = new List<OpportunityLineItem>(); 
        Id oppId =[select Id from Opportunity where Name=:'Test Opporutnity'].Id;
        Id proId =[select Id from Product2 where Name=:'Test'].Id;
        Id objPBEntry=[select Id from PricebookEntry where Product2Id=:proId].Id;
        for(Integer i=1;i<=10;i++){
            oppLiList.add(new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500,Amount__c=10)); 
        }
        for(Integer i=1;i<=10;i++){
            oppLiList1.add(new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500,Amount__c=10)); 
        }
        Test.startTest();
        insert oppLiList;
        insert oppLiList1;
        delete oppLiList;
        Test.stopTest();
        for(Opportunity opp:[select Amount__c,Max_Amount__c from Opportunity where Id=:oppId]){
            System.assertEquals(100.00, opp.Amount__c);
            System.assertEquals(10.00, opp.Max_Amount__c);  
        } 
        
    }
    //delete positive scenario for single record testing
    @isTest
    public static void opportunityLisumCountTestbulkposdeletesingle()
    {
        Id oppId =[select Id from Opportunity where Name=:'Test Opporutnity'].Id;
        Id proId =[select Id from Product2 where Name=:'Test'].Id;
        Id objPBEntry=[select Id from PricebookEntry where Product2Id=:proId].Id;
        OpportunityLineItem oppLi = new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500,Amount__c=10); 
        Test.startTest();
        insert oppLi;
        delete oppLi;
        Test.stopTest();
        for(Opportunity opp:[select Amount__c,Max_Amount__c from Opportunity where Id=:oppId]){
            System.assertEquals(0.00, opp.Amount__c);
            System.assertEquals(0.00, opp.Max_Amount__c); } 
    }
    //Negative scenario for bulkify test data
    //Delete scenario
    @isTest
    public static void opportunityLisumCountTestbulknegdel()
    {
        Id oppId =[select Id from Opportunity where Name=:'Test Opporutnity'].Id;
        Id proId =[select Id from Product2 where Name=:'Test'].Id;
        Id objPBEntry=[select Id from PricebookEntry where Product2Id=:proId].Id;
        OpportunityLineItem oppLi = new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500); 
        Test.startTest();
        insert oppLi;
        delete oppLi;
        Test.stopTest();
        for(Opportunity opp:[select Amount__c,Max_Amount__c from Opportunity where Id=:oppId]){
            System.assertEquals(0.00, opp.Amount__c);
            System.assertEquals(0.00, opp.Max_Amount__c);
        } 
    }
    //delete negative scenario for single record testing
    @isTest
    public static void opportunityLisumCountTestbulknegdeletesingle()
    {
        Id oppId =[select Id from Opportunity where Name=:'Test Opporutnity'].Id;
        Id proId =[select Id from Product2 where Name=:'Test'].Id;
        Id objPBEntry=[select Id from PricebookEntry where Product2Id=:proId].Id;
        OpportunityLineItem oppLi = new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500); 
        Test.startTest();
        insert oppLi;
        delete oppLi;
        Test.stopTest();
        for(Opportunity opp:[select Amount__c,Max_Amount__c from Opportunity where Id=:oppId]){
            System.assertEquals(0.00, opp.Amount__c);
            System.assertEquals(0.00, opp.Max_Amount__c);} 
    }
    
    //positive scenario for bulkify test data
    //update scenario
    @isTest
    public static void opportunityLisumCountTestbulkposupdate()
    {
        List<OpportunityLineItem> oppLiList = new List<OpportunityLineItem>();
        Id oppId =[select Id from Opportunity where Name=:'Test Opporutnity'].Id;
        Id proId =[select Id from Product2 where Name=:'Test'].Id;
        Id objPBEntry=[select Id from PricebookEntry where Product2Id=:proId].Id;
        for(Integer i=1;i<=10;i++){
            oppLiList.add(new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500,Amount__c=10)); 
        }
        
        Test.startTest();
        insert oppLiList;
        for(OpportunityLineItem opp:oppLiList){
            opp.Amount__c=100;
        }
        update oppLiList;
        Test.stopTest();
        for(Opportunity opp:[select Amount__c,Max_Amount__c from Opportunity where Id=:oppId]){
            System.assertEquals(1000.00, opp.Amount__c);
            System.assertEquals(100.00, opp.Max_Amount__c);} 
        
    }
    
    //positive scenario for single test data
    //update scenario
    @isTest
    public static void opportunityLisumCountTestsingleposupdate()
    {
        Id oppId =[select Id from Opportunity where Name=:'Test Opporutnity'].Id;
        Id proId =[select Id from Product2 where Name=:'Test'].Id;
        Id objPBEntry=[select Id from PricebookEntry where Product2Id=:proId].Id;
        OpportunityLineItem oppLi = new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500,Amount__c=10);
        Test.startTest();
        insert oppLi; 
        oppLi.Amount__c=0;
        update oppLi;
        Test.stopTest();
        for(Opportunity opp:[select Amount__c,Max_Amount__c from Opportunity where Id=:oppId]){
            System.assertEquals(0.00, opp.Amount__c);
            System.assertEquals(0.00, opp.Max_Amount__c);}  
        
    }
    
    //negative scenario for bulkify test data
    //update scenario
    @isTest
    public static void opportunityLisumCountTestbulknegupdate()
    {
        List<OpportunityLineItem> oppLiList = new List<OpportunityLineItem>();
        Id oppId =[select Id from Opportunity where Name=:'Test Opporutnity'].Id;
        Id proId =[select Id from Product2 where Name=:'Test'].Id;
        Id objPBEntry=[select Id from PricebookEntry where Product2Id=:proId].Id;
        for(Integer i=1;i<=10;i++){
            oppLiList.add(new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500,Amount__c=10)); 
        }
        Test.startTest();
        insert oppLiList;
        for(OpportunityLineItem opp:oppLiList){
            opp.Unitprice=600;
        }
        update oppLiList;
        Test.stopTest();
        for(Opportunity opp:[select Amount__c,Max_Amount__c from Opportunity where Id=:oppId]){
            System.assertEquals(100.00, opp.Amount__c);
            System.assertEquals(10.00, opp.Max_Amount__c);}   
    }
    //negative scenario for single record test data
    //update scenario
    @isTest
    public static void opportunityLisumCountTestsingleknegupdate()
    {
        Id oppId =[select Id from Opportunity where Name=:'Test Opporutnity'].Id;
        Id proId =[select Id from Product2 where Name=:'Test'].Id;
        Id objPBEntry=[select Id from PricebookEntry where Product2Id=:proId].Id;
        OpportunityLineItem oppLi = new OpportunityLineItem(OpportunityId=oppId,PriceBookEntryId=objPBEntry,Quantity=1,Unitprice=500,Amount__c=10); 
        Test.startTest();
        insert oppLi;
        oppLi.Unitprice=600;
        update oppLi;
        Test.stopTest();
        for(Opportunity opp:[select Amount__c,Max_Amount__c from Opportunity where Id=:oppId]){
            System.assertEquals(10.00, opp.Amount__c);
            System.assertEquals(10.00, opp.Max_Amount__c);} 
        
    }
    
}