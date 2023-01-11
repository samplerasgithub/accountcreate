public with sharing class ReportController {
public list<SelectOption> objectList {get; private set;}
    public String selectedObject {get; set;}
    public ReportController(){
        objectList = new list<SelectOption>();
        
        Schema.Sobjecttype objSFDCObject;
        //Retreive a Map of all SFDC Object Tokens and SFDC Objects from the Org
        Map<String, Schema.Sobjecttype> globalDescribeMap = Schema.getGlobalDescribe();
        for(String strKey : globalDescribeMap.keySet()) {
               objSFDCObject = GlobalDescribeMap.get(strKey);
            if(objectList.size() < 1000){
		objectList.add(
                               new Selectoption(objSFDCObject.getDescribe().getName(),
                                                objSFDCObject.getDescribe().getName() + ' (' +
                                                objSFDCObject.getDescribe().getLabel() + ')'));
		
	}
            else
            {
                System.debug('Size Exceeds');
            }
               
            
        }
    }
}