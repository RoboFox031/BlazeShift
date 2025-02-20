extends pickup
class_name fireballPickup

func _ready():
	type = 'fireball'



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is playerOneCar:
		entered(body)
	elif body is playerTwoCar:
		entered(body)
