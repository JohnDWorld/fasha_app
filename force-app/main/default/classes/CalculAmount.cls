/**
 * 
 * Class to calcul the net amount of order
 * 
 * @author JohnDWorld
 */
 public with sharing class CalculAmount {
    //Static method to update the net amount of order
    public static void CalculNetAmount(List<Order> orders) {
        for(Order order : orders){
	    order.NetAmount__c = order.TotalAmount - order.ShipmentCost__c;
        }
    }
}