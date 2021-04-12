trigger UpdateAccountCATrigger on Order (after update) {
    UpdateAccount.UpdateAccoutCA(Trigger.newMap);
}