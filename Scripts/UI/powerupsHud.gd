extends UI
class_name powerupsHud

@onready var sprite = $animatedSprite2d


func changeItem(playerStr):
	if playerStr == 'p1':
		sprite.play(globalVars.pOnePowerup)
		if globalVars.pOnePowerup == 'snowballPickup':
			sprite.scale = Vector2(11,11)
		else:
			sprite.scale = Vector2(1,1)
	elif playerStr == 'p2':
		sprite.play(globalVars.pTwoPowerup)
		if globalVars.pTwoPowerup == 'snowballPickup':
			sprite.scale = Vector2(11,11)
		else:
			sprite.scale = Vector2(1,1)
		
