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
    }
    @isTest static void CalculAmountTriggerTest(){
        Order orderTest = [SELECT Id,ShipmentCost__c,TotalAmount,NetAmount__c FROM Order WHERE Name='Order Test'];
        orderTest.ShipmentCost__c = 5;
        update orderTest;
        orderTest = [SELECT Id,ShipmentCost__c,TotalAmount,NetAmount__c FROM Order WHERE Name='Order Test'];
        System.assertEquals(5, orderTest.NetAmount__c);
    }
}