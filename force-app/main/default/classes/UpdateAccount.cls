public class UpdateAccount{
    //Static method to update the turnover of account
    public static void UpdateAccoutCA(Map<Id,Order> ordersMap){
        List<Account> accountsToUpdate = new List<Account>();
        for(Account acct : [SELECT Id, chiffre_d_affaire__c, (SELECT Id, TotalAmount FROM Orders WHERE Id IN :ordersMap.keySet() AND Status='Activated') FROM Account]){
            for(Order odr : acct.orders){
                acct.chiffre_d_affaire__c += odr.TotalAmount;
            }
            accountsToUpdate.add(acct);
        }
        update accountsToUpdate;     
    }
}