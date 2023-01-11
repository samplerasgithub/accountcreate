trigger OpportunityCountTrigger on Opportunity (after insert,after delete) {
    if(Trigger.isAfter && Trigger.isInsert)
    {
        OpportunityCountHandler.opportunityCount(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isDelete)
    {
        OpportunityCountHandler.opportunityCountdelete(Trigger.new);
    }
    
    
}