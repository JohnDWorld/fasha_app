/**
 * 
 * Controller Class for the VisualForce page
 * 
 * @author JohnDWorld 
 */
public with sharing class MyTeamOrdersController {
    public List<SelectOption> teamOption {set;}
    public List<CollaborationGroup> cgList {get;set;}
    public List<CollaborationGroupMember> cgmList {get;set;}
    public List<Order> orderList {get;set;}
    public Id selectedTeamId {get;set;}

    //Method to catch the selected option
    public List<SelectOption> getTeamOption(){
        List<SelectOption> options = new List<SelectOption>();
        cgList = [Select Id,Name From CollaborationGroup];
        for(CollaborationGroup cg : cgList) {
            options.add(new SelectOption(cg.Id,cg.Name));
        }
        return options;
    }

    //Method to find orders to display thanks of selectedTeamId
    public void OrderAccList(){
        List<Order> orders = new List<Order>();
        if(selectedTeamId != Null){
            cgmList = [SELECT MemberId FROM CollaborationGroupMember WHERE CollaborationGroupId=:selectedTeamId];
            for(CollaborationGroupMember cgm : cgmList){
                for(Order order : [SELECT Name, TotalAmount, CreatedById FROM Order WHERE CreatedById=:cgm.MemberId]){
                    orders.add(order);
                }
            }
        }
        orderList = orders;
    }
}