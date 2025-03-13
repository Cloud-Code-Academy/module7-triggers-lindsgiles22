trigger OpportunityTrigger on Opportunity (before update, before delete) {
    // Before update logic
    if (Trigger.isUpdate) {
        for(Opportunity opp : trigger.New) {
            if(opp.amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
        }
    }
}
    // Before delete logic
    if(trigger.isDelete) {
        for (Opportunity opp : Trigger.old) {
            if (opp.StageName == 'Closed Won') {
                // Query related Account's Inducstry
                Account relatedAccount = [SELECT Industry FROM Account WHERE Id = :opp.AccountId LIMIT 1];

                if (relatedAccount.Industry == 'Banking') {
                    opp.addError('Cannot delete closed opportunity for a banking account that is won')
                }
            }
        }
    }
}
