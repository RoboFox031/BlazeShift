extends UI
class_name finalScreen

#arrays to store label nodes
var pOneLabels: Array = []
var pTwoLabels: Array = []

func _ready() -> void:
	#refrence to player one labels
	for label in $playerOneLabels.get_children():
		pOneLabels.append(label)
	#refrence to player two labels
	for label in $playerTwoLabels.get_children():
		pTwoLabels.append(label)
	_updateLabels()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('p1_start') or Input.is_action_just_pressed('p2_start'):
		_startNewGame()

func _updateLabels():
	#update player one labels
	pOneLabels[0].text = "final coins collected: " + str(globalVars.pOneCoins)
	pOneLabels[1].text =  "total coins collected: " + str(globalVars.pOneTotalCoinsCollected)
	pOneLabels[2].text = "overall placement: " + globalVars.pOneOverallPlacement
	pOneLabels[3].text = "total wins: " + str(globalVars.pOneTotalWins)
	#upadte player two labels
	pTwoLabels[0].text = "final coins collected: " + str(globalVars.pTwoCoins)
	pTwoLabels[1].text =  "total coins collected: " + str(globalVars.pTwoTotalCoinsCollected)
	pTwoLabels[2].text = "overall placement: " + globalVars.pTwoOverallPlacement
	pTwoLabels[3].text = "total wins: " + str(globalVars.pTwoTotalWins)
	
	if globalVars.pOneOverallPlacement == '1st':
		$confetti3.emitting = true
		$confetti4.emitting = true
	else:
		$confetti.emitting = true
		$confetti2.emitting = true

func _startNewGame():
	globalVars.gameReset()
	get_tree().change_scene_to_file('res://Scenes/UI/titleScreen.tscn')
