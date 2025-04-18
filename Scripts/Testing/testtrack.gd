extends Node2D
class_name tracks
#stores where the player's spawn in at
var p1Start:Vector2
var p2Start:Vector2
#Stores the player starting rotation
var playerRotation=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loadCars()
	pass # Replace with function body.




func loadCars():
	var player1 = globalVars.playerOneCar.instantiate()
	player1.color = globalVars.playerOneColor
	player1.position=p1Start
	player1.rotation_degrees=playerRotation
	player1.name = 'player1'
	player1.currentOwner = player1.playerChoices.p1
	#player1.scale = Vector2(.3,.3)
	var player2 = globalVars.playerTwoCar.instantiate()
	player2.color = globalVars.playerTwoColor
	player2.position=p2Start
	player2.rotation_degrees=playerRotation
	player2.name = 'player2'
	player2.currentOwner = player2.playerChoices.p2
	add_child(player1)
	add_child(player2)
