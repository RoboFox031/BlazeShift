extends pickup
class_name pickupBox

@onready var animatedSprite = $animatedSprite2d
@onready var collision = $area2d/collisionShape2d


func _on_area_2d_body_entered(Car):
	if randi_range(1,2) == 1:
		if Car.currentOwnerStr == "p1":
			globalVars.pOnePowerup = 'fireballPickup'
			#changeItem()
		if Car.currentOwnerStr == "p2":
			globalVars.pTwoPowerup = 'fireballPickup'
	elif randi_range(1,2) == 2:
		if Car.currentOwnerStr == "p1":
			globalVars.pOnePowerup = 'blazePickup'
			
		if Car.currentOwnerStr == "p2":
			globalVars.pTwoPowerup = 'blazePickup'
		
		
	
