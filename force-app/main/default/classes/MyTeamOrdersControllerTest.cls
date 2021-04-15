/**
 * 
 * Class test for the controller's MyTeamOrdersPage
 * 
 * @author JohnDWorld
 */
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
        
        List<Order> ordersList = TestDataFactory.createListOrders(account, priceBook, 200);
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
        
        List<SelectOption> so = mtoController.getTeamOption();
        //1 group was create so only 1 option was return
        System.assertEquals(1, so.size());
        //Place the Id of option in selectedTeamId
        mtoController.selectedTeamId=so[0].getValue();
        
        mtoController.OrderAccList();
        //10 Orders were create so we have 10 orders in the orders'list
        System.assertEquals(200, mtoController.orderList.size());
    }
}