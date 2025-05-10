extends UI
class_name nameSelection

var bannedWords = []

var playerOneReady = false
var playerTwoReady = false

var pOneName = 'aaa'
var pTwoName = 'aaa'

var pOneCharacterSelected = 0
var pTwoCharacterSelected = 0

var pOneSelected = 0
var pTwoSelected = 0

var pOneSlotSelected = 0
var pTwoSlotSelected = 0

var letters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

var pOneLabels = []
var pTwoLabels = []

var pOneUpArrows = []
var pTwoUpArrows = []

var pOneDownArrows = []
var pTwoDownArrows = []

func _ready() -> void:
	globalVars.musicType = 'royaltyMusic'
	for a in $nameSelection/pOneNameSelection.get_children():
		pOneLabels.append(a)
		_updateCharacterDisplays()
	for a in $nameSelection/pTwoNameSelection.get_children():
		pTwoLabels.append(a)
	for a in $arrows/pOneArrows/upArrows.get_children():
		pOneUpArrows.append(a)
	for a in $arrows/pOneArrows/downArrows.get_children():
		pOneDownArrows.append(a)
	for a in $arrows/pTwoArrows/upArrows.get_children():
		pTwoUpArrows.append(a)
	for a in $arrows/pTwoArrows/downArrows.get_children():
		pTwoDownArrows.append(a)

	_updateCharacterDisplays()
	_updateArrows()
	_updateNameStrings()
	_loadBadWords()
	_updateCleanNameLabels('one')
	_updateCleanNameLabels('two')
	
func _process(delta: float) -> void:
	if playerOneReady == false:
		if Input.is_action_just_pressed('p1_down'):
			if pOneSelected + 1 > len(letters)-1:
				pOneSelected = 0
			else:
				pOneSelected += 1
			_updateCharacterDisplays()
			_updateNameStrings()
		if Input.is_action_just_pressed('p1_up'):
			if pOneSelected + 1 < 0:
				pOneSelected = len(letters)-1
			else:
				pOneSelected -= 1
			_updateCharacterDisplays()
			_updateNameStrings()
		if Input.is_action_just_pressed('p1_right'):
			if pOneSlotSelected + 1 > len(pOneLabels) -1:
				pOneSlotSelected = 0
			else:
				pOneSlotSelected += 1
			pOneSelected = letters.find(pOneLabels[pOneSlotSelected].text)#set the selected letter to the next slot
			_updateCharacterDisplays()
			_updateArrows()
		if Input.is_action_just_pressed('p1_left'):
			if pOneSlotSelected - 1 < 0:
				pOneSlotSelected = len(pOneLabels) - 1
			else:
				pOneSlotSelected -= 1
			pOneSelected = letters.find(pOneLabels[pOneSlotSelected].text)#set the selected letter to the next slot
			_updateCharacterDisplays()
			_updateArrows()
	#checks to see if ready
	if Input.is_action_just_pressed('p1_start'):
		if _checkCleanName(pOneName) == true:
			if playerOneReady == false:
				playerOneReady = true
			else:
				playerOneReady = false
		else:
			playerOneReady = false
		_updateCleanNameLabels('one')
		_updateReadyScreen()
	if playerTwoReady == false:
		if Input.is_action_just_pressed('p2_down'):
			if pTwoSelected + 1 > len(letters)-1:
				pTwoSelected = 0
			else:
				pTwoSelected += 1
			_updateCharacterDisplays()
			_updateNameStrings()
		if Input.is_action_just_pressed('p2_up'):
			if pTwoSelected + 1 < 0:
				pTwoSelected = len(letters)-1
			else:
				pTwoSelected -= 1
			_updateCharacterDisplays()
			_updateNameStrings()
		if Input.is_action_just_pressed('p2_right'):
			if pTwoSlotSelected + 1 > len(pTwoLabels) -1:
				pTwoSlotSelected = 0
			else:
				pTwoSlotSelected += 1
			pTwoSelected = letters.find(pTwoLabels[pTwoSlotSelected].text)#set the selected letter to the next slot
			_updateCharacterDisplays()
			_updateArrows()
		if Input.is_action_just_pressed('p2_left'):
			if pTwoSlotSelected - 1 < 0:
				pTwoSlotSelected = len(pTwoLabels) - 1
			else:
				pTwoSlotSelected -= 1
			pTwoSelected = letters.find(pTwoLabels[pTwoSlotSelected].text)#set the selected letter to the next slot
			_updateCharacterDisplays()
			_updateArrows()
	#updates ready screen
	if Input.is_action_just_pressed('p2_start'):
		if _checkCleanName(pTwoName) == true:
			if playerTwoReady == false:
				playerTwoReady = true
			else:
				playerTwoReady = false
		else:
			playerTwoReady = false
		_updateCleanNameLabels('two')
		_updateReadyScreen()
		
