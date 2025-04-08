extends pickup
class_name pickupBox

@onready var animatedSprite = $animatedSprite2d
@onready var collision = $area2d/collisionShape2d


func _on_area_2d_body_entered(body: Car):
	if randi_range(1,2) == 1:
		globalVars.pOnePowerup.type = fireballPickup
		globalVars.pTwoPowerup.type = fireballPickup
	elif randi_range(1,2) == 2:
		globalVars.pOnePowerup.type = 'blazePickup'
		globalVars.pTwoPowerup.type = 'blazePickup'
	
