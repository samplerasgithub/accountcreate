public class OpportunityEmailBatch implements database.Batchable<sObject>, Database.Stateful{
    Map<String, List<Opportunity>> emailVsOppMap = new Map<String, List<Opportunity>>();
    public database.QueryLocator start(database.BatchableContext bc){
        string query;
        query = 'SELECT Id, Name, StageName, Amount, Account.Primary_Contact__r.Email FROM Opportunity WHERE Closed_Won_DateTime__c = Today AND StageName  = \'Closed Won\'';
        return database.getQueryLocator(query);
    }
    public void execute(database.BatchableContext bc, List<Opportunity> oppList){
        for(Opportunity opp : oppList){
            if(opp.Account.Primary_Contact__r.Email != null ){
                if(!(emailVsOppMap.containsKey(opp.Account.Primary_Contact__r.Email))){
                    emailVsOppMap.put(opp.Account.Primary_Contact__r.Email, new List<Opportunity>{opp});
                }
                else{
                    emailVsOppMap.get(opp.Account.Primary_Contact__r.Email).add(opp);
                }
            }
        }
    }
    public void finish(database.BatchableContext bc){
        System.debug('Map----'+emailVsOppMap);
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        String Body ='';
        Double Amount = 0;
        for(String emailString : emailVsOppMap.keySet()){
            Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
            emailObj.setToAddresses(new List<String> {emailString});
            emailObj.setSenderDisplayName('Salesforce');
            emailObj.setSubject('Todays Closed Won Opportunity Info');
            for(Opportunity opp : emailVsOppMap.get(emailString)){
                Amount = Amount + opp.Amount;
                Body += 'Name : '+opp.Name+' Amount : '+opp.Amount+'\n'+'<br/>';
            }
            Body += 'Total Amount : '+Amount;
            emailObj.setHtmlBody(Body);
            emailList.add(emailObj);
        }
        Messaging.sendEmail(emailList);
    }
}