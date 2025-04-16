extends tracks


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#updates the start position
	p1Start=Vector2(1900,-1100)
	p1Start=Vector2(1900,-1300)
	#spawns in cars
	loadCars()
	pass # Replace with function body.
