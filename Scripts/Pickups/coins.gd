extends Area2D

@onready var timer = $timer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(monitoring)
	pass


func _on_body_entered(body: Node2D) -> void:
	#Makes sure the body is a car
	if body is Car:
		#Adds 1 coin to the correct player
		if body.currentOwnerStr == 'p1':
			globalVars.pOneLastRaceCoinsCollected += 1
		elif body.currentOwnerStr == 'p2':
			globalVars.pTwoLastRaceCoinsCollected += 1
		#Hides, disables colision, and starts the respawn timer
		visible=false
		set_deferred("monitoring",false)
		timer.start()



func _on_timer_timeout() -> void:
	visible = true
	monitoring=true
	pass
	
	
