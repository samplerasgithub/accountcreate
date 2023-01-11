trigger CaseTrigger on Case (before insert) {
    CaseTriggerHandler.before(Trigger.new);

}