extends pickup
class_name pickupBox

@onready var animatedSprite = $animatedSprite2d
@onready var collision = $area2d/collisionShape2d
@onready var powerupTimer = $timer
var selection = randi_range(1,3)

func ready():
	animatedSprite.play('Idle')
		

func _on_area_2d_body_entered(Car):
	powerupTimer.start()
	self.visible = false
	if type == 'none' or type == "" or type == null:
		print(type)
		if selection == 1:
			type = 'fireballPickup'
			entered(Car)
		if selection == 2:
			type = 'blazePickup'
			entered(Car)
		if selection == 3:
			type = 'roadSpikesPickup'
			entered(Car)
	type = 'none'
	selection = randi_range(1,3)
	
		
func _on_timer_timeout():
	self.visible = true
