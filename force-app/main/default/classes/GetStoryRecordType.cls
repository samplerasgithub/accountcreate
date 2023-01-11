public class GetStoryRecordType {

     @InvocableMethod(label='get story record Type Id' description ='get story recordType Id' category='Case')
public static  List<RecordType> getStoryrecordTypeId(List<String> recordtypename)
    {
        List<RecordType> storyrecordId= [select Id from RecordType where DeveloperName =:recordtypename];
        System.debug('RecordTypeId is:'+storyrecordId);
        return storyrecordId;
        
    
}
}