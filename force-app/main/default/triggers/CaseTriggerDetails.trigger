trigger CaseTriggerDetails on Case (after insert) {
    if(Trigger.isInsert && Trigger.isAfter)
    {
    CaseriggerDetailsHandler.GetCaseDetails(Trigger.new);
    }

}