/**
 * 
 * Trigger to call CalculAmount's Class before update order
 * 
 * @author JohnDWorld
 */
trigger CalculAmountTrigger on Order (before update) {
	//Trigger to catch the order and calcul his amount before update
	CalculAmount.CalculNetAmount(Trigger.New);
}