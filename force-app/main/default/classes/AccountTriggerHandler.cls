public class AccountTriggerHandler {
    public static void CalculateTotalAmount(List<Account> accList)
    {
        Set<Id> accId = new Set<Id>();
    
        double amount=0;
        for(Account acc:accList)
        {
            accId.add(acc.Id);           
        }
        List<Opportunity> oppList = [select Id,Amount from Opportunity where AccountId=:accId];
        for(Opportunity opp: oppList)
        {
            amount=amount+opp.Amount;
        }
        System.debug('Amount'+amount);
        Map<Id,Double> amountMap = new Map<Id,Double>();
        for(Account acc:accList)
        {
            acc.Total_Opportunity_Amount__c=amount;
            amountMap.put(acc.Id,acc.Total_Opportunity_Amount__c=amount);
            
        }
        System.debug('amountMap'+amountMap);
    }
    
}