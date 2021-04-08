@isTest
private class CalculAmountTriggerTest {
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
    @isTest static void CalculAmountTriggerTest(){
        Test.startTest();
        Order orderTest = [SELECT Id,ShipmentCost__c,TotalAmount,NetAmount__c FROM Order WHERE Name='Order Test'];
        orderTest.ShipmentCost__c = 10;
        update orderTest;
        Test.stopTest();
        orderTest = [SELECT Id,ShipmentCost__c,TotalAmount,NetAmount__c FROM Order WHERE Name='Order Test'];
        System.assertEquals(50, orderTest.NetAmount__c);
    }
}