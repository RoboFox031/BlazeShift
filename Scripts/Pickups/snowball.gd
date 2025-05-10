extends powerUp

var speed = 750
func _ready():
	#type = 'snowball'
	self.position=spawnPosition
	self.z_index = 10
	sprite.rotation = direction
func _process(delta):
	self.position += Vector2(speed * delta*cos(direction),speed*delta*sin(direction))
func _on_timer_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Car):
	if body != ignore and body is Car:
		if body.currentOwnerStr == 'p1':
			#var pos = get_node('/root/trackLoader/hSplitContainer/subViewportContainer/snowballPort/camera2d').position
			get_node("/root/trackLoader/hSplitContainer/subViewportContainer/snowballPort/snowballSplatter").splatter()
		if body.currentOwnerStr == 'p2':
			get_node('/root/trackLoader/hSplitContainer/subViewportContainer2/snowballPort/snowballSplatter').splatter()
		queue_free()
