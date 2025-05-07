extends pickup
class_name snowball

var spawnPosition
var speed = 750
var direction 
@onready var sprite = $animatedSprite2d
var ignore
func _ready():
	type = 'snowball'
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
			get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/snowballSplatter").splatter()
		if body.currentOwnerStr == 'p2':
			get_node('/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/snowballSplatter').splatter()
		queue_free()
