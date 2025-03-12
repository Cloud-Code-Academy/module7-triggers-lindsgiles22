trigger AccountTrigger on Account (before insert, after insert) {
    for (Account acc : Trigger.new) {
        if (String.isBlank(acc.type)){
            acc.type = 'Prospect';
        }
        // Check if shipping fields are not blank before copying
        if (!String.isBlank(acc.ShippingStreet)) {
            acc.BillingStreet = acc.ShippingStreet;
        }
        if (!String.isBlank(acc.ShippingCity)) {
            acc.BillingCity = acc.ShippingCity;
        }
        if (!String.isBlank(acc.ShippingState)) {
            acc.BillingState = acc.ShippingState;
        }
        if (!String.isBlank(acc.ShippingCountry)) {
            acc.BillingCountry = acc.ShippingCountry;
        }
        if (!String.isBlank(acc.ShippingPostalCode)) {
            acc.BillingPostalCode = acc.ShippingPostalCode;
        }
        // Check if phone, website, fax all have values and if so set rating to 'Hot'
        if (!String.isBlank(acc.phone) && !String.isBlank(acc.website) && !String.isBlank(acc.fax)) {
            acc.rating = 'Hot';
        }
    }

    // After insert logic
    if (Trigger.isAfter && Trigger.isInsert) {
        
    }
}