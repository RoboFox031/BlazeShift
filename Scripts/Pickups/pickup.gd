extends Node
class_name pickup

var type

func entered(player):
	if player is playerOneCar and globalVars.pOnePowerup == null:
		globalVars.pOnePowerup = type
		get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOnePowerupsHud").changeItem()
		queue_free()
	elif player is playerTwoCar and globalVars.pTwoPowerup == null:
		globalVars.pTwoPowerup = type
		get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoPowerupsHud").changeItem()
		queue_free()


func useItem():
	pass
