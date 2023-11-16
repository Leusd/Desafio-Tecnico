global class AccountBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
         
        return Database.getQueryLocator([SELECT Id FROM Account WHERE Id NOT IN (
            SELECT AccountId FROM Opportunity WHERE (StageName = 'Closed Won' AND CloseDate = LAST_N_DAYS:120) 
            OR StageName = 'Negotiation/Review')]);
    }
     
    global void execute(Database.BatchableContext BC, List<Account> accList) {
        Set<Id> lastTasks = new Map<Id,Task>([SELECT WhatId FROM Task WHERE What.Type = 'Account' AND ActivityDate >= LAST_90_DAYS]).keySet();
        
        for(Account acc : accList) {   
            if(!lastTasks.contains(acc.Id)){
                acc.Inativa__c = true;
            }
        }
        try {
            update accList;
         
        } catch(Exception e) {
            System.debug(e);
        }
         
    }   
     
    global void finish(Database.BatchableContext BC) {
    }
}