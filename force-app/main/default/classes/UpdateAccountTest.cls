@isTest
private class UpdateAccountTest {
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

    //Unit Test of UpdateAccount Class
    @isTest static void UpdateAccountsCATest(){
        Map<Id, Order> orderMapTest = new Map<Id, Order>{};

        //1 order with TotalAmount = 10
        Order orderTest = [SELECT Id, AccountId, TotalAmount, Status FROM Order WHERE Name='Order Test'];
        orderTest.Status='Activated';
        update orderTest;
        orderMapTest.put(orderTest.Id, orderTest);

        Test.startTest();
        UpdateAccount.UpdateAccoutCA(orderMapTest);
        Test.stopTest();

        Account account = [SELECT chiffre_d_affaire__c FROM Account WHERE Name='Test Account'];
        //1 order in the account with TotalAmount = 10 and Status = 'Activated'
        //but was count twice because of 'update orderTest' line 29
        //so chiffre_d_affaire__c = 10 * 2 = 20
        System.assertEquals(20, account.chiffre_d_affaire__c);
    }
}