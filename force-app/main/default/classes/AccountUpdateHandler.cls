//Whenever expiry date on account update,then closed date of related opportunity should be expiry date of account. 
public class AccountUpdateHandler {
    //Whenever expiry date on Account update,then closed date of related opportunity should be expiry date of account. 
    public static void UpdateCloseDateOnOpportunity(Set<Id>accountId)
    {
        System.debug('accountId'+accountId);
        List<Opportunity> oppList = [SELECT CloseDate,Account.SLAExpirationDate__c FROM Opportunity where AccountId IN:accountId];
        List<Opportunity> opportunityListToUpdate = new List<Opportunity>();
        for(Opportunity opp : oppList){
            if(opp.CloseDate != opp.Account.SLAExpirationDate__c)
            {
                opp.CloseDate = opp.Account.SLAExpirationDate__c;
                opportunityListToUpdate.add(opp); 
            }
        }
        update opportunityListToUpdate;
        System.debug('opportunityListToUpdate'+opportunityListToUpdate);
    }
}