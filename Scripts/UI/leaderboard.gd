extends UI
class_name leaderboard

var arrowSelected = 'right'
var leaderboardOptions = ['basic track','rural track','ice track','volcano track','testing track','overall']
var leaderboardSelected = 0

@onready var scroll = $scrollContainer
@onready var time1 = $scrollContainer/vBoxContainer/leaderboardLabel

func _ready():
	_updateArrows()
	_updateLabel()
	_updateLeaderboard()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('p1_b') or Input.is_action_just_pressed('p2_b'):
		get_tree().change_scene_to_file("res://Scenes/UI/titleScreen.tscn")
	if (Input.is_action_pressed('p1_up')) or (Input.is_action_pressed('p2_up')):
		scroll.scroll_vertical -= 5
		pass
	if (Input.is_action_pressed('p1_down')) or (Input.is_action_pressed('p2_down')) and scroll.scroll_vertical < 520:
		scroll.scroll_vertical += 5
	
	if (Input.is_action_just_pressed('p1_right')) or (Input.is_action_just_pressed('p2_right')):
		if arrowSelected != 'right':
			arrowSelected = 'right'
			_updateArrows()
	if (Input.is_action_just_pressed("p1_left")) or (Input.is_action_just_pressed("p2_left")):
		if arrowSelected != 'left':
			arrowSelected = 'left'
			_updateArrows()
	
	if Input.is_action_just_pressed("p1_a") or Input.is_action_just_pressed("p2_a"):
		if arrowSelected == 'right':
			if leaderboardSelected + 1 >= len(leaderboardOptions):
				leaderboardSelected = 0
			else:
				leaderboardSelected += 1
		else:
			if leaderboardSelected - 1 < 0:
				leaderboardSelected = len(leaderboardOptions)-1
			else:
				leaderboardSelected -= 1
		_updateLabel()
		_updateLeaderboard()
				
func _updateArrows():
	if arrowSelected == 'right':
		$arrows/leftArrow/leftArrowOutline.visible = false
		$arrows/rightArrow/rightArrowOutline.visible = true
		$arrows/leftArrow.stopFlashing()
		$arrows/rightArrow.startFlashing()
	else:
		$arrows/leftArrow/leftArrowOutline.visible = true
		$arrows/rightArrow/rightArrowOutline.visible = false
		$arrows/leftArrow.startFlashing()
		$arrows/rightArrow.stopFlashing()
	
func _updateLabel():
	$trackLabel.text = leaderboardOptions[leaderboardSelected]
	
func _updateLeaderboard():
	if leaderboardSelected == 0:
		_updateTime('basicTrack')
	elif leaderboardSelected == 1:
		_updateTime('ruralTrack')
		pass
	elif leaderboardSelected == 2:
		_updateTime('iceTrack')
		pass
	elif leaderboardSelected == 3:
		_updateTime('volcanoTrack')
		pass
	elif leaderboardSelected == 4:
		print('testingTrack')
		pass
	elif leaderboardSelected == 5:
		print('overall')
		pass
	pass

func _updateTime(trackName):
	var scores = globalVars.loadScores(trackName)
	print(scores)
	var loops = 10
	time1.text = ''
	if scores:
		for key in scores:
			if loops > 0:
				time1.text +=  key+': ' + str(globalVars.convertSec(scores[key])) + '\n'
				loops -= 1
				continue
	while loops > 0:
		time1.text += 'XXX: 00:00.000\n'
		loops -= 1
	pass	
