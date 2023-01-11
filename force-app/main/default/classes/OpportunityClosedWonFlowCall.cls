public class OpportunityClosedWonFlowCall {
    public static void callFlow() {
        List<Opportunity> oppList =[select Id from Opportunity where StageName=:'Closed Won' limit 3];
        Set<Id> oppId =new Set<id>();
        for(Opportunity opp: oppList)
        {//https://blueflamelabspvtltd59-dev-ed.my.salesforce.com/_ui/common/apex/debug/ApexCSIPage#
            oppId.add(opp.Id);
        }
        System.debug('oppId'+oppId);
        Map<String, Object> StringVsOpportunityMap  = new Map<String, Object>();
        for(Id opp:oppId)
        {
            StringVsOpportunityMap .put('OpportunityId',opp);
            Flow.Interview.OpportunityClosedWon_Send_Email_To_User stage = new Flow.Interview.OpportunityClosedWon_Send_Email_To_User(StringVsOpportunityMap );
            stage.start();
            system.debug('stage::: '+stage);
            string stageName=(string)stage.getvariableValue('oppStage');
            system.debug('stageName::: '+stageName);
        }
        
    }  
}