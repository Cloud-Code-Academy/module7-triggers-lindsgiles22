trigger OpportunityTrigger on Opportunity (before update, before delete) {
    // Before update logic
    if (Trigger.isUpdate) {
        // Collect all Account IDs to query Contacts in bulk
        Set<Id> accountIds = new Set<Id>();

        for(Opportunity opp : trigger.New) {
            if(opp.amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
            accountIds.add(opp.AccountId);
    }
    // Query all CEO Contacts in bulk
    Map<Id, Contact> ceoContactsMap = new Map<Id, Contact>();
    for (Contact ceo : [SELECT Id, AccountId FROM Contact WHERE Title = 'CEO' AND AccountId In :accountIds]){
        ceoContactsMap.put(ceo.AccountId, ceo);
    }
    // Assign the CEO Contact to the Opportunity
    for (Opportunity opp : Trigger.new) {
        if (ceoContactsMap.containsKey(opp.AccountId)) {
            opp.Primary_Contact__c = ceoContactsMap.get(opp.AccountId).Id;
        }
    }
}
    // Before delete logic
    if(Trigger.isDelete) {
        for (Opportunity opp : Trigger.old) {
            if (opp.StageName == 'Closed Won') {
                // Query related Account's Inducstry
                Account relatedAccount = [SELECT Industry FROM Account WHERE Id = :opp.AccountId LIMIT 1];

                if (relatedAccount.Industry == 'Banking') {
                    opp.addError('Cannot delete closed opportunity for a banking account that is won');
                }
            }
        }
    }
}

    