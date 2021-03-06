/**
 * 
 * Class to setup data for the test
 * 
 * @author JohnDWorld
 */
public abstract class TestDataFactory {

    //Account creation
    public static Account createAccount() {
        Account account = new Account(
            Name ='Test Account',
            chiffre_d_affaire__c=0);
        return account;
    }

    //Product2 creation
    public static Product2 createProduct2() {
        Product2 product = new Product2(
            Name='Test Product',
            IsActive=true);
        return product;
    }

    //PricebookEntry creation
    public static PricebookEntry createPriceBook(Product2 product2) {
        PricebookEntry priceBook = new PricebookEntry(
            Pricebook2Id= Test.getStandardPricebookId(),
            Product2Id = product2.Id,
            UnitPrice = 10,
            IsActive = true);
        return priceBook;
    }

    //Order creation
    public static Order createOrder(Account account, PricebookEntry priceBook) {
        Order order = new Order(
            Name='Order Test',
            AccountId=account.Id,
            Pricebook2Id=priceBook.Pricebook2Id,
            EffectiveDate=System.today(),
            ShipmentCost__c=0,
            Status='Draft');
        return order;
    }

    //OrderItem creation
    public static OrderItem createOrderItem(Order order, PricebookEntry priceBook) {
        OrderItem orderItem = new OrderItem(
            OrderId=order.Id, 
            PricebookEntryId=priceBook.Id,
            Quantity=1,
            UnitPrice=10);
        return orderItem;
    }

    //CollaborationGroup creation
    public static CollaborationGroup createCollaborationGroup(){
        CollaborationGroup cg = new CollaborationGroup(
            Name='Group Test',
            CollaborationType='Public'
        );
        return cg;
    }

    //CollaborationGroupMember creation
    public static List<CollaborationGroupMember> createCollaborationGroupMember(List<User> users, CollaborationGroup cg){
        List<CollaborationGroupMember> cgmList = new List<CollaborationGroupMember>();
        for(User user: users){
            CollaborationGroupMember cgm = new CollaborationGroupMember(
                MemberId=user.Id,
                CollaborationGroupId=cg.Id
            );
            cgmList.add(cgm);
        }
        return cgmList;
    }

    //Account list creation
    public static List<Account> createListAccounts(Integer numberOfAccounts) {
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<numberOfAccounts; i++) {
            Account account = new Account(
                Name='Test Account '+i,
                chiffre_d_affaire__c=0);
            accounts.add(account);
        }
        return accounts;
    }

    //Order list creation
    public static List<Order> createListOrders(Account account, PricebookEntry priceBook, Integer numbersOfOrderForAccount) {
        List<Order> orders = new List<Order>();
        for(Integer i=0; i<numbersOfOrderForAccount; i++){
            Order order = TestDataFactory.createOrder(account, priceBook);
            order.Name='Order Test List '+i;
            orders.add(order);
        }
        return orders;
    }

    //OrderItem list creation
    public static List<OrderItem> createListOrderItems(List<Order> orders, PricebookEntry priceBook) {
        List<OrderItem> orderItems = new List<OrderItem>();
        for (Order order : orders){
            OrderItem orderItem = TestDataFactory.createOrderItem(order, priceBook);
            orderItems.add(orderItem);
        }
        return orderItems;
    }

    //User list creation
    public static List<User> createListUsers(Integer numberOfUsers){
        List<User> users = new List<User>();
        Profile profile = [SELECT Id FROM Profile WHERE Name='Standard User'];
        for(Integer i=0; i<numberOfUsers; i++){
            Blob b = Crypto.generateAesKey(128);
            String h = EncodingUtil.convertToHex(b);
            String uId = h.substring(0, 8);
            User user = new User(
                Alias = uId, 
                Email=uId+'@testorg.com', 
                EmailEncodingKey='UTF-8', 
                LastName='UserTest'+i, 
                LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', 
                ProfileId = profile.Id, 
                TimeZoneSidKey='Europe/Paris', 
                UserName=uId+'@testorg.com');
            users.add(user);
        }
        return users;
    }
}