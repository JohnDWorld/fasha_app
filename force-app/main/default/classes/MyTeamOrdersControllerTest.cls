@isTest
public class MyTeamOrdersControllerTest {
    //Setup the Data for the test
    @TestSetup
    static void setup(){
        Product2 product2 = TestDataFactory.createProduct2();
        insert product2;

        PricebookEntry priceBook = TestDataFactory.createPriceBook(product2);
        insert priceBook;

        Account account = TestDataFactory.createAccount();
        insert account;
        
        List<Order> ordersList = TestDataFactory.createListOrders(account, priceBook, 10);
        insert ordersList;
    
        List<OrderItem> orderItemsList = TestDataFactory.createListOrderItems(ordersList, priceBook);
        insert orderItemsList;

        List<User> usersList = TestDataFactory.createListUsers(2);
        insert usersList;

        CollaborationGroup collGroup = TestDataFactory.createCollaborationGroup();
        insert collGroup;

        List<CollaborationGroupMember> collGroupMember = TestDataFactory.createCollaborationGroupMember(usersList, collGroup);
        insert collGroupMember;
    }
    public static testMethod void MyTeamOrdersControllerTest() {
        MyTeamOrdersController mtoController = new MyTeamOrdersController();

        mtoController.teamOption();
        //1 Group was create so we have 1 option
        System.assertEquals(1, mtoController.teamOption.size());
        
        List<SelectOption> so = mtoController.teamOption;
        //Place the Id of option in selectedTeamId
        mtoController.selectedTeamId=so[0].getValue();
        
        mtoController.OrderAccList();
        //10 Orders were create so we have 10 orders in the orders'list
        System.assertEquals(10, mtoController.orderList.size());
    }
}