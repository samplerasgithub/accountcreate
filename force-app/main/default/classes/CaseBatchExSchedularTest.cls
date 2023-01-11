@isTest
global class CaseBatchExSchedularTest {
    @isTest
    global static void executeTest()
    {
        
        Test.startTest();
        Opportunity opp= new Opportunity(Name='Test',StageName='Prospecting', CloseDate=System.today());
        insert opp;
        CaseBatchExSchedular obj1 = new CaseBatchExSchedular();
        String cronExp = '0 0 12 * * ?';
        String jobID = System.schedule('case created related to opportunity', cronExp, obj1);
        CronTrigger ct = [SELECT Id, CronExpression FROM CronTrigger WHERE id = :jobID];
        Test.stopTest();
        System.assertEquals(cronExp, ct.CronExpression);
       
    }
    
}