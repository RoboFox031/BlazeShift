extends UI
class_name powerupsHud

@onready var sprite = $animatedSprite2d


func changeItem(playerStr):
	if playerStr == 'p1':
		sprite.play(globalVars.pOnePowerup)
		if globalVars.pOnePowerup == 'snowballPickup':
			sprite.scale = 11
		else:
			sprite.scale = 1
	elif playerStr == 'p2':
		sprite.play(globalVars.pTwoPowerup)
		if globalVars.pOnePowerup == 'snowballPickup':
			sprite.scale = 11
		else:
			sprite.scale = 1
		
