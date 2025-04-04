extends UI
class_name trackSelection

@onready var mapOne = $mapOne
@onready var mapTwo = $mapTwo
@onready var mapThree = $mapThree
@onready var mapFour = $mapFour
@onready var mapFive = $mapFive

var maps: Array
var tracks: Array
var trackNames: Array = ['basic', 'rural', 'ice', 'volcano', 'testing']

var selected = 0

func _ready() -> void:
	maps = [mapOne, mapTwo, mapThree, mapFour, mapFive]
	tracks = [preload("res://Scenes/Tracks/basicTrack.tscn"),preload("res://Scenes/Tracks/ruralTrack.tscn"),preload("res://Scenes/Tracks/iceTrack.tscn"),preload("res://Scenes/Tracks/volcanoTrack.tscn"),preload("res://Scenes/Testing/testing_racetrack.tscn")]
	_updateMapSelected(maps[selected])

func _process(delta: float) -> void:
	if selected >= 0 and Input.is_action_just_pressed("p1_start"):
		globalVars.track = tracks[selected]
		get_tree().change_scene_to_file("res://Scenes/Tracks/trackLoader.tscn")
	if Input.is_action_just_pressed("p1_right"):
		if selected + 1 < len(maps):
			selected += 1
		else:
			selected = 0
		_updateMapSelected(maps[selected])
	elif Input.is_action_just_pressed("p1_left"):
		if selected - 1 >= 0:
			selected -= 1
		else:
			selected = len(maps) - 1
		_updateMapSelected(maps[selected])
		
	if Input.is_action_just_pressed("p1_b"):
		get_tree().change_scene_to_file("res://Scenes/UI/upgradeShop.tscn")

func _updateMapSelected(map):
	for m in maps:
		if m == map: ###Change this later when I have map preveiw sprites
			m.get_child(0).visible = true
			$trackSelectionLabel.text = 'press start to play ' + trackNames[selected] + ' map'
		else:
			m.get_child(0).visible = false
