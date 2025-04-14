extends UI
class_name powerupsHud

@onready var sprite = $animatedSprite2d


func changeItem(player):
	if player.currentOwnerStr == 'p1':
		sprite.play(globalVars.pOnePowerup)
	elif player.currentOwnerStr == 'p2':
		sprite.play(globalVars.pTwoPowerup)
		pass
