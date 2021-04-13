@isTest
Private class UpdateAccountCATriggerTest {
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

        List<Order> ordersList = TestDataFactory.createListOrders(account, priceBook, 200);
        insert ordersList;

        List<OrderItem> orderItemsList = TestDataFactory.createListOrderItems(ordersList, priceBook);
        insert orderItemsList;
    }
    
    //Implementation Test of UpdateAmountCATrigger Class for 1 order
    @isTest static void UpdateAccountCATriggerTest() {
        //1 order with TotalAmount = 10
        Order orderTest = [SELECT AccountId, TotalAmount, Status FROM Order WHERE Name='Order Test'];
        orderTest.Status='Activated';

        Test.startTest();
        update orderTest;
        Test.stopTest();

        Account account = [SELECT chiffre_d_affaire__c FROM Account WHERE Name='Test Account'];
        //1 order in the account with TotalAmount = 10 and status = 'Activated'
        //so chiffre_d_affaire__c = 10
        System.assertEquals(10, account.chiffre_d_affaire__c);
    }

    //Implementation Test of UpdateAmountCATrigger Class for 200 orders
    @isTest static void UpdateAccountsCATriggerTestWithHundredOrders(){
        //200 orders with each TotalAmount = 10
        List<Order> orderListTest = [SELECT AccountId, TotalAmount, Status, Name FROM Order WHERE Name LIKE 'Order Test List %'];
        List<Order> orderListToUpd =new List<Order>();
        for(Order odr : orderListTest){
            odr.Status='Activated';
            orderListToUpd.add(odr);
        }

        Test.startTest();
        update orderListToUpd;
        Test.stopTest();

        Account account = [SELECT chiffre_d_affaire__c FROM Account WHERE Name='Test Account'];
        //200 orders in the account with each TotalAmount = 10 and Status = 'Activated'
        //so chiffre_d_affaire__c = 200 * 10 = 2000
        System.assertEquals(2000, account.chiffre_d_affaire__c);
    }
}