extends pickup
class_name pickupBox

@onready var animatedSprite = $animatedSprite2d
@onready var powerupTimer = $timer
var selection = randi_range(1,5)

func ready():
	animatedSprite.play('Idle')
		

func _on_body_entered(body: Node2D) -> void:
	#Makes sure the body is a car
	if body is Car:
		if type == 'none' or type == "" or type == null:
			print(type)
			if selection == 1:
				type = 'fireballPickup'
				entered(body)
			elif selection == 2:
				type = 'blazePickup'
				entered(body)
			elif selection == 3:
				type = 'roadSpikesPickup'
				entered(body)
			elif selection == 4:
				type = 'snowballPickup'
				entered(body)
			elif selection == 5:
				type = 'fireCyclonePickup'
				entered(body)
		if self.visible == false and globalVars.pOnePowerup != 'none' or globalVars.pTwoPowerup != 'none':
			entered(body)
		#hide, disable colision, and start the respawn timer
		powerupTimer.start()
		self.set_deferred("monitoring",false)
		self.visible = false
		
		
		
func _on_timer_timeout():
	type = 'none'
	self.visible = true
	self.monitoring = true
	#selection = randi_range(1,5)
	selection=3
