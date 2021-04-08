trigger UpdateAccountCATrigger on Order (after update) {
    UpdateAccounts.UpdateAccoutCA(Trigger.New);
}