//Create and update no. of contacts which is equal to number we will enter in count of contact field on account object
public class AccountTriggerCountHandler {
    //Creates the number of contacts which is equals to the number we are entering in the count of Contacts field on the Account Object
    public static void createContact(List<Account> accList)
    {
        List<Contact> contactList = new List<Contact>();
        Map<Id,Decimal> IdVsNumberofContactMap = new Map<Id,Decimal>();
        for(Account acc:accList){
            IdVsNumberofContactMap.put(acc.Id,acc.count_of_contact__c);
        }
        if(!IdVsNumberofContactMap.isEmpty()){
            for(Id accId:IdVsNumberofContactMap.keyset()){
                for(Integer i =1;i<=IdVsNumberofContactMap.get(accId);i++){
                    Contact con = new Contact();
                    con.FirstName='contact';
                    con.LastName='created'+i;
                    con.AccountId=accId;
                    contactList.add(con); 
                }
            }
        }
        if(!contactList.isEmpty()){
            insert contactList;
        }
    }
    //Update count of contacts related to account when we update count of contact field on account.
    public static void contactCountupdate(Map<Id,Account> oldMap, List<Account> accList)
    {
        List<Contact> contactListToInsert = new List<Contact>();
        List<Contact> contactListToDelete=new List<Contact>();    
        Set<Id> accountId = new Set<Id>();
        String query;
        Integer limitdynamic;
        List<Contact> contactListOld = [select Id,FirstName,LastName from Contact where AccountId=:oldMap.keyset()];
        Decimal size=contactListOld.size();
        Map<Id,Decimal> IdVsNumberofContactMap = new Map<Id,Decimal>();
        for(Account acc:accList){
            if(acc.Id.equals(oldMap.get(acc.Id).Id)){
                IdVsNumberofContactMap.put(acc.Id,acc.count_of_contact__c);
            }
        }
        if(!IdVsNumberofContactMap.isEmpty()){
            for(Id accId:IdVsNumberofContactMap.keyset()){
                if(size<IdVsNumberofContactMap.get(accId)) {
                    for(Integer i =1;i<=(IdVsNumberofContactMap.get(accId)-size);i++){
                        Contact con = new Contact();
                        con.FirstName='contact';
                        con.LastName='created';
                        con.AccountId=accId;
                        contactListToInsert.add(con);
                    }
                }
                if(size>IdVsNumberofContactMap.get(accId)) {
                    limitdynamic=Integer.valueOf(size-IdVsNumberofContactMap.get(accId));
                    accountId.add(accId);  
                } 
            } 
            if(!accountId.isEmpty()){
                query = 'select Id from Contact where AccountId =:accountId Order BY CreatedDate DESC LIMIT ' + limitdynamic;
                contactListToDelete=Database.query(query);
            }
        }
        if(!contactListToInsert.isEmpty()){
            insert contactListToInsert;
        }
        if(!contactListToDelete.isEmpty()){
            delete contactListToDelete;
        }
    }
}