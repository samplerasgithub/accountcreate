@isTest
private class AnimalLocatorTest {
   @isTest static void animalLocatorMockTest()
   {
       try
    {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String result = AnimalLocator.getAnimalNameById(1);
        System.assertEquals(result, 'chicken');
    }
       catch(Exception e)
       {
           System.debug('Hey this exception has occured'+e.getMessage());
       }
   }
    

}