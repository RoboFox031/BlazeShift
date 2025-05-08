extends ProgressBar
class_name sliderTemplate
@onready var tick = $tick

var selected = false

func _ready():
	tick.position.x = value*10.84

func _input(event):
	if Input.is_action_just_pressed('p1_left') or Input.is_action_just_pressed('p2_left'):
		if selected == true:
			value -= 10
			print(value)
			tick.position.x = value*10.84
	elif Input.is_action_just_pressed('p1_right') or Input.is_action_just_pressed('p2_right'):
		if selected == true:
			value += 10
			tick.position.x = value*10.84
