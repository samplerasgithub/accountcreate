trigger AccountCountTrigger on Account (after insert) {
    if(Trigger.isInsert && Trigger.isAfter)
    {
        AccountCountHandler.getCasesCount(Trigger.new);
    }

}