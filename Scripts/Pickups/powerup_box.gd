extends pickup
class_name pickupBox

@onready var animatedSprite = $animatedSprite2d
@onready var collision = $area2d/collisionShape2d
@onready var timer = $timer
var selection = randi_range(1,2)

func ready():
	animatedSprite.play('Idle')

func _on_area_2d_body_entered(Car):
	self.visible = false
	timer.start()
	if selection == 1:
		type = 'fireballPickup'
		entered(Car)
	elif selection == 2:
		type = 'blazePickup'
		entered(Car)
	


func _on_timer_timeout() -> void:
	self.visible = true
