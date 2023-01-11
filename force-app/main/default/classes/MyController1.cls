public class MyController1 {
public Boolean flag{get;set;}
public MyController1()
{
    this.flag=false;
}
public PageReference myaction()
{
    flag=true;
    return null;
}

}