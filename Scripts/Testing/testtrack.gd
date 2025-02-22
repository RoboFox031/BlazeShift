extends Node2D
class_name tracks

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loadCars()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func loadCars():
	var player1 = globalVars.playerOneCar.instantiate()
	player1.color = globalVars.playerOneColor
	player1.position.x = -520
	player1.position.y= -8
	player1.name = 'player1'
	player1.currentOwner = player1.playerChoices.p1
	var player2 = globalVars.playerTwoCar.instantiate()
	player2.color = globalVars.playerTwoColor
	player2.position.x = -520
	player2.position.y= -100
	player2.name = 'player2'
	player2.currentOwner = player2.playerChoices.p2
	add_child(player1)
	add_child(player2)
