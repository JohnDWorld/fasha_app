/**
 * 
 * Class test for CalculAmount and his Trigger
 * 
 * @author JohnDWorld
 */
@isTest
private class CalculAmountTriggerTest {
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

    //Implementation Test of CalculAmountTrigger Class
    @isTest static void CalculAmountTriggerTest(){
        //The order TotalAmount = 10
        Order orderTest = [SELECT Id,ShipmentCost__c,TotalAmount,NetAmount__c FROM Order WHERE Name='Order Test'];
        orderTest.ShipmentCost__c = 10;

        Test.startTest();
        update orderTest;
        Test.stopTest();

        //TotalAmount(10) - ShipmentCost__c(10) = NetAmount__c(0)
        orderTest = [SELECT Id,ShipmentCost__c,TotalAmount,NetAmount__c FROM Order WHERE Name='Order Test'];
        System.assertEquals(0, orderTest.NetAmount__c);
    }
}