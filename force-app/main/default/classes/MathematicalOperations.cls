public class MathematicalOperations {
    public  Integer  add(Integer num1, Integer num2)
    {
        try
        {
            if(num1 == NULL || num2 == NULL)
            {
           num1=0;
           num2=0;
            }
        }
        catch(Exception e)
        {
            System.debug('Exception '+e);
        }
        return num1+num2;
       
    }

}