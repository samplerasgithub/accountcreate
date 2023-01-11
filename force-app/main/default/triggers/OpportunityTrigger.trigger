trigger OpportunityTrigger on Opportunity (before insert,after insert,after update) {
    if( trigger.isBefore &&  Trigger.isInsert)
    {
        OpportunityTriggerHandler.beforeInsertOpportunity(Trigger.new);
    }
    
    if(Trigger.isUpdate && Trigger.isAfter)
    {
        OpportunityTriggerHandler.updateStage(Trigger.new,Trigger.oldMap);
    }
}