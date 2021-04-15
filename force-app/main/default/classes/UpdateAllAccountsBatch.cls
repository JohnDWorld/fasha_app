global class UpdateAllAccountsBatch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Request only account with at least 1 order with Status = 'Activated'
        return Database.getQueryLocator('SELECT Id, chiffre_d_affaire__c, (SELECT Id FROM Orders WHERE Status=\'Activated\') FROM Account');
    }
    
    global void execute(Database.BatchableContext info, List<Account> scope){
        List<Account> allAccountToUpdate = new List<Account>();
        //Update each turnover's account for all accounts
        for(Account account: scope){
            Decimal totalAmount = 0;
            for(Order order: [SELECT TotalAmount, Status FROM Order WHERE Status='Activated' AND AccountId=:account.ID]){
                totalAmount += order.TotalAmount;
            }
            account.chiffre_d_affaire__c = totalAmount;
            allAccountToUpdate.add(account);
        }
        update allAccountToUpdate;
    }

    global void finish(Database.BatchableContext info){} 
 }