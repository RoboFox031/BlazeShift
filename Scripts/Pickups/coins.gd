extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	print(body.playerNum)
	if body.playerNum == 1:
		globalVars.p1Coin += 1
		print('player1: '+str(globalVars.p1Coin))
		queue_free()
	if body.playerNum == 2:
		globalVars.p2Coin += 1
		print('player2: '+str(globalVars.p2Coin))
		queue_free()
	#globalVars.p1Coin
	pass # Replace with function body.
