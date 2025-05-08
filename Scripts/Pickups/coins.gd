extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.currentOwner == body.playerChoices.p1:
		globalVars.pOneLastRaceCoinsCollected += 1
		globalVars.pOneTotalCoinsCollected += 1
		queue_free()
	if body.currentOwner == body.playerChoices.p2:
		globalVars.pTwoLastRaceCoinsCollected += 1
		globalVars.pTwoTotalCoinsCollected += 1
		queue_free()
	#globalVars.p1Coin
	pass # Replace with function body.
