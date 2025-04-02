extends pickup
class_name pickupBox

@onready var animatedSprite = $animatedSprite2d
@onready var collision = $area2d/collisionShape2d


func _on_area_2d_body_entered(body: Car):
	if randi_range(1,2) == 1:
		globalVars.pOnePowerup.type = 'fireball'
		globalVars.pTwoPowerup.type = 'fireball'
	elif randi_range(1,2) == 2:
		globalVars.pOnePowerup.type = 'blaze'
		globalVars.pTwoPowerup.type = 'blaze'
	
