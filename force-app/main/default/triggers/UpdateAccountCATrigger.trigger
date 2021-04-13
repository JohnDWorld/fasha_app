trigger UpdateAccountCATrigger on Order (after update) {
    //Trigger to update the turnover of account after update of order
    UpdateAccount.UpdateAccoutCA(Trigger.newMap);
}