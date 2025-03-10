extends Node2D
 
var inControl: int = 0

var selected: int = 0
var options = ['resume', 'options', 'return to menu']

func _ready():
	_updateMenu()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("p1_start"):
		inControl = 1 
		_updateMenu()
	elif Input.is_action_just_pressed("p2_start"):
		inControl = 2
		_updateMenu()
		
func _updateMenu():
	if inControl != 0:
		self.visible = true
	else:
		self.visible = false
