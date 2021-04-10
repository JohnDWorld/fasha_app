global class UpdateAllAccountsBatch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator('SELECT Id FROM Account');
    }
     
    global void execute(Database.BatchableContext info, List<Account> scope){
        List<Account> allAccountToUpdate = new List<Account>();
        for(Account account: scope){
            for(Order order: [SELECT TotalAmount FROM Order WHERE AccountId=:account.Id]){
                if(order.Status=='Activated'){
                    account.chiffre_d_affaire__c += order.TotalAmount;
                    allAccountToUpdate.add(account);
                }
            }
        }
        update allAccountToUpdate;
    }    
     
    global void finish(Database.BatchableContext info){     
        
    } 
 }