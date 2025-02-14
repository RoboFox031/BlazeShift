extends UI
class_name coinHud

var playerId = null

@onready var label = $label

func _process(delta: float) -> void:
	update()

func update():
	if playerId == 1:
		label.text = str(globalVars.p1Coin) + " coin"
	elif playerId == 2:
		label.text = str(globalVars.p2Coin) + " coin"
