@isTest
private class UpdateAccountsTest {
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
        List<Order> orderListTest = new List<Order>();
        Order orderTest = [SELECT AccountId, TotalAmount, Status FROM Order WHERE Name='Order Test'];
        orderTest.Status='Activated';
        orderListTest.add(orderTest);
        Test.startTest();
        UpdateAccounts.UpdateAccoutCA(orderListTest);
        Test.stopTest();
        Account account = [SELECT chiffre_d_affaire__c FROM Account WHERE Name='Test Account'];
        System.assertEquals(10, account.chiffre_d_affaire__c);
    }
} 