extends Node
class_name pickup

func entered(player):
	if player is playerOneCar and globalVars.pOnePowerup == null:
		globalVars.pOnePowerup = "blaze"
		queue_free()
	elif player is playerTwoCar and globalVars.pTwoPowerup == null:
		globalVars.pTwoPowerup = "blaze"
		queue_free()
