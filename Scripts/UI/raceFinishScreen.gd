extends UI
class_name raceFinishScreen

var pOneLabels = []
var pTwoLabels = []

var labelNames = ['completion time: ', 'coins collected: ', 'race placement: ', 'overall placement: ']

var pOneInfo = [0,0,0,0]
var pTwoInfo = [0,0,0,0]

var pOneReady = false
var pTwoReady = false

var reward = 5

@onready var winner = $backGroundStuff/label

func _ready():
	
	for label in $playerOneLabels.get_children():
		pOneLabels.append(label)
	for label in $playerTwoLabels.get_children():
		pTwoLabels.append(label)
	
	if globalVars.pOneLastRacePlacement == '1st':
		winner.text = 'player '+globalVars.pOneName+' won the race'
		globalVars.winner = 'player1'
		globalVars.pOneCoins += 5
		$confetti3.emitting = true
		$confetti4.emitting = true
		
		globalVars.pOneTotalCoinsCollected += reward
	else:
		winner.text = 'player '+globalVars.pTwoName+' won the race'
		globalVars.pTwoCoins += 5
		globalVars.pTwoTotalCoinsCollected += reward
		globalVars.winner = 'player2'
		$confetti.emitting = true
		$confetti2.emitting = true
		
	pOneInfo[0] = globalVars.convertSec(globalVars.pOneLastRaceTime)
	pOneInfo[1] = globalVars.pOneLastRaceCoinsCollected
	pOneInfo[2] = globalVars.pOneLastRacePlacement
	pOneInfo[3] = globalVars.pOneOverallPlacement
	
	pTwoInfo[0] = globalVars.convertSec(globalVars.pTwoLastRaceTime)
	pTwoInfo[1] = globalVars.pTwoLastRaceCoinsCollected
	pTwoInfo[2] = globalVars.pTwoLastRacePlacement
	pTwoInfo[3] = globalVars.pTwoOverallPlacement
	
	_updateCoins()
	_updateLabels()
	_updateReady()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("p1_start"):
		if pOneReady == false:
			pOneReady = true
		else:
			pOneReady = false
		_updateReady()
	if Input.is_action_just_pressed("p2_start"):
		if pTwoReady == false:
			pTwoReady = true
		else:
			pTwoReady = false
		_updateReady()

func _updateLabels():
	var x = 0
	var y = 0
	for label in pOneLabels:
		label.text = labelNames[x] + str(pOneInfo[x])
		x += 1
	for label in pTwoLabels:
		label.text = labelNames[y] + str(pTwoInfo[y])
		y += 1
		
func _updateReady():
	if pOneReady == true:
		$pOneReadyLabel.visible = true
	else:
		$pOneReadyLabel.visible = false
	if pTwoReady == true:
		$pTwoReadyLabel.visible = true
	else:
		$pTwoReadyLabel.visible = false
	if pOneReady == true and pTwoReady == true:
		if (globalVars.pOneTotalWins + globalVars.pTwoTotalWins) >= 5:
			globalVars.resetRaceVars()
			get_tree().change_scene_to_file('res://Scenes/UI/finalScreen.tscn')
		else:
			globalVars.resetRaceVars()
			get_tree().change_scene_to_file('res://Scenes/UI/shop.tscn')
		
func _updateCoins():
	globalVars.pOneCoins += globalVars.pOneLastRaceCoinsCollected
	globalVars.pTwoCoins += globalVars.pTwoLastRaceCoinsCollected
	globalVars.pOneTotalCoinsCollected += globalVars.pOneLastRaceCoinsCollected
	globalVars.pTwoTotalCoinsCollected += globalVars.pTwoLastRaceCoinsCollected
	print(globalVars.pOneCoins)
	print(globalVars.pTwoCoins)

func _updateConfetti():
	if globalVars.pOneLastRacePlacement == '1st':
		print('emit')
		$confetti3.emitting = true
		$confetti4.emitting = true
	if globalVars.pTwoLastRacePlacement == '1st':
		print('emit')
		$confetti.emitting = true
		$confetti1.emitting = true
