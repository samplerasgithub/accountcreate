public class GetRecordTypeId {
     @InvocableMethod(label='get bug record Type Id' description ='get Bug recordType Id' category='Case')
public static  List<RecordType> getBugrecordTypeId(List<String> recordtypename)
    {
        List<RecordType> bugrecordId= [select Id from RecordType where DeveloperName =:recordtypename];
        System.debug('RecordTypeId is:'+bugrecordId);
        return bugrecordId;
        
    }
}