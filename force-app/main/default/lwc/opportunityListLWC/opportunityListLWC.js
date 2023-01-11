import { LightningElement, track, wire } from 'lwc';
import GetAllOpportunity from '@salesforce/apex/FirstLWCController.GetAllOpportunity';

export default class OpportunityListLWC extends LightningElement {
@track oppList;
@track error;

    @wire(GetAllOpportunity) newGetAllOpportunity({
        error,data})
    {
        if(data)
        {
            this.oppList=data;
        }
        if(error)
        {
          this.error=error;
        }
    }
}