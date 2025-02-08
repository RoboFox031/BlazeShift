extends UI
class_name trackSelection

@onready var mapOne = $mapOne
@onready var mapTwo = $mapTwo
@onready var mapThree = $mapThree
@onready var mapFour = $mapFour
@onready var mapFive = $mapFive

var maps: Array

var selected = 0

func _ready() -> void:
	maps = [mapOne, mapTwo, mapThree, mapFour, mapFive]
	_updateMapSelected(maps[selected])

func _process(delta: float) -> void:
	if selected == 0 and Input.is_action_just_pressed("p1_start"):
		globalVars.track = preload("res://Scenes/Testing/testing_racetrack.tscn")
		get_tree().change_scene_to_file("res://Scenes/Testing/trackLoader.tscn")

	if Input.is_action_just_pressed("p1_right"):
		if selected + 1 < len(maps):
			selected += 1
		else:
			selected = 0
		_updateMapSelected(maps[selected])
		print(selected)
	elif Input.is_action_just_pressed("p1_left"):
		if selected - 1 >= 0:
			selected -= 1
		else:
			selected = len(maps) - 1
		_updateMapSelected(maps[selected])
		print(selected)

func _updateMapSelected(map):
	for m in maps:
		if m == map: ###Change this later when I have map preveiw sprites
			m.scale.x = 1.15
			m.scale.y = 1.15
		else:
			m.scale.x = 1
			m.scale.y = 1
