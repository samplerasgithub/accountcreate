global class OpportunityBatchUpdateScheduler implements Schedulable{
    global void execute(SchedulableContext sc)
    {
        Integer batchSize=1;
OpportunityUpdateBatch oppbatch =new OpportunityUpdateBatch();
Database.executeBatch(oppbatch,batchSize);
    }

}