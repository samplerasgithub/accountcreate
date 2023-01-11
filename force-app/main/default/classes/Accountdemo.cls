public class Accountdemo {
    public Map<Id,Contact> conMap{get;set;}
    public List<Contact> conList{get;set;}
    public User Owner{get;set;}
    public Account acc{get;set;}
    Id accId;
   
        public Accountdemo(ApexPages.StandardController s)
    {
     accId = ApexPages.currentPage().getParameters().get('id');
      conMap =  new Map<Id,Contact>([SELECT FirstName,LastName 
                 From Contact 
                 where AccountId =:accId]);
        
    }
      public PageReference userInfo()
      {
        Owner = [Select FirstName,LastName,Email,Manager.Name from User where Id =:accId];
          return null;
      }

}