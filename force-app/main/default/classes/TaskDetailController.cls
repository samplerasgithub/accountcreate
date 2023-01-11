/*
             * @description: Add Edit Task Record.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022

 */
public class TaskDetailController {
    public Task taskrecords; 
   // TaskDetailController constructor is used in visualforce extension class for standard controller
public TaskDetailController(ApexPages.StandardController controller)
{ 
   this.taskrecords = (Task)controller.getRecord();
   
} 
   /*
             * @description: Edit Existing project Record from Pagereference class in Visualforce page.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  None
             * @return: null
    */ 
    public PageReference editRecord()
    {
        Update taskrecords;
        return Null;
    }
    /*
             * @description: get Task Record.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  None
             * @return: None
    */
    public void getTaskDetails()
    {
        //
      List<Case> pmList = [Select Project__r.Name, Project__r.Project_Manager__r.Name
						   from Case where Id='5005i00000EOsuAAAT'];

    System.debug('Project Name' + pmList[0].Project__r.Name + 'Project Manager Name' + pmList[0].Project__r.Project_Manager__r.Name);
    }
    public void editTask()
    {
        
    }
    /*
             * @description: Add new project Record from Pagereference class in Visualforce page.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  None
             * @return: None
    */
    public void InsertTaskDetailsInMap()
    {
       /*List<Task> taskList = new List<Task>{
            new Task (WhoId='0035i00000BhYL5AAN',Subject='Call',Status='Not Started',Priority='Normal'),
            new Task (WhoId='0035i00000BhYKhAAN',Subject='Email',Status='In Progress',Priority='Low'),
            new Task (WhoId='0035i00000BhYKXAA3',Subject='Send Letter',Status='Completed',Priority='High')
        };*/
		//Instead of hardcode using select query
       List<Task> taskList = [SELECT WhoId,Subject,Status,Priority FROM Task LIMIT 3];
        System.debug(taskList);
        // use of set
        Set<String> taskName = new Set<String>();
        for(Task tName : taskList)
        {
            taskName.add(tName.WhoId);
        }
        Map<Id,Task> mapInstance = new Map<Id,Task>();
        for(Task tNameAndInstance : taskList)
        {
            mapInstance.put(tNameAndInstance.WhoId,tNameAndInstance);
        }
       System.debug(mapInstance);
        
    }

}