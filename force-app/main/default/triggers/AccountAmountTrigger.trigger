trigger AccountAmountTrigger on Account (before update) {
    if(Trigger.isBefore && Trigger.isUpdate)
    {
       AccountTriggerHandler.CalculateTotalAmount(Trigger.new); 
    }

}