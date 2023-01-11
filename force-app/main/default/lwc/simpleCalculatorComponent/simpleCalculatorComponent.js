import { api, LightningElement, track } from 'lwc';
var first;
var second;
export default class SimpleCalculatorComponent extends LightningElement {
    @track firstvalue;
    @track secondvalue;
    @track addvalue;
    Getfirstvalue(event)
    {
       this.firstvalue=parseInt(event.target.value);
       first=this.firstvalue;
    }

    Getsecondvalue(event)
    {
        this.secondvalue=parseInt(event.target.value);
        second=this.secondvalue;
    }
    onAddClick(event)
    {
            this.addvalue = first+second;
    }
    onSubtractClick(event)
    {
            this.addvalue = first-second;
    }
    onMultiplyClick(event)
    {
            this.addvalue = first*second;
    }
    onDivideClick(event)
    {
            this.addvalue = first/second;
    }
}