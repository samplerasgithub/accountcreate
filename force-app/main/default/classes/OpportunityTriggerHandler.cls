public class OpportunityTriggerHandler {
    public static void beforeInsertOpportunity(List<Opportunity> OpportunityList)
    {
        Map<Id,String> mapdemo = new  Map<Id,String>();
        //List<String> OppSet = new List<String>();
        for(Opportunity opp : OpportunityList){
            mapdemo.put(opp.AccountId,opp.Name);
        }
        //System.debug('OppSet'+OppSet);
        List<Opportunity> oppexist = [SELECT Name 
                                      FROM Opportunity 
                                      WHERE Name IN :mapdemo.values() AND AccountId=:mapdemo.keySet()]; 
        
        System.debug('oppexist'+ oppexist);
        system.debug('count'+oppexist.size());
        Map<opportunity,String> existMap = new Map<opportunity,String>();
        for(Opportunity opp:oppexist)
        {
            existMap.put(opp,opp.Name);
        }
        System.debug('existing record'+existMap);
        
        //Getting account Id of opportunity
        //
        Map<Id,Id> newMap= new  Map<Id,Id>();
        for(Opportunity Opp: OpportunityList)
        {
            if(opp.AccountId!=NULL)
            {
                newMap.put(Opp.AccountId,null);
            }
        }
        //Owner Id and Account Id
        List<Account> ownerList =[SELECT OwnerId from Account where Id =:newMap.keyset()];
        for(Account key:ownerList)
        {
            
            newMap.put(key.Id,key.OwnerId);
        }
        System.debug('ownerid'+newMap);
        List<Messaging.SingleEmailMessage> mails= new  List<Messaging.SingleEmailMessage>(); 
        String body;
        
        for(Opportunity opplist:OpportunityList)
        {
            System.debug('old name'+opplist);
            System.debug('name'+existMap.values());
            //opplist.Name;           
            if(existMap.values().contains(opplist.Name) && oppexist.size()!=0)
            {
                
                opplist.addError('This Opportunity already exist');
            }
            else if(!existMap.values().contains(opplist.Name) && oppexist.size()!=0)
            {
                Messaging.SingleEmailMessage mail = new  Messaging.SingleEmailMessage();
                mail.setTargetObjectId(newMap.get(opplist.AccountId));
                mail.setSaveAsActivity(false);
                mail.setSubject('Opportunity is created');
                body='Opportunity is created.';
                body +='<br><br>Opportunity Id: ' + opplist.Id + ' , ';
                body +='Related Account Id: ' + opplist.AccountId +' , ';
                body +=' <br><br>Opportunity Name: ' + opplist.Name + ' , ';
                body +=' <br><br>Opportunity Close Date: ' +opplist.CloseDate + ' , ';
                body +=' <br><br>Opportunity StageName: ' + opplist.StageName + ' . ';
                body +=' <br><br>';
                mail.setHtmlBody(body);
                System.debug('Opportunity created'+ body);
                mails.add(mail);
                System.debug('Mail email'+mail);  
                //Messaging.sendEmail(mails);
            }
            /*else if(opplist.StageName.equals('Closed Won') && !existMap.values().contains(opplist.Name) && oppexist.size()!=0)
{ 
Messaging.SingleEmailMessage mail = new  Messaging.SingleEmailMessage();
mail.setTargetObjectId(newMap.get(opplist.AccountId));
mail.setSaveAsActivity(false);
mail.setSubject('Opportunity is closed');
body='Opportunity is closed.';
body +='<br><br>Opportunity Id: ' + opplist.Id + ' , ';
body +='Related Account Id: ' + opplist.AccountId +' , ';
body +=' <br><br>Opportunity Name: ' + opplist.Name + ' , ';
body +=' <br><br>Opportunity Close Date: ' +opplist.CloseDate + ' , ';
body +=' <br><br>Opportunity StageName: ' + opplist.StageName + ' . ';
body +=' <br><br>';
mail.setHtmlBody(body);
System.debug('Opportunity closed'+ body);
mails.add(mail);
System.debug('Mail email'+mail);  
//Messaging.sendEmail(mails);
}*/
            
            
            
        }
        if(!mails.isEmpty()) {
            
            Messaging.sendEmail(mails);
        }
        else
        {
            
        }
        
    }
    
    
    
    public static void updateStage(List<Opportunity> newList,Map<Id,Opportunity> oldMap)
    {
        System.debug('old opportunity'+oldMap);
        System.debug('new opportunity'+newList);
        List<Opportunity> Oppid=new List<Opportunity>();
        for(Opportunity opp:newList)
        {
            if(opp.StageName!=oldMap.get(opp.Id).StageName)
            {
                if(oldMap.get(opp.Id).StageName!='Closed Won' && opp.StageName=='Closed Won')
                {
                    Oppid.add(opp); 
                }
                else if(oldMap.get(opp.Id).StageName!='Closed Won' && opp.StageName!='Closed Won')
                {
                    System.debug('Opportunity changed from opent to open');
                }
            }
        }
        System.debug('Changed Opportunity id'+Oppid);
        Map<Id,Id> newMap= new  Map<Id,Id>();
        for(Opportunity Opp: oppid)
        {
            if(opp.AccountId!=NULL)
            {
                newMap.put(Opp.AccountId,null);
            }
        }
        //Owner Id and Account Id
        List<Account> ownerList =[SELECT OwnerId from Account where Id =:newMap.keyset()];
        for(Account key:ownerList)
        {
            
            newMap.put(key.Id,key.OwnerId);
        }
        System.debug('ownerid'+newMap);
        List<Messaging.SingleEmailMessage> mails= new  List<Messaging.SingleEmailMessage>(); 
        String body;
        for(Opportunity opplist:oppid){
            
            if(opplist.AccountId!=NULL && opplist.StageName.equals('Closed Won'))
            {
                Messaging.SingleEmailMessage mail = new  Messaging.SingleEmailMessage();
                mail.setTargetObjectId(newMap.get(opplist.AccountId));
                mail.setSaveAsActivity(false);
                mail.setSubject('Opportunity is Closed');
                body='Opportunity is Closed.';
                body +='<br><br>Opportunity Id: ' + opplist.Id + ' , ';
                body +='Related Account Id: ' + opplist.AccountId +' , ';
                body +=' <br><br>Opportunity Name: ' + opplist.Name + ' , ';
                body +=' <br><br>Opportunity Close Date: ' +opplist.CloseDate + ' , ';
                body +=' <br><br>Opportunity StageName: ' + opplist.StageName + ' . ';
                body +=' <br><br>';
                mail.setHtmlBody(body);
                System.debug('Opportunity Closed'+ body);
                mails.add(mail);
                System.debug('Mail email'+mail);  
                
            }
            
            
        }
        if(!mails.isEmpty()) {
            
            Messaging.sendEmail(mails);
        }
        else
        {
            
        }
    }
}