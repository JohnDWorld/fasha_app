trigger CalculAmountTrigger on Order (before update) {
	CalculAmount.CalculNetAmount(Trigger.New);
}