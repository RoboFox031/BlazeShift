extends UI
class_name coinHud

var coins: int = 0
var player

@export var mode=modeOptions.race
enum modeOptions{shop,race}
@onready var label = $label

func _ready() -> void:
	update()

func _process(delta):
	update()

func update():
	if mode==modeOptions.race:
		if player == 1:
			if coins == 1:
				label.text = str(globalVars.pOneLastRaceCoinsCollected) + " coin"
			else:
				label.text = str(globalVars.pOneLastRaceCoinsCollected) + " coins"
		if player == 2:
			if coins == 1:
				label.text = str(globalVars.pTwoLastRaceCoinsCollected) + " coin"
			else:
				label.text = str(globalVars.pTwoLastRaceCoinsCollected) + " coins"
	elif mode==modeOptions.shop:
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
		
