trigger CalculAmountTrigger on Order (before update) {
	//Trigger to catch the order and calcul his amount before update
	CalculAmount.CalculNetAmount(Trigger.New);
}