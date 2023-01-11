@isTest
public class CaseTriggerDetailsHandlerTest {
    @isTest
    public static void GetCaseDetailsTest()
    {
        Id rec= [select Id from RecordType where Name='Bug'].Id;
        Opportunity opp= new Opportunity();
        opp.Name='Testing Data';
        opp.StageName='Prospecting';
        opp.CloseDate=Date.newInstance(2021, 06, 24);
        insert opp;
        
        List<Case> caseList = new List<Case>();
        
        Case caseObj= new Case();
        caseObj.RecordTypeId=rec;
        caseObj.Status='New';
        caseObj.Priority='Phone';
        caseObj.Due_Date__c=Date.newInstance(2021, 06, 24);
        caseObj.Opportunity__c=opp.Id;
        caseList.add(caseObj);
        insert caseList;
        
       	opp.Case_Details__c=caseObj.Status;
        update opp;
        
        Opportunity obj = [select Id,Case_Details__c from Opportunity where Id =:opp.Id];
        
        Test.startTest();
        CaseriggerDetailsHandler.GetCaseDetails(caseList);
        Test.stopTest();
        
        System.assertEquals('New', obj.Case_Details__c);
    }
    
    @isTest
    public static void GetCaseDetailsTest2()
    {
        Id rec= [select Id from RecordType where Name='Bug'].Id;
        Opportunity opp= new Opportunity();
        opp.Name='Testing Data';
        opp.StageName='Prospecting';
        opp.CloseDate=Date.newInstance(2021, 06, 24);
        insert opp;
        
        List<Case> caseList = new List<Case>();
        
        Case caseObj= new Case();
        caseObj.RecordTypeId=rec;
        caseObj.Status='New';
        caseObj.Priority='Phone';
        caseObj.Due_Date__c=Date.newInstance(2021, 06, 24);
        caseObj.Opportunity__c=opp.Id;
        caseList.add(caseObj);
        
        Case caseObj1= new Case();
        caseObj1.RecordTypeId=rec;
        caseObj1.Status='QA';
        caseObj1.Priority='Phone';
        caseObj1.Due_Date__c=Date.newInstance(2021, 06, 24);
        caseObj1.Opportunity__c=opp.Id;
        caseList.add(caseObj1);
        insert caseList;
        
        opp.Case_Details__c=caseObj.Status+ '; ' +caseObj1.Status;
        update opp;
        
        Opportunity obj = [select Id,Case_Details__c from Opportunity where Id =:opp.Id];
        Test.startTest();
        CaseriggerDetailsHandler.GetCaseDetails(caseList);
        Test.stopTest();
        
        System.assertEquals('New; QA', obj.Case_Details__c);
    }
    
}