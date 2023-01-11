public class DynamicTableController123 {
    
    public String SelectedObject {get; set;}
    public List<SelectOption> fieldLableAPI {get; set;}
    public List<selectoption> supportedObject {get; set;}
    public List<String> SelectedFields {get; set;}
    public List<sObject> ObjectList {get; set;}
  //  public List<SelectOption> limitLst {get;set;}
    public String selectedLimit {get;set;}
    public List<sObject> queryList{get;set;}
    public String querydemo {get;set;}
    
   /* public List<sObject> queryListData{get;set;}
    public String querydemoData {get;set;}
    public List<sObject> recordData {get; set;}*/
    public PageReference test() {
        return null;
    }
    public void FetchQuery()
    {
        querydemo= 'SELECT '+SelectedFields+' FROM '+SelectedObject+' LIMIT '+selectedLimit; 
        querydemo = querydemo.replaceAll('[\\[\\](){}]', '');
        System.debug('query'+querydemo);
        
    }
    
    public void executeQuery()
    {
        /*querydemoData= 'SELECT '+SelectedFields+' from '+SelectedObject+' LIMIT '+selectedLimit; 
querydemoData = querydemoData.replaceAll('[\\[\\](){}]', '');
System.debug('query'+querydemoData);*/
        queryList = Database.query(querydemo);
        System.debug('sobjList'+queryList);
        
    }
    public DynamicTableController123 ()
    {
        //Initialize
        supportedObject = new List<selectoption>() ;
        SelectedObject = '' ;
        fieldLableAPI = new List<SelectOption>() ;
        SelectedFields = new List<String>() ;
        ObjectList = new List<sObject>() ;
        //Get only reference to objects
        for(Schema.SObjectType item : ProcessInstance.TargetObjectId.getDescribe().getReferenceTo())
        {
            //Excluding custom setting objects
            if(!item.getDescribe().CustomSetting)
            {
                //Adding to list
                supportedObject.add(new SelectOption(item.getDescribe().getLocalName().toLowerCase() , item.getDescribe().getLabel() ));
            }
        }
        
    }
    Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
    Set<String> objectKeys = gd.keySet();
    public void ObjectFields()
    {
        if(SelectedObject != '--None--')
        {
            //Creating sObject for dynamic selected object
            Schema.SObjectType systemObjectType = gd.get(SelectedObject);
            //Fetching field results
            Schema.DescribeSObjectResult r = systemObjectType.getDescribe();
            
            Map<String, Schema.SObjectField> M = r.fields.getMap();
            //Creating picklist of fields
            for(Schema.SObjectField fieldAPI : M.values())
            {
                
                fieldLableAPI.add(new SelectOption(fieldAPI.getDescribe().getName() , fieldAPI.getDescribe().getLabel())) ;
            }
            fieldLableAPI.sort();
            
        }
        
        
    }
    
}