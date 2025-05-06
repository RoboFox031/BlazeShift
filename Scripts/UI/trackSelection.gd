extends UI
class_name trackSelection

@onready var mapOne = $mapOne
@onready var mapTwo = $mapTwo
@onready var mapThree = $mapThree
@onready var mapFour = $mapFour
@onready var mapFive = $mapFive

@onready var sfx = $uiSFX

var maps: Array
var tracks: Array
var trackNames: Array = ['basic', 'rural', 'ice', 'volcano', 'testing']

var selected = 0

func _ready() -> void:
	maps = [mapOne, mapTwo, mapThree, mapFour, mapFive]
	tracks = [preload("res://Scenes/Tracks/basicTrack.tscn"),preload("res://Scenes/Tracks/ruralTrack.tscn"),preload("res://Scenes/Tracks/iceTrack.tscn"),preload("res://Scenes/Tracks/volcanoTrack.tscn"),preload("res://Scenes/Testing/testing_racetrack.tscn")]
	_updateMapSelected(maps[selected])
	var mapNum = 0
	for m in maps:
		if trackNames[mapNum] in globalVars.mapsPlayed:
			m.get_child(1).visible = true
		else:
			m.get_child(1).visible = false
		mapNum += 1

func _process(delta: float) -> void:
	if selected >= 0 and Input.is_action_just_pressed("p" + str(globalVars.nextMapSelector) + "_start"):
		if trackNames[selected] not in globalVars.mapsPlayed:
			$uiSFX.playSelectSound()
			await get_tree().create_timer(0.5).timeout 
			globalVars.track = tracks[selected]
			globalVars.mapsPlayed.append(maps[selected])
			get_tree().change_scene_to_file("res://Scenes/Tracks/trackLoader.tscn")
	if Input.is_action_just_pressed("p" + str(globalVars.nextMapSelector) + "_right"):
		if selected + 1 < len(maps):
			selected += 1
		else:
			selected = 0
		_updateMapSelected(maps[selected])
	elif Input.is_action_just_pressed("p" + str(globalVars.nextMapSelector) + "_left"):
		if selected - 1 >= 0:
			selected -= 1
		else:
			selected = len(maps) - 1
		_updateMapSelected(maps[selected])
		
	if Input.is_action_just_pressed("p1_b") or Input.is_action_just_pressed('p2_b'):
		$selectSound.play()
		await get_tree().create_timer(0.5).timeout 
		get_tree().change_scene_to_file("res://Scenes/UI/upgradeShop.tscn")

func _updateMapSelected(map):
	sfx.playCursorMoveSound()
	for m in maps:
		if m == map: ###Change this later when I have map preveiw sprites
			m.get_child(0).visible = true
			$trackSelectionLabel.text = 'press start to play ' + trackNames[selected] + ' map'
		else:
			m.get_child(0).visible = false
