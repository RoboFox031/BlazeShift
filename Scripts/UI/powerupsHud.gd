extends UI
class_name powerupsHud

@onready var sprite = $animatedSprite2d
var player: int

func changeItem():
	if player == 1:
		sprite.play(globalVars.pOnePowerup)
	elif player == 2:
		sprite.play(globalVars.pTwoPowerup)
		pass
