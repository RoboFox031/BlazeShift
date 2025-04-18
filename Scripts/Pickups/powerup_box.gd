extends pickup
class_name pickupBox

@onready var animatedSprite = $animatedSprite2d
@onready var collision = $area2d/collisionShape2d
@onready var powerupTimer = $timer
var selection = randi_range(1,2)

func ready():
	animatedSprite.play('Idle')
		

func _on_area_2d_body_entered(Car):
	powerupTimer.start()
	if type == 'none' or type == "" or type == null:
		self.visible = false
		if selection == 1:
			type = 'fireballPickup'
			entered(Car)
		if selection == 2:
			type = 'blazePickup'
			entered(Car)
	
func _on_timer_timeout():
	self.visible = true
