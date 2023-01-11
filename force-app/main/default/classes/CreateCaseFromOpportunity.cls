public with sharing class CreateCaseFromOpportunity {
  @InvocableMethod(label='get opportunity record' description ='get opportunity record' category='Opportunity')
    public static  List<Opportunity> getopportunityrecord(List<String> oppname)
    {
	  List<Opportunity> opportunityList = [SELECT Id,Name from Opportunity where Name =:oppname];
        return opportunityList;
    }
   

}