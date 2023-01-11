trigger AccountTrigger on Account (before insert,before update) {
    if(Trigger.isInsert && Trigger.isbefore)
    {
        AccounTriggerHandler.ChangeNotesColor(Trigger.new);
    }
    if(Trigger.isUpdate && Trigger.isbefore)
    {
        AccounTriggerHandler.UpdateOwner(Trigger.new,Trigger.oldMap);
    }
}