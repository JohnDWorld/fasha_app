@isTest
private class UpdateAllAccountsBatchTest {
    @TestSetup
    static void setup(){
        Product2 product2 = TestDataFactory.createProduct2();
        insert product2;

        PricebookEntry priceBook = TestDataFactory.createPriceBook(product2);
        insert priceBook;

        List<Account> accounts = TestDataFactory.createListAccounts(10);
        insert accounts;
        for (Account account : accounts) {
            List<Order> ordersList = TestDataFactory.createListOrders(account, priceBook, 5);
            insert ordersList;
    
            List<OrderItem> orderItemsList = TestDataFactory.createListOrderItems(ordersList, priceBook);
            insert orderItemsList;
        }
    }
    @isTest static void UpdateAllAccountsBatchTest() {
        List<Order> orderListTest = [SELECT AccountId, TotalAmount, Status, Name FROM Order WHERE Name LIKE 'Order Test List _'];
        for(Order odr : orderListTest){
            odr.Status='Activated';
        }
        update orderListTest;
        Test.startTest();
        UpdateAllAccountsBatch uaab = new UpdateAllAccountsBatch();
        Id batchId = Database.executeBatch(uaab);
        Test.stopTest();
        List<Account> accounts = [SELECT chiffre_d_affaire__c FROM Account];
        for (Account account : accounts) {
            System.assertEquals(50, account.chiffre_d_affaire__c);
        }
    }
}
