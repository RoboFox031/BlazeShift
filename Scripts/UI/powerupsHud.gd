extends UI
class_name powerupsHud

@onready var sprite = $animatedSprite2d


func changeItem(playerStr):
	if playerStr == 'p1':
		sprite.play(globalVars.pOnePowerup)
	elif playerStr == 'p2':
		sprite.play(globalVars.pTwoPowerup)
		