func _updateCharacterDisplays():
	$uiSFX.playCursorMoveSound()
	for label in pOneLabels:
		if label == pOneLabels[pOneSlotSelected]:
			label.add_theme_color_override("font_outline_color", Color.BLACK)
			label.add_theme_constant_override("outline_size", 30)
			label.startFlashing()
		else:
			label.add_theme_color_override("font_outline_color", Color.WHITE)
			label.add_theme_constant_override("outline_size", 1)
			label.stopFlashing()
	for label in pTwoLabels:
		if label == pTwoLabels[pTwoSlotSelected]:
			label.add_theme_color_override("font_outline_color", Color.BLACK)
			label.add_theme_constant_override("outline_size", 30)
			label.startFlashing()
		else:
			label.add_theme_color_override("font_outline_color", Color.WHITE)
			label.add_theme_constant_override("outline_size", 1)
			label.stopFlashing()
	pOneLabels[pOneSlotSelected].text = letters[pOneSelected]
	if len(pTwoLabels) > 1:
		pTwoLabels[pTwoSlotSelected].text = letters[pTwoSelected]
		
func _updateArrows():
	$uiSFX.playCursorMoveSound()
	for arrow in pOneUpArrows:
		if arrow == pOneUpArrows[pOneSlotSelected]:
			arrow.visible = true
		else:
			arrow.visible = false
	for arrow in pOneDownArrows:
		if arrow == pOneDownArrows[pOneSlotSelected]:
			arrow.visible = true
		else:
			arrow.visible = false
	for arrow in pTwoUpArrows:
		if arrow == pTwoUpArrows[pTwoSlotSelected]:
			arrow.visible = true
		else:
			arrow.visible = false
	for arrow in pTwoDownArrows:
		if arrow == pTwoDownArrows[pTwoSlotSelected]:
			arrow.visible = true
		else:
			arrow.visible = false

func _updateNameStrings():
	pOneName = pOneLabels[0].text + pOneLabels[1].text + pOneLabels[2].text
	pTwoName = pTwoLabels[0].text + pTwoLabels[1].text + pTwoLabels[2].text
	globalVars.pOneName = pOneName
	globalVars.pTwoName = pTwoName
func _loadBadWords():
	var file = FileAccess.open("res://badWords.txt", FileAccess.READ)
	if file:
		while not file.eof_reached():
			var word = file.get_line().strip_edges()  # Read and clean each word
			if word != "":
				bannedWords.append(word)
		file.close()
		
func _checkCleanName(name):
	if globalVars.pOneName == name:
		if name in bannedWords:
			return false
		else:
			return true
	if globalVars.pTwoName == name:
		if name in bannedWords:
			return false
		else:
			return true


func _updateReadyScreen():
	if playerOneReady == true:
		$playerOneReadyLabel.text = 'confirmed press start again to undo'
		$playerOneReadyLabel.add_theme_color_override("font_color",Color.GREEN)
	else:
		$playerOneReadyLabel.text = 'press start to confirm'
		$playerOneReadyLabel.add_theme_color_override("font_color",Color.WHITE)
	if playerTwoReady == true:
		$playerTwoReadyLabel.text = 'confirmed press start again to undo'
		$playerTwoReadyLabel.add_theme_color_override("font_color", Color.GREEN)
	else:
		$playerTwoReadyLabel.text = 'press start to confirm'
		$playerTwoReadyLabel.add_theme_color_override("font_color",Color.WHITE)
		
	if playerOneReady == true and playerTwoReady == true:
		$uiSFX.playSelectSound()
		await get_tree().create_timer(0.5).timeout 
		globalVars.pOneName = pOneName
		globalVars.pTwoName = pTwoName
		get_tree().change_scene_to_file("res://Scenes/UI/shop.tscn")

func _updateCleanNameLabels(player):
	if _checkCleanName(pOneName) == true and player == 'one':
		$playerOneCleanNameLabel.visible = false
	elif _checkCleanName(pOneName) == false and player == 'one':
		$playerOneCleanNameLabel.visible = true
	if _checkCleanName(pTwoName) == true and player == 'two' :
		$playerTwoCleanNameLabel.visible = false
	elif _checkCleanName(pTwoName) == false and player == 'two':
		$playerTwoCleanNameLabel.visible = true
