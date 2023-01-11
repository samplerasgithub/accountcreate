@isTest
public class CaseBatchExTest {
    @isTest
    public static void startTest()
    {
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=1;i<=3;i++)
        {
            oppList.add(new Opportunity(Name='Test'+i,StageName='Prospecting', CloseDate=System.today()));
        }
        insert oppList;
        Test.startTest();
		CaseBatchEx obj= new CaseBatchEx();
        Database.executeBatch(obj);
        Test.stopTest();
        
        List<Opportunity> opp=[SELECT Id from Opportunity where CloseDate=today];
        System.assertEquals(3, opp.size());
    }

}