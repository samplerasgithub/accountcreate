/*
             * @description: Add Edit Project Record.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022

 */
public class AddEditProject {
     private final Project__c projectData;
    public List<Project__c> projectrecord {get; set;}
    /*
             * @description: Add new Project Record .
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  List of project  object
             * @return: void
    */
	public void saveProject(List<Project__c> addProject)
    {
        insert addProject;
        System.debug(addProject);
        System.debug('Project Added Successfully');
    }
    // AddEditProject constructor is used in visualforce extension class for standard controller
      public AddEditProject(ApexPages.StandardController s)
    {
        this.projectData = (Project__c)s.getRecord();
       projectrecord = [Select Name,Project_Manager__c,Client__c,Allocated_Hours__c,Estimated_Hours__c,
                     Billable_Hours__c,Non_Billable_Hours__c,Billing_Per_Hour__c,Total_Billing__c from Project__c ]; 
        
    }
     /*
             * @description: Add/Edit new Project Record from Pagereference class in Visualforce page.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  None
             * @return: null
    */
    public PageReference saveRecord()
    {
        
        upsert projectData;
        System.debug('Record Saved');
        return null;
    }
     /*
             * @description: Navigate to one visualforce page from another visualforce page and save record.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  None
             * @return: null
    */
    public PageReference demo()
    {
        
        PageReference ProjectListPage = Page.AddEditProjectPage;
		ProjectListPage.setRedirect(false);
		return ProjectListPage;
        
    }
}