public class UpdateAccounts{
    public static void UpdateAccoutCA(List<Order> orders){
        List<Account> accountsToUpdate = new List<Account>();
        for(Order order : orders){
            if(order.Status=='Activated'){
                Account account = [SELECT Name, chiffre_d_affaire__c FROM Account WHERE Id=:order.AccountId];
                account.chiffre_d_affaire__c += order.TotalAmount;
                update account;
            }
        }
    }
 }