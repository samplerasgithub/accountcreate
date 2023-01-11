/*
             * @description: Calendar Helper class to get months,get date range for a specific month in a given year,get week number,return column number.
             * @author: Rasika Jadhav
             * @date: 7-09-2022
             * @revised: 22-09-2022

 */
public class CalendarHelper {
    /*
             * @description: function to get months 
             * @author: Rasika Jadhav
             * @date: 7-09-2022
             * @revised: 22-09-2022
             * @param:  Todays Date
             * @return: None
    */
    public String getmonths(Date todaysDate){
        List<String> monthList = new List<String>{'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'};
		String monthList1 = monthList.get(todaysDate.Month() - 1); //List starts from [0]index so used -1 to reduce the number
       // System.debug('Current Month is:' +monthList.get(todaysDate.Month() - 1));  //List starts from [0]index so used -1 to reduce the number
        return monthList1;
       
    }
    
    
     /*
             * @description: function to get Date Range
             * @author: Rasika Jadhav
             * @date: 7-09-2022
             * @revised: 22-09-2022
             * @param: Date
             * @return: Date Range
    */
     public Integer getDateRange(date inputDate){
        Integer dateRange = Date.daysInMonth(inputDate.year(), inputdate.month());
        System.debug('Date Range of this month is 1 - ');
        return dateRange;
         
    }
   
     /*
             * @description: function to get Week number
             * @author: Rasika Jadhav
             * @date: 7-09-2022
             * @revised: 22-09-2022
             * @param: Year,Month,Date
             * @return: week number
    */
    
    public void getWeek(Date inputDate)
    {
       
        Date firstDate = inputDate.toStartOfMonth(); //10Sept 2022- Stores 1st date of given month/date from user
        Date extraDaysDate = firstDate.toStartOfWeek(); // 5
        Decimal dueDays = extraDaysDate.daysBetween(firstDate)-1; // 3due days, As week is starting from 28 and month is starting from 1 so due days will be 3
        System.debug('Due Days='+ dueDays);
        System.debug(inputDate.day()); //inputDate.day stores 10
        Decimal dayValue = (inputDate.day()+dueDays)/7;          // (10+3/7)=1.24 i.e, First Week
        if(dayValue<=1){
            System.debug('First Week');
        }
        else if(dayValue<=2){
            System.debug('Second Week');
        }
        else if(dayValue<=3){
            System.debug('Third Week');
        }
        else if(dayValue<=4){
            System.debug('Fourth Week');
        }
        else{
            System.debug('Fifth Week');
        }
        
    }    
  /*
             * @description: function to get Column number
             * @author: Rasika Jadhav
             * @date: 7-09-2022
             * @revised: 22-09-2022
             * @param: Date
             * @return: Column Number
    */
    
    public Integer getColumn(date inputDate)
    {
       Integer colNumber = inputDate.toStartOfWeek().daysBetween(inputDate);
        if(colNumber != 0){
            System.debug('Column Number='+colNumber);
        }
        else{
            System.debug('Column Number is 7');
        }
        return colNumber;
    }
}