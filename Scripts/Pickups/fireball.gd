extends pickup
class_name fireball

var spawnPosition
var speed = 750
var direction 
@onready var sprite = $animatedSprite2d
func _ready():
	type = 'fireball'
	self.position=spawnPosition
	self.z_index = 10
	sprite.rotation = direction
func _process(delta):
	self.position += Vector2(speed * delta*cos(direction),speed*delta*sin(direction))
	print(direction)

func _on_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != get_parent() and body is Car:
		pass ####add damaging or negative effect function here
