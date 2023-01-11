trigger AccountUpdateTrigger on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate)
    {
        Set<Id> accountId = new Set<Id>();
        for(Account acc: Trigger.new){
            Account accountObj = Trigger.oldMap.get(acc.Id);
            if(acc.SLAExpirationDate__c!=accountObj.SLAExpirationDate__c){
                accountId.add(acc.Id);
            }
        }
        AccountUpdateHandler.UpdateCloseDateOnOpportunity(accountId);
    }  
}