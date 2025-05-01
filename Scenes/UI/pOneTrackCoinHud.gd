extends coinHud

func _ready():
	player = 1
	update()

func update():
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
