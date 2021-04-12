@isTest
private class UpdateAccountTest {
    @TestSetup
    static void setup(){
        Account account = TestDataFactory.createAccount();
        insert account;

        Product2 product2 = TestDataFactory.createProduct2();
        insert product2;

        PricebookEntry priceBook = TestDataFactory.createPriceBook(product2);
        insert priceBook;
        
        Order order = TestDataFactory.createOrder(account, priceBook);
        insert order;

        OrderItem orderItem = TestDataFactory.createOrderItem(order, priceBook);
        insert orderItem;
    }
    @isTest static void UpdateAccountsCATest(){
        Map<Id, Order> orderMapTest = new Map<Id, Order>{};
        Order orderTest = [SELECT Id, AccountId, TotalAmount, Status FROM Order WHERE Name='Order Test'];
        orderTest.Status='Activated';
        update orderTest;
        orderMapTest.put(orderTest.Id, orderTest);
        Test.startTest();
        UpdateAccount.UpdateAccoutCA(orderMapTest);
        Test.stopTest();
        Account account = [SELECT chiffre_d_affaire__c FROM Account WHERE Name='Test Account'];
        System.assertEquals(20, account.chiffre_d_affaire__c);
    }
}