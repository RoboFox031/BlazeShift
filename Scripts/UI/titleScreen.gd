extends UI


@onready var playButton = $playButton
@onready var optionsButton = $optionsButton
@onready var tutorialButton = $tutorialButton
@onready var quitButton = $quitButton

var buttons
var selected: int = 0

var basicScores = ConfigFile.new()
var ruralBoard = ConfigFile.new()
var iceBoard = ConfigFile.new()
var volcanoBoard = ConfigFile.new()

func load_game():
	var err = basicScores.load("res://basicScores.cfg")
	if err == OK:
		var score = basicScores.get_value("Hugo","time")
		print(score)
		#player.position.y = config1.get_value("player","y")
		#ship.position.x = config1.get_value("ship","x")
		#ship.position.y = config1.get_value("ship","y")
#if variables.saveNum == 2:
	#var err = config2.load("res://savegame2.cfg")
	#if err == OK:
		#player.position.x = config2.get_value("player","x")
		#player.position.y = config2.get_value("player","y")
		#ship.position.x = config2.get_value("ship","x")
		#ship.position.y = config2.get_value("ship","y")
#if variables.saveNum == 3:
	#var err = config3.load("res://savegame3.cfg")
	#if err == OK:
		#player.position.x = config3.get_value("player","x")
		#player.position.y = config3.get_value("player","y")
		#ship.position.x = config3.get_value("ship","x")
		#ship.position.y = config3.get_value("ship","y")
#timer.start(400)
	#print('works')
	pass
	
func save_game():
		basicScores.set_value('Hugo','time',int(1))
		basicScores.save('res://basicScores.cfg')
	#elif variables.saveNum == 2:
		#config2.set_value('player','x',round(player.position.x))
		#config2.set_value('player','y',round(player.position.y))
		#config2.set_value('ship','x',round(ship.position.x))
		#config2.set_value('ship','y',round(ship.position.y))
		#config2.save('res://savegame2.cfg')	
	#elif variables.saveNum == 3:
		#config3.set_value('player','x',round(player.position.x))
		#config3.set_value('player','y',round(player.position.y))
		#config3.set_value('ship','x',round(ship.position.x))
		#config3.set_value('ship','y',round(ship.position.y))
		#config3.save('res://savegame3.cfg')

func _ready():
	buttons = [playButton, optionsButton, tutorialButton, quitButton]
	changeSelectedButton(buttons[selected])
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("100"):
		globalVars.saveScores('basicTrack','HIC',str(4))
	if Input.is_action_just_pressed("200"):
		load_game()
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
		get_tree().change_scene_to_file("res://Scenes/UI/nameSelection.tscn")
	elif button == optionsButton:
		pass #put function to go to options menu here
	elif button == tutorialButton:
		get_tree().change_scene_to_file("res://Scenes/UI/leaderboard.tscn")
		pass #put function to go to tutotial level here
	else:
		get_tree().quit()
