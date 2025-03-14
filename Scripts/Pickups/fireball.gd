extends pickup
class_name fireball

var speed = 750
var direction

func _ready():
	type = 'fireball'
	direction = Vector2.RIGHT.rotated(self.rotation)

func _process(delta: float) -> void:
	self.position += direction.normalized() * speed * delta


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != get_parent() and body is Car:
		pass ####add damaging or negative effect function here
