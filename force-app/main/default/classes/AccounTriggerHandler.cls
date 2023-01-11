public class AccounTriggerHandler {
    public static void ChangeNotesColor(List<Account> accList)
    {
        String profileName = [select Name from profile where id = :UserInfo.getProfileId()].Name;
        System.debug('profilename'+profileName);
        for(Account accobj:accList)
        {
            if(accobj.Notes__c!=NULL && profileName.equals('System Administrator'))
            {
                accobj.Notes__c= '<div style="color:blue;">'+ accobj.Notes__c.stripHtmlTags() +'</div>';
                System.debug('accobj.Notes__c'+accobj.Notes__c);
            }
            else if(profileName.equals('Standard User') && accobj.Notes__c!=NULL)
            {
                accobj.Notes__c='<div style="color:green;">'+ accobj.Notes__c.stripHtmlTags() +'</div>';
                System.debug('accobj.Notes__c'+accobj.Notes__c);
            }
            else
            {
                accobj.Notes__c='<div style="color:black;">'+ accobj.Notes__c.stripHtmlTags() +'</div>';
                System.debug('accobj.Notes__c'+accobj.Notes__c);
            }
        }
    }
    
    //Update notes
    public static void UpdateOwner(List<Account> newaccList,Map<Id,Account> oldMap)
    {
        System.debug('newaccList'+newaccList);
        System.debug('oldMap'+oldMap);
        List<Account> accid=new List<Account>();
        Set<Id> accownerId=new Set<Id>();
        for(Account accobj:newaccList)
        {
            if(accobj.Notes__c!=oldMap.get(accobj.Id).Notes__c)
            {
                accid.add(accobj); 
            }
        }
        System.debug('Changed account owner'+accid);

        String profileName = [select Name from profile where id = :UserInfo.getProfileId()].Name;
        System.debug('profilename'+profileName);
        for(Account acc:accid)
        {
            if(profileName.equals('System Administrator'))
            {
                String note=oldMap.get(acc.Id).Notes__c.stripHtmlTags();
                System.debug('old'+note);
                System.debug('new'+acc.Notes__c);
                String newnote=acc.Notes__c.stripHtmlTags();
                String replaceString=newnote.remove(note);
                System.debug(replaceString);
                acc.Notes__c= oldMap.get(acc.Id).Notes__c+'<div style="color:blue;">'+ replaceString.stripHtmlTags() +'</div>';
                System.debug('acc.Notes__c'+acc.Notes__c);
                
            }
            else if(profileName.equals('Standard User'))
            {
                String note=oldMap.get(acc.Id).Notes__c.stripHtmlTags();
                System.debug('old'+note);
                System.debug('new'+acc.Notes__c);
                String newnote=acc.Notes__c.stripHtmlTags();
                String replaceString=newnote.remove(note);
                System.debug(replaceString);
                acc.Notes__c= oldMap.get(acc.Id).Notes__c+'<div style="color:green;">'+ replaceString.stripHtmlTags() +'</div>';
                System.debug('acc.Notes__c'+acc.Notes__c);
                
            }
            else
            {
                 String note=oldMap.get(acc.Id).Notes__c.stripHtmlTags();
                System.debug('old'+note);
                System.debug('new'+acc.Notes__c);
                String newnote=acc.Notes__c.stripHtmlTags();
                String replaceString=newnote.remove(note);
                System.debug(replaceString);
                acc.Notes__c= oldMap.get(acc.Id).Notes__c+'<div style="color:black;">'+ replaceString.stripHtmlTags() +'</div>';
                System.debug('acc.Notes__c'+acc.Notes__c);
            }
            
        }
        
    }
    
}