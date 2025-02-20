extends pickup
class_name fireball

var speed = 200
var direction

func _ready():
	type = 'fireball'
	direction = Vector2.UP.rotated(self.rotation)

func _process(delta: float) -> void:
	self.position += direction.normalized() * speed * delta


func _on_timer_timeout() -> void:
	queue_free()
