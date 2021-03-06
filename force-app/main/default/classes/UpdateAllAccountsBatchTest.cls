/**
 * 
 * Class test the batch with some account with a lot of orders each
 * 
 * @author JohnDWorld
 */
@isTest
private class UpdateAllAccountsBatchTest {
    //Setup the Data for the test
    @TestSetup
    static void setup(){
        Product2 product2 = TestDataFactory.createProduct2();
        insert product2;

        PricebookEntry priceBook = TestDataFactory.createPriceBook(product2);
        insert priceBook;

        List<Account> accounts = TestDataFactory.createListAccounts(5);
        insert accounts;
        for (Account account : accounts) {
            List<Order> ordersList = TestDataFactory.createListOrders(account, priceBook, 200);
            insert ordersList;
    
            List<OrderItem> orderItemsList = TestDataFactory.createListOrderItems(ordersList, priceBook);
            insert orderItemsList;
        }
    }

    //Unit Test of UpdateAllAccountsBatch Class
    @isTest static void UpdateAllAccountsBatchTest() {
        //10 accounts with 200 orders each and each order has TotalAmount = 10
        List<Order> orderListTest = [SELECT AccountId, TotalAmount, Status, Name FROM Order WHERE Name LIKE 'Order Test List %'];
        List<Order> orderListToUpd =new List<Order>();
        for(Order odr : orderListTest){
            odr.Status='Activated';
            orderListToUpd.add(odr);
        }
        update orderListToUpd;

        Test.startTest();
        UpdateAllAccountsBatch uaab = new UpdateAllAccountsBatch();
        Id batchId = Database.executeBatch(uaab);
        Test.stopTest();

        List<Account> accounts = [SELECT chiffre_d_affaire__c FROM Account];
        //Each account has 200 orders with TotalAmount = 10
        //so for each account chiffre_d_affaire__c = 200 * 10 = 2000
        for (Account account : accounts) {
            System.assertEquals(2000, account.chiffre_d_affaire__c);
        }
    }
}