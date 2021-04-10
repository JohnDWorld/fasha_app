global class UpdateAllAccountsBatch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator('SELECT Id, chiffre_d_affaire__c, (SELECT TotalAmount, Status FROM Orders WHERE Status=\'Activated\') FROM Account');
    }
     
    global void execute(Database.BatchableContext info, List<Account> scope){
        List<Account> allAccountToUpdate = new List<Account>();
        for(Account account: scope){
            Decimal totalAmount = 0;
            for(Order order: account.orders){
                totalAmount += order.TotalAmount;
            }
            account.chiffre_d_affaire__c = totalAmount;
            allAccountToUpdate.add(account);
        }
        update allAccountToUpdate;
    }    
     
    global void finish(Database.BatchableContext info){     

    } 
 }