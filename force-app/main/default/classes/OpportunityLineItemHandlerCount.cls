public class OpportunityLineItemHandlerCount {
    public static void sumTotalAmount(List<OpportunityLineItem> oppLIList)
    {
        System.debug('oppLIList'+oppLIList);
        Map<Id,List<OpportunityLineItem>> idvsOpportunityLineItem= new Map<Id,List<OpportunityLineItem>>();
        for(OpportunityLineItem oppLi :oppLIList){
            if(idvsOpportunityLineItem.containsKey(oppLi.OpportunityId) && idvsOpportunityLineItem.get(oppLi.OpportunityId)!=NULL){
                List<OpportunityLineItem> opportunityLiList = idvsOpportunityLineItem.get(oppLi.OpportunityId);
                opportunityLiList.add(oppLi);
                idvsOpportunityLineItem.put(oppLi.OpportunityId,opportunityLiList); 
            }   
            else {
                idvsOpportunityLineItem.put(oppLi.OpportunityId, new List<OpportunityLineItem> {oppLi});
            }
        }  
        System.debug('idvsOpportunityLineItem'+idvsOpportunityLineItem);
        List<AggregateResult> result =new List<AggregateResult>([SELECT SUM(Amount__c)sumcnt,MAX(Amount__c)maxcnt,OpportunityId 
                                                                 from OpportunityLineItem where OpportunityId 
                                                                 IN:idvsOpportunityLineItem.keyset()
                                                                 GROUP by OpportunityId]);
        System.debug('result'+result);
        List<Opportunity> oppList = new List<Opportunity>();
        for(AggregateResult a : result) {   
            oppList.add(new Opportunity(Id=(Id)a.get('OpportunityId'),
                                        Amount__c= (Decimal)a.get('sumcnt'),Max_Amount__c= (Decimal)a.get('maxcnt')));  
            
        }
        update oppList; 
        System.debug('oppList'+oppList);   
    }
    public static void sumTotalAmountdel(List<OpportunityLineItem> oppLIList)
    {
        System.debug('oppLIList'+oppLIList);
        Map<Id,List<OpportunityLineItem>> idvsOpportunityLineItem= new Map<Id,List<OpportunityLineItem>>();
        for(OpportunityLineItem oppLi :oppLIList){
            if(idvsOpportunityLineItem.containsKey(oppLi.OpportunityId) && idvsOpportunityLineItem.get(oppLi.OpportunityId)!=NULL){
                List<OpportunityLineItem> opportunityLiList = idvsOpportunityLineItem.get(oppLi.OpportunityId);
                opportunityLiList.add(oppLi);
                idvsOpportunityLineItem.put(oppLi.OpportunityId,opportunityLiList); 
            }   
            else {
                idvsOpportunityLineItem.put(oppLi.OpportunityId, new List<OpportunityLineItem> {oppLi});
            }
        }  
        System.debug('idvsOpportunityLineItem'+idvsOpportunityLineItem);
        List<AggregateResult> result =new List<AggregateResult>([SELECT SUM(Amount__c)sumcnt,MAX(Amount__c)maxcnt,OpportunityId from 
                                                                 OpportunityLineItem where OpportunityId 
                                                                 IN:idvsOpportunityLineItem.keyset()
                                                                 GROUP by OpportunityId]);
        System.debug('result'+result);
        List<Opportunity> oppList = new List<Opportunity>();
        if(!result.isEmpty()){
            for(AggregateResult a : result) {   
                oppList.add(new Opportunity(Id=(Id)a.get('OpportunityId'),
                                            Amount__c= (Decimal)a.get('sumcnt'),Max_Amount__c= (Decimal)a.get('maxcnt')));  
            }
        }
        else{
            for(Id a:idvsOpportunityLineItem.keyset()){   
                oppList.add(new Opportunity(Id=a,Amount__c= 0.00,Max_Amount__c=0.00)); 
            }  
        }
        update oppList; 
        System.debug('oppList'+oppList);
    }
    
    public static void sumTotalAmountupdate(Map<Id,OpportunityLineItem> oppMap, List<OpportunityLineItem> oppLIList)
    {
        System.debug('oppMap'+oppMap);
        System.debug('oppLIList'+oppLIList);
        Map<Id,List<OpportunityLineItem>> idvsOpportunityLineItem= new Map<Id,List<OpportunityLineItem>>();
        for(OpportunityLineItem oppLi :oppLIList){
            if(idvsOpportunityLineItem.containsKey(oppLi.OpportunityId) && idvsOpportunityLineItem.get(oppLi.OpportunityId)!=NULL){
                List<OpportunityLineItem> opportunityLiList = idvsOpportunityLineItem.get(oppLi.OpportunityId);
                opportunityLiList.add(oppLi);
                idvsOpportunityLineItem.put(oppLi.OpportunityId,opportunityLiList); 
            }   
            else {
                idvsOpportunityLineItem.put(oppLi.OpportunityId, new List<OpportunityLineItem> {oppLi});
            }
        }  
        System.debug('idvsOpportunityLineItem'+idvsOpportunityLineItem);
        List<AggregateResult> result =new List<AggregateResult>([SELECT SUM(Amount__c)sumcnt,MAX(Amount__c)maxcnt,OpportunityId from 
                                                                 OpportunityLineItem where OpportunityId 
                                                                 IN:idvsOpportunityLineItem.keyset()
                                                                 GROUP by OpportunityId]);
        System.debug('result'+result);
        List<Opportunity> oppList = new List<Opportunity>();
        if(!result.isEmpty()){
            for(AggregateResult a : result) {   
                oppList.add(new Opportunity(Id=(Id)a.get('OpportunityId'),
                                            Amount__c= (Decimal)a.get('sumcnt'),Max_Amount__c= (Decimal)a.get('maxcnt')));   
            }
        }
        else{
            for(Id a:idvsOpportunityLineItem.keyset()){   
                oppList.add(new Opportunity(Id=a,Amount__c= 0.00,Max_Amount__c=0.00));
            }  
        }
        update oppList; 
        System.debug('oppList'+oppList);
        
        //for old opportunity iD
        /* Map<Id,List<OpportunityLineItem>> idvsOpportunityLineItemold= new Map<Id,List<OpportunityLineItem>>();
for(OpportunityLineItem oppLi :oppMap.values()){
if(idvsOpportunityLineItemold.containsKey(oppLi.OpportunityId) && idvsOpportunityLineItem.get(oppLi.OpportunityId)!=NULL){
List<OpportunityLineItem> opportunityLiList = idvsOpportunityLineItem.get(oppLi.OpportunityId);
opportunityLiList.add(oppLi);
idvsOpportunityLineItemold.put(oppLi.OpportunityId,opportunityLiList); 
}   
else {
idvsOpportunityLineItemold.put(oppLi.OpportunityId, new List<OpportunityLineItem> {oppLi});
}
}  
System.debug('idvsOpportunityLineItemold'+idvsOpportunityLineItemold);
List<AggregateResult> resultold =new List<AggregateResult>([SELECT SUM(Amount__c)sumcnt,MAX(Amount__c)maxcnt,OpportunityId from 
OpportunityLineItem where OpportunityId 
IN:idvsOpportunityLineItemold.keyset()
GROUP by OpportunityId]);
System.debug('resultold'+resultold);
List<Opportunity> oppListold = new List<Opportunity>();
if(!result.isEmpty()){
for(AggregateResult a : result) {   
oppListold.add(new Opportunity(Id=(Id)a.get('OpportunityId'),
Total_Amount__c= (Decimal)a.get('sumcnt'),Max_Amount__c= (Decimal)a.get('maxcnt')));   
}
}
else{
for(Id a:idvsOpportunityLineItem.keyset()){   
oppListold.add(new Opportunity(Id=a,Total_Amount__c= 0.00,Max_Amount__c=0.00));
}  
}
update oppListold; 
System.debug('oppListold'+oppListold);*/
    } 
}