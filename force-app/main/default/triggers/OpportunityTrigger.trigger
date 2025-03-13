trigger OpportunityTrigger on Opportunity (before update) {
    for(Opportunity opp : trigger.New) {
        if(opp.amount < 5000) {
            opp.addError('Opportunity amount must be greater than 5000');
        }
    }
}