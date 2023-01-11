public class WeeklySnapshotBatch implements Database.Batchable<sObject>, Database.Stateful {
    Map<Integer, Weekly_Snapshot__c> weekVsWSMap = new Map<Integer, Weekly_Snapshot__c>();  
    public database.QueryLocator start(database.BatchableContext bc) {
        string query;
        query = 'SELECT Id, Project__c, Estimated_Hours__c, Billable_Hours__c, Non_Billable_Hours__c, Due_Date__c, Completed_Date__c FROM Case WHERE Completed_Date__c = THIS_MONTH';
        return database.getQueryLocator(query);
       
    }
    public void execute(database.BatchableContext bc, list<Case> caseList) {
        for(Case caseObj : caseList) {
            Date myDate = date.newinstance(caseObj.Completed_Date__c.year(), caseObj.Completed_Date__c.month(), caseObj.Completed_Date__c.day());
            Date weekStartDate = Date.newInstance(myDate.year(), mydate.month(), 01);
            Date firstDate = myDate.toStartOfMonth();
            Date extraDaysDate = firstDate.toStartOfWeek();
            Decimal dueDays = extraDaysDate.daysBetween(firstDate) - 1;
            Decimal dayVal = (myDate.day() + dueDays)/7;
            //First Week
            if(dayVal<=1) {
                if(!weekVsWSMap.containsKey(1)) {
                   
                    weekVsWSMap.Put(1, new Weekly_Snapshot__c(Name = 'WS-'+myDate.month()+'-W1',
                                                              Estimated_Hours__c = caseObj.Estimated_Hours__c,
                                                              Billable_Hours__c = caseObj.Billable_Hours__c,
                                                              Non_Billable_Hours__c = caseObj.Non_Billable_Hours__c,
                                                              Week_Start_Date__c = (weekStartDate.toStartOfWeek()) + 1,
                                                              Week_End_Date__c = (myDate.toStartOfWeek()) +7,
                                                              Summary__c = 'First Week Summary'));
                }
                else {
                    weekVsWSMap.get(1).Estimated_Hours__c += caseObj.Estimated_Hours__c;
                    weekVsWSMap.get(1).Billable_Hours__c += caseObj.Billable_Hours__c;
                    weekVsWSMap.get(1).Non_Billable_Hours__c += caseObj.Non_Billable_Hours__c;
                   
                }
            }
            else if(dayVal<=2)  {
                if(!weekVsWSMap.containsKey(2)) {
                    weekVsWSMap.Put(2, new Weekly_Snapshot__c(Name = 'WS-'+myDate.month()+'-W2',
                                                              Estimated_Hours__c = caseObj.Estimated_Hours__c,
                                                              Billable_Hours__c = caseObj.Billable_Hours__c,
                                                              Non_Billable_Hours__c = caseObj.Non_Billable_Hours__c,
                                                              Week_Start_Date__c = (myDate.toStartOfWeek() + 1),
                                                              Week_End_Date__c = ((myDate.toStartOfWeek() + 7)) ,
                                                              Summary__c = 'Second Week Summary'));
                }
                else {
                    if((weekVsWSMap.get(2).Estimated_Hours__c != null) && (weekVsWSMap.get(2).Billable_Hours__c != null) && (weekVsWSMap.get(2).Non_Billable_Hours__c != null)) {    
                        weekVsWSMap.get(2).Estimated_Hours__c += caseObj.Estimated_Hours__c;
                        weekVsWSMap.get(2).Billable_Hours__c += caseObj.Billable_Hours__c;
                        weekVsWSMap.get(2).Non_Billable_Hours__c += caseObj.Non_Billable_Hours__c;
                    }    
                }
            }
            else if(dayVal<=3) {
                if(!weekVsWSMap.containsKey(3)) {
                   
                    weekVsWSMap.Put(3, new Weekly_Snapshot__c(Name = 'WS-'+myDate.month()+'-W3',
                                                              Estimated_Hours__c = caseObj.Estimated_Hours__c,
                                                              Billable_Hours__c = caseObj.Billable_Hours__c,
                                                              Non_Billable_Hours__c = caseObj.Non_Billable_Hours__c,
                                                              Week_Start_Date__c = (myDate.toStartOfWeek() + 1),
                                                              Week_End_Date__c = ((myDate.toStartOfWeek() + 7)),
                                                              Summary__c = 'Third Week Summary'));
                }
                else{                
                    weekVsWSMap.get(3).Estimated_Hours__c += caseObj.Estimated_Hours__c;
                    weekVsWSMap.get(3).Billable_Hours__c += caseObj.Billable_Hours__c;
                    weekVsWSMap.get(3).Non_Billable_Hours__c += caseObj.Non_Billable_Hours__c;
                }
            }
            else if(dayVal<=4){
                if(!weekVsWSMap.containsKey(4)){
                   
                    weekVsWSMap.Put(4, new Weekly_Snapshot__c(Name = 'WS-'+myDate.month()+'-W4',
                                                              Estimated_Hours__c = caseObj.Estimated_Hours__c,
                                                              Billable_Hours__c = caseObj.Billable_Hours__c,
                                                              Non_Billable_Hours__c = caseObj.Non_Billable_Hours__c,
                                                              Week_Start_Date__c = (myDate.toStartOfWeek() + 1),
                                                              Week_End_Date__c = ((myDate.toStartOfWeek() + 7)),
                                                              Summary__c = 'Fourth Week Summary'));
                }
                else{
                    weekVsWSMap.get(4).Estimated_Hours__c += caseObj.Estimated_Hours__c;
                    weekVsWSMap.get(4).Billable_Hours__c += caseObj.Billable_Hours__c;
                    weekVsWSMap.get(4).Non_Billable_Hours__c += caseObj.Non_Billable_Hours__c;
                }
            }
            else{
                if(!weekVsWSMap.containsKey(5)){
                   
                    weekVsWSMap.Put(5, new Weekly_Snapshot__c(Name = 'WS-'+myDate.month()+'-W5',
                                                              Estimated_Hours__c = caseObj.Estimated_Hours__c,
                                                              Billable_Hours__c = caseObj.Billable_Hours__c,
                                                              Non_Billable_Hours__c = caseObj.Non_Billable_Hours__c,
                                                              Week_Start_Date__c = (myDate.toStartOfWeek() + 1),
                                                              Week_End_Date__c = Date.newInstance(myDate.Year(), myDate.month(),Date.daysInMonth(myDate.Year(), myDate.month())),
                                                              Summary__c = 'Fifth Week Summary'));
                }
                else{
                    weekVsWSMap.get(5).Estimated_Hours__c += caseObj.Estimated_Hours__c;
                    weekVsWSMap.get(5).Billable_Hours__c += caseObj.Billable_Hours__c;
                    weekVsWSMap.get(5).Non_Billable_Hours__c += caseObj.Non_Billable_Hours__c;  
                }
            }
        }
        System.debug('MAP---'+weekVsWSMap);
    }
    public void finish(database.BatchableContext bc){
        insert weekVsWSMap.values();
    }
}