global class OpportunityUpdateBatch implements Database.Batchable<sObject>, Database.Stateful {
    Integer counter;
    public OpportunityUpdateBatch()
    {
        counter=0;
    }
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        System.debug('Inside start');
        String query;
        query = 'select Id,StageName from Opportunity where StageName =\'Closed Won\'';
        counter++;
        return Database.getQueryLocator(query);
        
    }
    global void execute(Database.BatchableContext bc,List<Opportunity> opportunityList){
        System.debug('Inside execute');
        List<Opportunity> opportunityToUpdateList = new List<Opportunity>();
        String stageToUpdate = 'Qualification';
        if(!opportunityList.isEmpty())
        {
            for(Opportunity obj : opportunityList)
            {
                Opportunity opportunityobj = new Opportunity(Id=obj.Id, StageName = stageToUpdate);
                opportunityToUpdateList.add(opportunityobj);
            }
            if(!opportunityToUpdateList.isEmpty())
                
            {
                DataBase.update(opportunityToUpdateList); 
            }
        }
        counter++;
        
    }
    global void finish(Database.BatchableContext bc)
    {
        counter++;
         System.debug('Inside Finish');
        AsyncApexJob asyncobj =[SELECT Id,
                                TotalJobItems,
                                Status,
                                NumberOfErrors,
                                JobType,
                                JobItemsProcessed
                                from AsyncApexJob
                                where Id=:bc.getJobId()
                               ];
        System.debug('Id-->'+asyncobj.Id);
        System.debug('TotalJobItems-->'+asyncobj.TotalJobItems);
        System.debug('Status-->'+asyncobj.Status);
        System.debug('NumberOfErrors-->'+asyncobj.NumberOfErrors);
        System.debug('JobType-->'+asyncobj.JobType);
        System.debug('JobItemsProcessed-->'+asyncobj.JobItemsProcessed);
        
        //Send email
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage emailobj = new Messaging.SingleEmailMessage();
        emailobj.setToAddresses( new List<String> {'rasika.jadhav@theblueflamelabs.com'});
        emailobj.setSenderDisplayName('Opportunity update');
        emailobj.setSubject('Opportunity batch update result');
        String body = ' Number of record processed= ' + counter + 'Total job items '+ asyncobj.TotalJobItems + 'Status'+
            			asyncobj.Status+ 'NumberOfErrors' +asyncobj.NumberOfErrors+'JobType'+asyncobj.JobType+'JobItemsProcessed'+
						        asyncobj.JobItemsProcessed;
        emailobj.setHtmlBody(body);
        emailList.add(emailobj);
        Messaging.sendEmail(emailList);
    }

}