@isTest
private class CalculAmountTest {
    //Setup the Data for the test
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

    //Unit Test of the CalculAmount Class
    @isTest static void CalculAmountTest() {
        List<Order> orderListTest = new List<Order>();
        
        //The order TotalAmount = 10
        Order orderTest = [SELECT ShipmentCost__c,TotalAmount,NetAmount__c FROM Order WHERE Name='Order Test'];
        orderTest.ShipmentCost__c = 10;
        orderListTest.add(orderTest);

        Test.startTest();
        CalculAmount.CalculNetAmount(orderListTest);
        Test.stopTest();

        //TotalAmount(10) - ShipmentCost__c(10)=NetAmount__c(0)
        System.assertEquals(0, orderTest.NetAmount__c);
    }
}