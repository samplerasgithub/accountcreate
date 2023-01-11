/*
             * @description: trigger to compute sum of Billable hours, non billable hours of Project Task object to project’s total billable hours, total non billable hours fields.
             * @author: Rasika Jadhav
             * @date: 12-09-2022
             * @revised: 22-09-2022

 */
public with sharing class ProjectTaskHandlerClass {
   
    // ProjectTaskHandlerClass constructor.
    public ProjectTaskHandlerClass(){
       
    }
   
    // Method for AfterInsert Trigger on ProjectTaskTrigger
    public static void triggerAfterInsert(List<Case> afterInsertList){
       
        // Map for storing Project object Id and ProjectTask(Case) record list.
        Map<Id, List<Case>> idVsCaseMap = new Map<Id, List<Case>>();
       
        // Iterating caseRecordList (Trigger.new List).
        for(Case caseObj : afterInsertList){
            if(!idVsCaseMap.containsKey(caseObj.Project__c)){
                idVsCaseMap.put(caseObj.Project__c, new List<Case>{caseObj});
            }
            else{
                idVsCaseMap.get(caseObj.Project__c).add(caseObj);
            }
        }
       
        // List of Project Object with same Id present in 'Map<Id, List<Case>> idVsCaseMap' Id.
        List<Project__c> projectList = [select Billable_Hours__c, Non_Billable_Hours__c,(select Billable_Hours__c, Non_Billable_Hours__c
                                                                                         from Project_Task__r)
                                        from Project__c
                                        where Project__c.Id =: idVsCaseMap.keySet()];        
       
        for(Project__c projectObj : projectList){
            Decimal Total_Billable_Hours = 0;
            Decimal Total_Non_Billable_Hours = 0;
            for(Case caseObject : projectObj.Project_Task__r){
                Total_Billable_Hours = Total_Billable_Hours + caseObject.Billable_Hours__c;
                Total_Non_Billable_Hours = Total_Non_Billable_Hours + caseObject.Non_Billable_Hours__c;
            }
           
            projectObj.Billable_Hours__c = Total_Billable_Hours;
            projectObj.Non_Billable_Hours__c = Total_Non_Billable_Hours;
        }
        update projectList;
    }
   
   
    // Method for After Delete Trigger on Project Task Trigger.
    public static void triggerAfterDelete(List<Case> caseAfterDeleteList){
        Map<Id, List<Case>> idVsProjectTaskMap = new Map<Id, List<Case>>();
       
        for(Case projectTaskObj : caseAfterDeleteList){
            if(!idVsProjectTaskMap.containsKey(projectTaskObj.Project__c)){
                idVsProjectTaskMap.put(projectTaskObj.Project__c, new List<Case>{projectTaskObj});
            }
            else{
                idVsProjectTaskMap.get(projectTaskObj.Project__c).add(projectTaskObj);
            }
        }
       
        List<Project__c> projectList = [select Billable_Hours__c, Non_Billable_Hours__c, (select Non_Billable_Hours__c, Billable_Hours__c
                                                                                          from Project_Task__r)
                                        from Project__c
                                        where Project__c.Id =: idVsProjectTaskMap.keySet()];
       
        for(Project__c projectObj : projectList){
            Decimal Total_Billable_Hours = 0;
            Decimal Total_Non_Billable_Hours = 0;
            for(Case caseObj : projectObj.Project_Task__r){
                Total_Billable_Hours = Total_Billable_Hours + caseObj.Billable_Hours__c;
            Total_Non_Billable_Hours = Total_Non_Billable_Hours + caseObj.Non_Billable_Hours__c;
            }
            projectObj.Billable_Hours__c = Total_Billable_Hours;
            projectObj.Non_Billable_Hours__c = Total_Non_Billable_Hours;
        }
        update projectList;
    }
   
    //Method for undelete
   
    public static void triggerAfterUndelete(List<Case> caseAfterUndeleteList){
        Map<Id, List<Case>> idVsCaseMap = new Map<Id, List<Case>>();
        for(Case caseObj : caseAfterUndeleteList){
            if(!idVsCaseMap.containsKey(caseObj.Project__c)){
                idVsCaseMap.put(caseObj.Project__c, new List<Case>{caseObj});
            }
            else{
                idVsCaseMap.get(caseObj.Project__c).add(caseObj);
            }
        }
       
        List<Project__c> projectList = [select Billable_Hours__c, Non_Billable_Hours__c, (select Non_Billable_Hours__c, Billable_Hours__c
                                                                                          from Project_Task__r)
                                        from Project__c
                                        where Project__c.ID =: idVsCaseMap.keySet()];
        for(Project__c projectObj : projectList){
            Decimal Total_Billable_Hours = 0;
            Decimal Total_Non_Billable_Hours = 0;
            for(Case caseObj : projectObj.Project_Task__r){
                Total_Billable_Hours = Total_Billable_Hours + caseObj.Billable_Hours__c;
                Total_Non_Billable_Hours = Total_Non_Billable_Hours + caseObj.Non_Billable_Hours__c;
            }
            projectObj.Billable_Hours__C = Total_Billable_Hours;
            projectObj.Non_Billable_Hours__c = Total_Non_Billable_Hours;
        }
        update projectList;
    }
   
    // method for update
    public static void triggerAfterUpdate(List<Case> caseBeforeUpdateList, List<Case> caseAfterUpdateList){
        Map<Id, List<Case>> idVsCaseMap = new Map<Id, List<Case>>();
        for(Case caseObj : caseAfterUpdateList){
             if(caseBeforeUpdateList.contains(caseObj)){
                if(!idVsCaseMap.containsKey(caseObj.Project__c)){
                    idVsCaseMap.put(caseObj.Project__c,new List<Case>{caseObj});
                }
                else if(idVsCaseMap.containsKey(caseObj.Project__c)){
                    idVsCaseMap.get(caseObj.Project__c).add(caseObj);
                }
              }
              else if(!caseBeforeUpdateList.contains(caseObj)){
            if(!idVsCaseMap.containsKey(caseObj.Project__c)){
                  idVsCaseMap.put(caseObj.Project__c,new List<Case>{caseObj});
                     for(Case caseiter : caseBeforeUpdateList){
                      idVsCaseMap.put(caseiter.Project__c,new List<Case>{caseiter});
                     }
                 }
              }
                else if(idVsCaseMap.containsKey(caseObj.Project__c)){
                idVsCaseMap.get(caseObj.Project__c).add(caseObj);
                     for(Case caseiter : caseBeforeUpdateList){
                        idVsCaseMap.get(caseiter.Project__c).add(caseiter);
                     }
                }
             }            
           
            ///////
            List<Project__c> ProjectList = [Select Billable_Hours__c,Non_Billable_Hours__c,(SELECT Id, Billable_Hours__c,Non_Billable_Hours__c
                                                                                        FROM Project_Task__r)
                                        FROM Project__c
                                        WHERE Project__c.id =: idVsCaseMap.keyset()];
        for(Project__c proj : ProjectList){
                Case caseobj = new Case();
                Decimal Total_Billable_Hours = 0;
                Decimal Total_Non_Billable_Hours = 0;
                for(Case caseiter : proj.Project_Task__r ){
                    Total_Billable_Hours = Total_Billable_Hours + caseiter.Billable_Hours__c;
                    Total_Non_Billable_Hours =Total_Non_Billable_Hours + caseiter.Non_Billable_Hours__c;
                    }
            proj.Billable_Hours__c = Total_Billable_Hours;
            proj.Non_Billable_Hours__c = Total_Non_Billable_Hours;
        }
          update ProjectList;
     }          
}