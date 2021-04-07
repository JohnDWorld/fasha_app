public with sharing class CalculAmount {
    public static void CalculNetAmount(List<Order> orders) {
        for(Order order : orders){
	    order.NetAmount__c = order.TotalAmount - order.ShipmentCost__c;
        }
    }
}