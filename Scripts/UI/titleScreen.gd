extends UI


@onready var playButton = $playButton
@onready var optionsButton = $optionsButton
@onready var tutorialButton = $tutorialButton
@onready var quitButton = $quitButton

var buttons
var selected: int = 0

var basicBoard = ConfigFile.new()
var ruralBoard = ConfigFile.new()
var iceBoard = ConfigFile.new()
var volcanoBoard = ConfigFile.new()

func _ready():
	buttons = [playButton, optionsButton, tutorialButton, quitButton]
	changeSelectedButton(buttons[selected])
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("p1_down"):
		if selected < 3:
			selected += 1
		else:
			selected = 0
		changeSelectedButton(buttons[selected])
	elif Input.is_action_just_pressed("p1_up"):
		if selected-1 >= 0:
			selected -= 1
		else:
			selected = 3
		changeSelectedButton(buttons[selected])
	if Input.is_action_just_pressed("p1_start"):
		buttonPressed(buttons[selected])

func changeSelectedButton(button):
	for b in buttons:
		if b == button:
			b.scale.x = 1.15
			b.scale.y = 1.15
		else:
			b.scale.x = 1
			b.scale.y = 1

func buttonPressed(button):
	if button == playButton:
		get_tree().change_scene_to_file("res://Scenes/UI/shop.tscn")
	elif button == optionsButton:
		pass #put function to go to options menu here
	elif button == tutorialButton:
		pass #put function to go to tutotial level here
	else:
		get_tree().quit()
