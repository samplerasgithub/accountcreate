public class TestDemo {
    public static void Test()
    {
        List<Account> my_List= [select Id, Name from Account limit 3];
        System.debug('Before'+my_List);
         List<Account> my_List2=  Test2(my_List);

         System.debug('After1'+my_List);
        List<Account> acc3=new List<Account>{
            
        };   
        
        
        for(Account adata : my_List2)
        {
            adata.Name='Sudeep View';
        }
              
        System.debug('After2'+my_List);
        System.debug('After3'+ my_List2);
    }
     public static List<Account> Test2(List<Account> contact_List)
    {
       
        for(Account conObj : contact_List)
        {
            conObj.Name='Sudeep Review';
        }
        return contact_List;
    }
	
}