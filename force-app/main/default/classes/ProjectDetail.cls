/*
             * @description: Add Edit ProjectDetail Record.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022

 */
global class ProjectDetail {
     Integer count =0;
    public boolean displayInputText{get;set;}
    public Project__c projectinfo{get; set;} 
    public String statusName{get;set;}
    public List<Case> caseRecordName{get;set;}
    public Project__c records {get; set;} 
    public List<Task> taskList{get; set;}
    // ProjectDetail constructor is used in visualforce extension class for standard controller
public ProjectDetail(ApexPages.StandardController controller)
{ 
    
	this.records = (Project__c)controller.getRecord();
   this.taskList= getTasks(records.id);
    projectinfo = [SELECT Id,Is_Active__c,Client__r.BillingCity ,Client__r.BillingState,Client__r.BillingPostalCode, Client__r.BillingCountry 
                  from Project__c
                  where Id=:records.Id];
displayInputText= projectinfo.Is_Active__c;   
} 
/*
             * @description: Get Project Record of particular id.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  Id of  project
             * @return: null
    */
		public void getProjectDetails(Id id)
        {
            System.debug(id);
            List<Project__c> projectList = [SELECT Name from Project__c where Id=:id];
            for(Project__c data :projectList)
            {
				     System.debug(data.Name);           
            }
        }
    /*
             * @description: Get Task Record related to project from org.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  task record Id
             * @return: List of Task
    */
    	public List<Task> getTasks(Id taskid)
        {
            //projectid
            List<Task> getTaskData = [SELECT WhatId,Subject,Status,Priority from Task where WhatId=:taskid];
            for(Task taskdetails : getTaskData)
            {
                System.debug(taskdetails);
            }
            
            return getTaskData;
        }
    	public void editProject()
        {
            
        }
    /*
             * @description: Edit Existing project Record from Pagereference class in Visualforce page.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  None
             * @return: null
    */
    public PageReference editrecord()
    {
        upsert records;
        displayInputText= records.Is_Active__c;  
        System.debug('record updated');
        return null;
    }
    @RemoteAction
    global static List<Case> getCase(String statusName)
    {
       
        List<Case> caseData = new List<case>();
        caseData = [SELECT Id,Subject,Status,Priority from Case where Status =:statusName];
        System.debug(caseData);
      	return caseData;
    }
    public Integer getCount()
    {
        return count;
    }
    public PageReference incrementCounter()
    {
        count++;
        return null;
    }
}