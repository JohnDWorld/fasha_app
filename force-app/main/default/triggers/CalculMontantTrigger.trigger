trigger CalculMontantTrigger on Order (before update) {
	CalculAmount.CalculNetAmount(Trigger.New);
}