extends Node2D

@onready var timer = $timer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	timer.start()
	if body.currentOwner == body.playerChoices.p1:
		globalVars.pOneLastRaceCoinsCollected += 1
		self.visible = false
	if body.currentOwner == body.playerChoices.p2:
		globalVars.pTwoLastRaceCoinsCollected += 1
		self.visible = false
	if self.visible == false:
		pass
	#globalVars.p1Coin
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	self.visible = true
	
