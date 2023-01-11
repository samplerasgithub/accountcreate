global class CaseBatchEx implements Database.Batchable <sObject>,Database.Stateful {
    Integer counter;
    public CaseBatchEx()
    {
        counter=0;
    } 
    List<Case> caseListMain= new List<Case>();
    Id id=[select Id from RecordType where Name='Bug'].Id;
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        System.debug('Inside start');
        String query;
        query = 'select Id,StageName,OwnerId from Opportunity where CloseDate =Today';
        System.debug('Query'+query);
        counter++;
        return Database.getQueryLocator(query);  
    }
    global void execute(Database.BatchableContext bc, List<Opportunity> OppList)
    {
        System.debug('Inside execute');
        for(Opportunity opp:OppList)
        {
            Case cased= new Case();
            cased.RecordTypeId=id;
            cased.Status='New';
            cased.Origin='Email';
            cased.Billable_Hours__c=10;
            cased.Due_Date__c=date.today();
            cased.Subject='rasikaj';
            cased.Opportunity__c=opp.Id;
            cased.OwnerId=opp.ownerId;
            caseListMain.add(cased);
            
        }
        if(!caseListMain.isEmpty())
        {
            insert caseListMain;
        }
        System.debug('caseListdemo'+caseListMain);
    }
    global void finish(Database.BatchableContext bc)
    {
        counter++;
        Map<Id,Id> owner = new Map<Id,Id>();
        String body;
        List<Messaging.SingleEmailMessage> mails= new  List<Messaging.SingleEmailMessage>(); 
        System.debug('Inside finish');
        /*for(Case caseowner:caseListMain)
{
owner.put(caseowner.Id,caseowner.OwnerId);
}
System.debug('owner'+owner);*/
        //String ownerEmail  = [select Email from User where Id=:owner].Email;
        //AsyncApexJob a = [Select Id, Status,ExtendedStatus,NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email from AsyncApexJob where Id =:BC.getJobId()];
        
        for(Case caseList:caseListMain)
        {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            /*String[] toAddresses = new String[] {ownerEmail};
			mail.setToAddresses(toAddresses);*/
            mail.setTargetObjectId(caseList.OwnerId);
            mail.setSaveAsActivity(false);
            mail.setSubject('Case is created');
            body='Case is created.';
            body +='<br><br>Case Id: ' + caseList.Id + ' , ';
            body +='<br><br>Related Opportunity Id: ' + caseList.Opportunity__c +' , ';
            body +=' <br><br>Case Subject: ' + caseList.Subject + ' , ';
            body +=' <br><br> Case Billable_Hours__c: ' +caseList.Billable_Hours__c + ' , ';
            body +=' <br><br>Case Status: ' + caseList.Status + ' . ';
            body +=' <br><br> Case Origin: ' +caseList.Origin + ' , ';
            body +=' <br><br>Case Owner: ' + caseList.OwnerId + ' . ';
            body +=' <br><br>';
            mail.setHtmlBody(body);
            mails.add(mail);
        }
        Messaging.sendEmail(mails);
        
    }
}