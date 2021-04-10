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

        List<Order> ordersList = TestDataFactory.createListOrders(account, priceBook, 100);
        insert ordersList;

        List<OrderItem> orderItemsList = TestDataFactory.createListOrderItems(ordersList, priceBook);
        insert orderItemsList;
    }
    @isTest static void UpdateAccountCATriggerTest() {
        Order orderTest = [SELECT AccountId, TotalAmount, Status FROM Order WHERE Name='Order Test'];
        orderTest.Status='Activated';
        update orderTest;
        Account account = [SELECT chiffre_d_affaire__c FROM Account WHERE Name='Test Account'];
        System.assertEquals(10, account.chiffre_d_affaire__c);
    }
    @isTest static void UpdateAccountsCATriggerTestWithHundredOrders(){
        List<Order> orderListTest = [SELECT AccountId, TotalAmount, Status, Name FROM Order WHERE Name LIKE 'Order Test List _'];
        List<Order> orderListToUpdate = new List<Order>();
        for(Order odr : orderListTest){
            odr.Status='Activated';
            orderListToUpdate.add(odr);
        }
        update orderListToUpdate;
        Account account = [SELECT chiffre_d_affaire__c FROM Account WHERE Name='Test Account'];
        System.assertEquals(100, account.chiffre_d_affaire__c);
    }
}
