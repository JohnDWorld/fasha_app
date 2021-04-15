/**
 * 
 * Class test to check if we can to calculate an account's turnover with 200 orders
 * 
 * @author JohnDWorld
 */
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

        List<Order> ordersList = TestDataFactory.createListOrders(account, priceBook, 200);
        insert ordersList;

        List<OrderItem> orderItemsList = TestDataFactory.createListOrderItems(ordersList, priceBook);
        insert orderItemsList;
    }

    //Implementation Test of UpdateAmountCATrigger Class for 200 orders
    @isTest static void UpdateAccountsCATriggerWithHundredOrdersTest(){
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