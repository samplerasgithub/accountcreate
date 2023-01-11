public class EmailMessageHandler {
    public static void SetBCCAddress(List<EmailMessage> emailMessageList)
    { 
        Set<Id> caseIdSet = new Set<Id>();
        for(EmailMessage em: emailMessageList) 
        {
            if(em.ParentId!=NULL)
            {
                caseIdSet.add(em.ParentId);
            }
        }   
        System.debug('caseIdSet'+caseIdSet);
        if(caseIdSet!=NULL)
        {
            List<CaseTeamMember> caseTeamList = [SELECT Id,MemberId,Member.Email,ParentId 
                                                 FROM CaseTeamMember 
                                                 WHERE
                                                 ParentId IN:caseIdSet];
            
            System.debug('caseTeamList'+caseTeamList);
            Map<Id,List<Id>> Mapofcaseteam =  new Map<Id,List<Id>>();
            Set<Id> userIdList1 = new Set<Id>();
            for(CaseTeamMember Ctm:caseTeamList)
            {
                if(Mapofcaseteam.containsKey(Ctm.ParentId) && Mapofcaseteam.get(Ctm.ParentId) != null)
                {
                    List<Id> memberIdList = Mapofcaseteam.get(ctm.ParentId);
                    memberIdList.add(ctm.MemberId);
                    Mapofcaseteam.put(ctm.ParentId,memberIdList); 
                }   
                else {
                    Mapofcaseteam.put(ctm.ParentId, new List<Id> {ctm.MemberId});
                }
                userIdList1.add(Ctm.MemberId);     
            }
            System.debug('Mapofcaseteam'+Mapofcaseteam);
            System.debug('userIdList'+userIdList1);
            Map<Id,List<String>> EmailMap = new Map<Id,List<String>>();
            
            for(User us:[select Email from user where Id IN:userIdList1])
            {
                for(Id idobj:Mapofcaseteam.keyset())
                {
                    if(EmailMap.containsKey(idobj) && EmailMap.get(idobj) != null)
                    {
                        List<String> memberEmailList = EmailMap.get(idobj);
                        memberEmailList.add(us.Email);
                        EmailMap.put(idobj,memberEmailList); 
                    }   
                    else {
                        EmailMap.put(idobj, new List<String> {us.Email});
                    }
                }
            }
            System.debug('EmailMap'+EmailMap);
            List<String> memberEmailList = new List<String>();            
            for(EmailMessage em: emailMessageList) 
            { 
                if(em.ParentId!=NULL)
                {
                    if(em.ParentId.getSObjectType() == Case.sObjectType && EmailMap.containskey(em.ParentId))
                    {
                        System.debug('Case.sObjectType'+Case.sObjectType);
                        System.debug('em.ParentId.getSObjectType() '+em.ParentId.getSObjectType());
                        
                        memberEmailList=EmailMap.get(em.ParentId);
                        em.BccAddress=String.join(memberEmailList, ';');    
                    }       
                }
            }
            System.debug('emailMessageList'+emailMessageList);
        } 
    }
}