extends UI


@onready var playButton = $playButton
@onready var optionsButton = $optionsButton
@onready var tutorialButton = $tutorialButton
@onready var quitButton = $quitButton
@onready var controlsButton = $controlsButton

var buttons
var selected: int = 0

func _ready():
	buttons = [playButton, optionsButton, tutorialButton, controlsButton, quitButton]
	changeSelectedButton(buttons[selected])
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("p1_down"):
		if selected < 4:
			selected += 1
		else:
			selected = 0
		changeSelectedButton(buttons[selected])
	elif Input.is_action_just_pressed("p1_up"):
		if selected-1 >= 0:
			selected -= 1
		else:
			selected = 4
		changeSelectedButton(buttons[selected])
	if Input.is_action_just_pressed("p1_start"):
		buttonPressed(buttons[selected])

func changeSelectedButton(button):
	$uiSFX.playCursorMoveSound()
	for b in buttons:
		if b == button:
			b.scale.x = 1.15
			b.scale.y = 1.15
			b.get_child(0).add_theme_color_override('font_outline_color', Color(0,0,0))
			b.get_child(0).add_theme_constant_override('outline_size', 20)
			b.startFlashing()
		else:
			b.scale.x = 1
			b.scale.y = 1
			b.get_child(0).add_theme_constant_override('outline_size', 0)
			b.stopFlashing()

func buttonPressed(button):
	$uiSFX.playSelectSound()
	await get_tree().create_timer(0.5).timeout 
	if button == playButton:
		get_tree().change_scene_to_file("res://Scenes/UI/nameSelection.tscn")
	elif button == optionsButton:
		get_tree().change_scene_to_file("res://Scenes/UI/optionsScreen.tscn")
	elif button == tutorialButton:
		get_tree().change_scene_to_file("res://Scenes/UI/leaderboard.tscn")
	elif button == controlsButton:
		get_tree().change_scene_to_file("res://Scenes/UI/controlScreen.tscn")
	else:
		get_tree().quit()
