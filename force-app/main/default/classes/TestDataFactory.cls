public abstract class TestDataFactory {

    //Account creation
    public static Account createAccount() {
        Account account = new Account(Name ='Test Account '+Math.random());
        return account;
    }

    //Product creation
    public static Product2 createProduct() {
        Product2 product = new Product2(Name='Test Product '+Math.random());
        return product;
    }

    //PricebookEntry creation
    public static PricebookEntry createPriceBook(Product2 product) {
        PricebookEntry priceBook = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product.Id,
            UnitPrice = 1000,
            IsActive = true
        );
        return priceBook;
    }

    //Order creation
    public static Order createOrder(Account account) {
        Order order = new Order(AccountId=account.Id);
        return order;
    }

    //OrderItem creation
    public static OrderItem createOrderItem(Order order, PricebookEntry priceBook) {
        OrderItem orderItem = new OrderItem(
            OrderId=order.Id, 
            PricebookEntryId=priceBook.Id, 
            Quantity=10,
            UnitPrice=150);
        return orderItem;
    }

    //Account list creation
    public static List<Account> createListAccounts(Integer numberOfAccounts) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0 ; i<numberOfAccounts ; i++) {
            Account account = new Account(Name = 'Test Account' + Math.random());
            accounts.add(account);
        }
        return accounts;
    }

    //Order list creation
    public static List<Order> createListOrders(Integer numberOfAccounts, Account account) {
        List<Order> orders = new List<Order>();
        for (Integer i = 0 ; i<numberOfAccounts ; i++) {
            Order order = new Order(AccountId=account.Id);
            orders.add(order);
        }
        return orders;
    }

    //OrderItem list creation
    public static List<OrderItem> createListOrderItems(Integer numberOfAccounts, Order order, PricebookEntry priceBook) {
        List<OrderItem> orderItems = new List<OrderItem>();
        for (Integer i = 0 ; i<numberOfAccounts ; i++) {
            OrderItem orderItem = new OrderItem(
                OrderId=order.Id, 
                PricebookEntryId=priceBook.Id, 
                Quantity=10,
                UnitPrice=150);
            orderItems.add(orderItem);
        }
        return orderItems;
    }
}