public class CaseriggerDetailsHandler {
    public static void GetCaseDetails(List<Case> caseList)
    {
        Map<Id,String> caseMap= new Map<Id,String>();
        List<Opportunity> oppdata = new  List<Opportunity>();
        for(Case c:caseList)
        {
            caseMap.put(c.Opportunity__c,c.Status);
        }
        List<Opportunity> opp = [select Id,Case_Details__c from Opportunity where Id=:caseMap.keyset()];
        for(Opportunity oppList:opp)
        {
            if(oppList.Case_Details__c==null)
            {
                oppList.Case_Details__c=' '+caseMap.get(oppList.Id) +' ';
            }
            else
            {
                oppList.Case_Details__c=oppList.Case_Details__c+ '; '+ ' '+caseMap.get(oppList.Id); 
            }
            oppdata.add(oppList);
        }
        update oppdata;
    }
    
}