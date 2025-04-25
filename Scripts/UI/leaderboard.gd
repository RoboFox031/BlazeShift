extends UI
class_name leaderboard

var arrowSelected = 'right'
var leaderboardOptions = ['basic track','rural track','ice track','volcano track','testing track','overall']
var leaderboardSelected = 0

var placeStart = 0

func _ready():
	_updateArrows()
	_updateLabel()
	_updateLeaderboard()

func _process(delta: float) -> void:
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
	if Input.is_action_just_pressed('p1_down') or Input.is_action_just_pressed('p2_down'):
		_scroll()
				
func _updateArrows():
	if arrowSelected == 'right':
		$arrows/leftArrow/leftArrowOutline.visible = false
		$arrows/rightArrow/rightArrowOutline.visible = true
	else:
		$arrows/leftArrow/leftArrowOutline.visible = true
		$arrows/rightArrow/rightArrowOutline.visible = false
	
func _updateLabel():
	$trackLabel.text = leaderboardOptions[leaderboardSelected]
	
func _updateLeaderboard():
	pass
	
func _scroll():
	pass
