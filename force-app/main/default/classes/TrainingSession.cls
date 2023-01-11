public class TrainingSession {
   // System.debug('Hi world');
    public void addAccounts()
    {
        List<Account> accList = new List<Account>();
    	Account acc = new Account();
    	acc.Name='BFL';
        accList.add(acc);
        Account acc2 = new Account(Name = 'BFL2');
        
    	
        accList.add(acc2);
        for(Account accobj:accList)
        {
            System.debug(accobj.Name);
            
        }
        insert accList;
    }
}