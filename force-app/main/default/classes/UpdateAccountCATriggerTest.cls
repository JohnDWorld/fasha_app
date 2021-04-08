@isTest
Private class UpdateAccountCATriggerTest {
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

        List<Account> accountsList = TestDataFactory.createListAccounts(5);
        insert accountsList;

        List<Order> ordersList = TestDataFactory.createListOrders(5, account);
        insert ordersList;

        List<OrderItem> orderItemsList = TestDataFactory.createListOrderItems(5, order, priceBook);
        insert orderItemsList;
    }
    @isTest static void UpdateAccountCATriggerTest() {
        Order orderTest = [SELECT AccountId, TotalAmount, Status FROM Order WHERE Name='Order Test'];
        orderTest.Status='Activated';
        update orderTest;
        Account account = [SELECT chiffre_d_affaire__c FROM Account WHERE Name='Test Account'];
        System.assertEquals(60, account.chiffre_d_affaire__c);
    }
}
