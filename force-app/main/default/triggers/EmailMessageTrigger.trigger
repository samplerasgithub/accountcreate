trigger EmailMessageTrigger on EmailMessage (before insert) {
    if(Trigger.isBefore && Trigger.isInsert)
    {
        EmailMessageHandler.SetBCCAddress(Trigger.new);
    }
    
}