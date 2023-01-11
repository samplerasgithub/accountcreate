public class CaseBatchExSchedular implements schedulable{
    public void execute(SchedulableContext sc)
    {
        CaseBatchEx obj = new CaseBatchEx();
        Database.executeBatch(obj);
    }

}