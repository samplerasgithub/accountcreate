/*
             * @description: Add Edit ProjectDetail Record.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022

 */
public class ProjectList {
      /*
             * @description: get project Record.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  Id
             * @return: None
    */ 
    public void getProjects(Id id)
    {
        //member id
        //user which is member of project
       List<Project_Member__c> getProject = [SELECT Member__r.Name,Project__r.Name from Project_Member__c where Member__r.Id=:id];
        for(Project_Member__c projectData :getProject )
        {
			System.debug(projectData.Member__r.Name); 
            System.debug(projectData.Project__r.Name);
        }
        System.debug('Data Fetch Sucessfully');
        
    }
      /*
             * @description: Add new project Record.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  None
             * @return: None
    */ 
    public void addProject()
    {
   		//Add project
        List<Project__c> addProject = new List<Project__c>{
           new Project__c(Name ='SOQL Project1')
       };
            insert addProject;
        	System.debug(addProject);
        	System.debug('Project Added Sucessfully');
            
    }
      /*
             * @description: Delete Existing project Record from Pagereference class in Visualforce page.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  Project Id
             * @return: None
    */ 
    public void deleteProject(Id id)
    {
        //Delete Project
        List<Project__c> deleteproject = [SELECT Name from Project__c where Id=:id];
        DELETE deleteproject;
        System.debug(deleteproject);
        System.debug('Data deleted Sucessfully');
        
    }
    public void editProject()
    {
        
    }

}