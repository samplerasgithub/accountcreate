public with sharing class FirstLWCController {
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> GetAllOpportunity(){
        return [select Id,Name,CloseDate,StageName from Opportunity];
    }
}