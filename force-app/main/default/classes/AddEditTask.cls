/*
             * @description: Add Edit Task Record.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022

 */
public class AddEditTask {
     private final Case caseData;
    /*
             * @description: Add new Task Record .
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  List of project task object
             * @return: void
    */
    public void saveTask(List<Task> taskobj)
    {
        try
        {
        insert taskobj;
        System.debug(taskobj);
        System.debug('Data Added Sucessfully');
        }
        catch(DMLException e)
        {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
           
    }
    // addedittask constructor is used in visualforce extension class for standard controller
    public AddEditTask(ApexPages.StandardController s)
    {
        this.caseData = (Case)s.getRecord();
    }
    /*
             * @description: Add new Task Record from Pagereference class in Visualforce page.
             * @author: Rasika Jadhav
             * @date: 2-09-2022
             * @revised: 16-09-2022
             * @param:  None
             * @return: null
    */
    public PageReference saveRecord()
    {
        upsert caseData;
        System.debug('Record Saved');
        return null;
    }
}