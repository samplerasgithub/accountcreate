public class OpportunityRelatedCase {
    @InvocableMethod(label='get case record related to opportunity' description ='get case record related to opportunity' category='Case')
public static List<List<Case>> getCaseRelatedToOpportunity(List<ID> opportunityid)
    {
       List<Case> caseList =[SELECT RecordTypeId from Case where Opportunity__c=:opportunityid];
        List<List<Case>> caseitemlist = new  List<List<Case>>();
       caseitemlist.add(caseList);
        return caseitemlist;
        
    }
}