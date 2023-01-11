@isTest
public class DynamicTableController123Test {
    @isTest
    static void FetchQueryTest()
    {
        DynamicTableController123 dynamicObj = new DynamicTableController123();
        dynamicObj.SelectedObject='Contact';
        dynamicObj.selectedLimit='500';
        List<String> selectedFieldData = new List<String>();
        selectedFieldData.add('FirstName');
        dynamicObj.SelectedFields=selectedFieldData;
        dynamicObj.FetchQuery();
        }
     	@isTest
		static void executeQueryTest()
        {
             DynamicTableController123 dynamicObj = new DynamicTableController123();
            dynamicObj.querydemo='SELECT FirstName,LastName from Contact LIMIT 500';
            dynamicObj.executeQuery();
        }
    @isTest
		static void ObjectFieldsTest()
        {
            DynamicTableController123 dynamicObj = new DynamicTableController123();
            dynamicObj.SelectedObject='Contact';
            dynamicObj.ObjectFields();
        }
     @isTest
		static void sTest()
        {
            DynamicTableController123 obj = new DynamicTableController123();
            obj.test();
            
        }
    }