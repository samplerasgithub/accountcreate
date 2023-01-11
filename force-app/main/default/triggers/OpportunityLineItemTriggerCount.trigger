trigger OpportunityLineItemTriggerCount on OpportunityLineItem (after insert,after delete,after update) {
    if(Trigger.isInsert && Trigger.isAfter)
    {
        OpportunityLineItemHandlerCount.sumTotalAmount(Trigger.new);        
    }
    if(Trigger.isdelete && Trigger.isAfter)
    {
        OpportunityLineItemHandlerCount.sumTotalAmountdel(Trigger.old);
    }
    if(Trigger.isupdate && Trigger.isAfter)
    {
        OpportunityLineItemHandlerCount.sumTotalAmountupdate(Trigger.oldMap,Trigger.new);
    }
    
}