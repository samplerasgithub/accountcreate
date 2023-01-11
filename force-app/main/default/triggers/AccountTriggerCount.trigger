trigger AccountTriggerCount on Account (after insert,after update) {
    if(Trigger.isInsert && Trigger.isAfter)
    {
        AccountTriggerCountHandler.createContact(Trigger.new);
    }
    if(Trigger.isUpdate && Trigger.isAfter)
    {
        AccountTriggerCountHandler.contactCountupdate(Trigger.oldMap,Trigger.new);
    }
    
}