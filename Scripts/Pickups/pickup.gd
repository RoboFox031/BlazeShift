extends Node
class_name pickup

var types = ['fireball','blaze']

func entered(player):
	if player.currentOwner == player.playerChoices.p1 and globalVars.pOnePowerup == 'none':
		globalVars.pOnePowerup = types.pick_random()
		get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOnePowerupsHud").changeItem()
		queue_free()
	elif player.currentOwner == player.playerChoices.p2 and globalVars.pTwoPowerup == 'none':
		globalVars.pTwoPowerup = types.pick_random()
		get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoPowerupsHud").changeItem()
		queue_free()
