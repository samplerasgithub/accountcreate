public class OpportunityCountHandler {
    public static void opportunityCount(List<Opportunity> oppList)
    {
        Map<Id,List<Opportunity>> AccountIdVsOpportunity = new Map<Id,List<Opportunity>>();
       
        Set<Id> accId = new Set<Id>();
        for(Opportunity opp:oppList)
        {
            if(AccountIdVsOpportunity.containsKey(opp.AccountId) && AccountIdVsOpportunity.get(opp.AccountId)!=NULL)
            {
                List<Opportunity> opportunityList = AccountIdVsOpportunity.get(opp.AccountId);
                opportunityList.add(opp);
                AccountIdVsOpportunity.put(opp.AccountId,opportunityList); 
            }   
            else {
                AccountIdVsOpportunity.put(opp.AccountId, new List<Opportunity> {opp});
                accId.add(opp.AccountId);
            }
        }
        
        System.debug('AccountIdVsOpportunity'+AccountIdVsOpportunity);
        System.debug('accId'+accId);
        List<Account> accList = [SELECT Id,No_of_Opportunities__c from Account where Id IN:accId];
        for(Account acc: accList)
        {
            Decimal noofopp =0;
            if (AccountIdVsOpportunity.containsKey(acc.Id)) 
            {
                noofopp = noofopp + AccountIdVsOpportunity.get(acc.Id).size();  
            }   
            acc.No_of_Opportunities__c = acc.No_of_Opportunities__c + noofopp;
            
        }
        update accList;
        System.debug('accList'+accList);
        
    }
     public static void opportunityCountdelete(List<Opportunity> oppList)
     {
         System.debug('oppList'+oppList);
         Map<Id,List<Opportunity>> AccountIdVsOpportunitydel = new Map<Id,List<Opportunity>>();
         Set<Id> accId = new Set<Id>();
        for(Opportunity opp:oppList)
        {
            if(AccountIdVsOpportunitydel.containsKey(opp.AccountId) && AccountIdVsOpportunitydel.get(opp.AccountId)!=NULL)
            {
                List<Opportunity> opportunityList = AccountIdVsOpportunitydel.get(opp.AccountId);
                opportunityList.add(opp);
                AccountIdVsOpportunitydel.put(opp.AccountId,opportunityList); 
            }   
            else {
                AccountIdVsOpportunitydel.put(opp.AccountId, new List<Opportunity> {opp});
                accId.add(opp.AccountId);
            }
        }
        
        System.debug('AccountIdVsOpportunitydel'+AccountIdVsOpportunitydel);
        System.debug('accId'+accId);
        List<Account> accList = [SELECT Id,No_of_Opportunities__c from Account where Id IN:accId];
        for(Account acc: accList)
        {
            Decimal noofopp =0;
            if (AccountIdVsOpportunitydel.containsKey(acc.Id)) 
            {
                noofopp =  AccountIdVsOpportunitydel.get(acc.Id).size() - noofopp;  
            }   
            acc.No_of_Opportunities__c = acc.No_of_Opportunities__c - noofopp;
            
        }
        update accList;
        System.debug('accList'+accList);
         
     }
    
}