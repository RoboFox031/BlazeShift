extends pickup
class_name fireballPickup

func _ready():
	type = 'fireball'



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.currentOwner == body.playerChoices.p1:
		entered(body)
	elif body.currentOwner == body.playerChoices.p2:
		entered(body)
