extends pickup
class_name pickupBox

@onready var animatedSprite = $animatedSprite2d
@onready var collision = $area2d/collisionShape2d
@onready var powerupTimer = $timer
var selection = 2 #randi_range(1,3)

func ready():
	animatedSprite.play('Idle')
		

func _on_area_2d_body_entered(body):
	powerupTimer.start()
	self.visible = false
	if type == 'none' or type == "" or type == null:
		print(type)
		if selection == 1:
			type = 'fireballPickup'
			entered(body)
		if selection == 2:
			type = 'blazePickup'
			entered(body)
		if selection == 3:
			type = 'roadSpikesPickup'
			entered(body)
		if selection == 4:
			type = 'snowballPickup'
			entered(body)
	if self.visible == false and globalVars.pOnePowerup != 'none' or globalVars.pTwoPowerup != 'none':
		entered(body)
	type = 'none'
	selection = randi_range(1,3)
func _on_timer_timeout():
	self.visible = true
