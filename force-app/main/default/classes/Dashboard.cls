/*
             * @description: Add Edit Task Record.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022

 */
public class Dashboard {
  
         public List<Task> taskrecords {get; set;} 
    // Dashboard constructor is used in visualforce extension class for standard controller
public Dashboard(ApexPages.StandardController controller)
{ 
    
taskrecords = [Select Subject,Status,Priority,ActivityDate FROM Task where ActivityDate=TODAY]; 
} 
    /*
             * @description: get Task Record where due date is today and user is present.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  User Id
             * @return: None
    */  
    public void getTodaysTasks(Id id)
    {
        //instead of id use ownerid
        //0055i000004hiLnAAI
        List<Task> todaystask = [SELECT Subject,Status,Priority FROM Task where OwnerId=:id AND CreatedDate=TODAY];
        for(Task todaysTaskList:todaystask)
            {
                System.debug(todaysTaskList);
                //System.debug('Data');
            }       
    }
	public void editTask()
    {
        
    }
}