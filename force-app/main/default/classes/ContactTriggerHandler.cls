public class ContactTriggerHandler {
    public static void insertContact(List<Contact> contactList)
    {
        Boolean Chk;
        List<Id> accList = new List<Id>();
        for(Contact conobj:contactList)
        {
            if(conobj.AccountId!=null)
            {
                accList.add(conobj.AccountId);
            }
        }
        List<Account> acc= [SELECT ID,Contact_created__c from Account where Id=:accList];
        System.debug('acc'+acc);
        for(Account accobj:acc)
        {
            accobj.Contact_created__c=true;
        }
        
    }
    
}