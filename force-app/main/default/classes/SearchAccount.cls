global class SearchAccount {
    
 @RemoteAction
    global static Account getAccount(String accountName)
  {
      Account acc = [SELECT Name, Id, NumberOfEmployees, Phone 
                     from Account  
                     where Name =: accountName];
      return acc;
     
  }
    
        
    

}