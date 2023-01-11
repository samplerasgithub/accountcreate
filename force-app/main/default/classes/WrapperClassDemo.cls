public class WrapperClassDemo {
    
    Map<Id,MyClass> mp = new Map<Id,MyClass>(); 
    
    public class MyClass
    {
        List<Account> accList;
        List<Contact> conList;
         public MyClass(List<Account> accountList,List<Contact> conDataList)
              {
                  accList = accountList;
                  conList = conDataList;
              }
    }
}