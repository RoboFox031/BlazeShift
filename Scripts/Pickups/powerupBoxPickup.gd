extends pickup


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.currentOwner == body.playerChoices.p1:
		entered(body)
	elif body.currentOwner == body.playerChoices.p2:
		entered(body)
	pass # Replace with function body.
