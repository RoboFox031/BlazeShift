extends UI
class_name powerupsHud

@onready var sprite = $animatedSprite2d


func changeItem(playerStr):
	if playerStr == 'p1':
		sprite.play(globalVars.pOnePowerup)
		if globalVars.pOnePowerup == 'snowballPickup':
			sprite.scale = Vector2(11,11)
			sprite.modulate = Color('ffffff')
		elif globalVars.pOnePowerup == 'fireCyclonePickup':
			sprite.scale = Vector2(5.5,5.5)
			sprite.modulate = Color('ec2d42')
		else:
			sprite.scale = Vector2(1,1)
			sprite.modulate = Color('ffffff')
	elif playerStr == 'p2':
		sprite.play(globalVars.pTwoPowerup)
		if globalVars.pTwoPowerup == 'snowballPickup':
			sprite.scale = Vector2(11,11)
			sprite.modulate = Color('ffffff')
		elif globalVars.pTwoPowerup == 'fireCyclonePickup':
			sprite.scale = Vector2(5.5,5.5)
			sprite.modulate = Color('ec2d42')
		else:
			sprite.scale = Vector2(1,1)
			sprite.modulate = Color('ffffff')
		
