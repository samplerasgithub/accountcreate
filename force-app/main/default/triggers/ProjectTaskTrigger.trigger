trigger ProjectTaskTrigger on Case (after insert, after delete, after Undelete, after Update) {
   
    if(Trigger.isAfter && Trigger.isInsert){
        ProjectTaskHandlerClass.triggerAfterInsert(Trigger.new);
    }
   
    if(Trigger.isAfter && Trigger.isDelete){
        ProjectTaskHandlerClass.triggerAfterDelete(Trigger.old);
    }
   
    if(Trigger.isAfter && Trigger.isUndelete){
        ProjectTaskHandlerClass.triggerAfterUndelete(Trigger.new);
    }
   
    if(Trigger.isAfter && Trigger.isUpdate){
        ProjectTaskHandlerClass.triggerAfterUpdate(Trigger.old, Trigger.new);
    }
}