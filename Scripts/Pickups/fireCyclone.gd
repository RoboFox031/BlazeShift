extends powerUp

func _ready():
	$animatedSprite2d.play("default")
	$timer.start(5)
	#type = 'fireCyclone'
	#self.position = spawnPosition
	#self.z_index = 10
	#self.sprite.rotation = direction
	pass
func _process(delta):
	self.position
	self.rotation += .05

func _on_area_2d_body_entered(body):
	print(body)
	if body != ignore and body is powerUp:
		body.queue_free()
		
	


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
