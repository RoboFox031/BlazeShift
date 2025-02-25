extends UI
class_name coinHud

var coins: int = 0
var player

@onready var label = $label

func _process(delta: float) -> void:
	update()

func update():
	if player == 1:
		if coins == 1:
			label.text = str(globalVars.pOneCoins) + " coin"
		else:
			label.text = str(globalVars.pOneCoins) + " coins"
	if player == 2:
		if coins == 1:
			label.text = str(globalVars.pTwoCoins) + " coin"
		else:
			label.text = str(globalVars.pTwoCoins) + " coins"
