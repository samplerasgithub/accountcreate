public class SearchData {
    public void getSearchResults(String searchTerm)
    {
 
        List<List<sObject>> searchResultList = [FIND :searchTerm IN ALL FIELDS RETURNING Account(Id,Name),Contact(Id,Name)];
		List<Account> accountList = searchResultList[0];
		List<Contact> contactList = searchResultList[1];
        for(Account accountDataList :accountList)
        {
            System.debug('Account List :'+accountDataList);            
        }
		for(Contact contactDataList :contactList)
        {
            
            System.debug('Contact List :'+contactDataList);  
            //System.debug('Contact List :'+contactDataList.FirstName);
        }
    }

}