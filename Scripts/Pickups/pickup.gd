extends Node
class_name pickup

var type

func entered(player):
	if player.currentOwner == player.playerChoices.p1 and globalVars.pOnePowerup == null:
		globalVars.pOnePowerup = type
		get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOnePowerupsHud").changeItem()
		queue_free()
	elif player.currentOwner == player.playerChoices.p2 and globalVars.pTwoPowerup == null:
		globalVars.pTwoPowerup = type
		get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoPowerupsHud").changeItem()
		queue_free()
