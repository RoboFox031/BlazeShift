extends pickup
class_name pickupBox

@onready var animatedSprite = $animatedSprite2d
@onready var powerupTimer = $timer
var selection = randf()

func ready():
	animatedSprite.play('Idle')
		

func _on_body_entered(body: Node2D) -> void:
	#Makes sure the body is a car
	if body is Car:
		if type == 'none' or type == "" or type == null:
			if selection>.10 and selection<=.30:
				type = 'fireballPickup'
				entered(body)
			elif selection>.65 and selection<=1:
				type = 'blazePickup'
				entered(body)
			elif selection>0 and selection<=.10:
				type = 'roadSpikesPickup'
				entered(body)
			elif selection>.30 and selection<=.50:
				type = 'snowballPickup'
				entered(body)
			elif selection>.50 and selection<=.65:
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
	selection = randf()
