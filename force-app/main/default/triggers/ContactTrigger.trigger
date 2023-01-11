trigger ContactTrigger on Contact (after insert) {
ContactTriggerHandler.insertContact(Trigger.new);
}