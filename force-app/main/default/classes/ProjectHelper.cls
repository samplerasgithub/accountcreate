/*
             * @description: Project Helper class to get getMember Details and total sales.
             * @author: Rasika Jadhav
             * @date: 7-09-2022
             * @revised: 22-09-2022

 */
public class ProjectHelper {
    public virtual class CustomException extends Exception{
        
    }
    /*
             * @description: Get member details and if there is no project with matching name or multiple matching project names,
				generate Exception.
             * @author: Rasika Jadhav
             * @date: 7-09-2022
             * @revised: 22-09-2022
             * @param:  projectname
             * @return: List of project member
    */
 public List<Project_Member__c> getMember(String projectname)
    {
  List<Project__c> projectList = [SELECT Name,
                                  (SELECT Member__r.Id,Member__r.Name from Project_Members__r where Member__r.IsActive =: true)
                                  from Project__c where Name=:projectname];
        List<Project_Member__c> projectMemberList = new List<Project_Member__c>();
        try
        {
              if(projectList.size()==1){
      			 for(Project__c memberdata : projectList)
        			{
            			for(Project_Member__c pm : memberdata.Project_Members__r)
            				{
                                System.debug('Project Name :' + memberdata.Name);
                                System.debug('Member Name :'+pm.Member__r.Name);
                                System.debug('Member ID :'+pm.Member__r.Id);
            				}
			
           
        			}
                  
                 //return projectMemberList; 

    		}
            else{
                throw new CustomException();
            }
        }
        catch(CustomException e)
        {
                System.debug(e);
            }
        return projectMemberList;
    }
     /*
             * @description: Get member details according to member ID.
             * @author: Rasika Jadhav
             * @date: 7-09-2022
             * @revised: 22-09-2022
             * @param:  Member Id
             * @return: List of project member
    */
    public Project_Member__c getMemberDetails(Id memberid)
    {
       Project_Member__c memberList = [SELECT Name, Id,Project__r.Name
                             			from Project_Member__c 
                             			where Id=:memberid]; 
        return memberList;
    }
     /*
             * @description: function to get Total Sales.
             * @author: Rasika Jadhav
             * @date: 7-09-2022
             * @revised: 22-09-2022
             * @param:  startDate and endDate
             * @return: AggregateResult
    */

    public AggregateResult[] getSales(Date startDate,Date endDate)
    {
        AggregateResult[] groupedResults = [SELECT SUM(Amount)totalSales,Owner.Name 
                                            FROM Opportunity 
                                            where CloseDate>=:startDate 
                                            AND CloseDate<=:endDate 
                                            GROUP BY Owner.Name];
		return groupedResults; 	
}
    
}