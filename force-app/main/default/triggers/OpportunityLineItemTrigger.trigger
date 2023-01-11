trigger OpportunityLineItemTrigger on OpportunityLineItem (after insert,after delete,after Update) {
    if(Trigger.isAfter && Trigger.isInsert)
    {
        OpportunityLineItemHandler.sumTotalAmount(Trigger.New);
    }
     if(Trigger.isAfter && Trigger.isdelete)
    {
        OpportunityLineItemHandler.sumTotalAmountdel(Trigger.old);
    }
    if(Trigger.isAfter && Trigger.isUpdate)
    {
        OpportunityLineItemHandler.sumTotalAmountupdate(Trigger.oldMap, Trigger.new);
    }
    
}