extends UI
class_name controlScreen

@export var inPauseMenu = false

var pausedToControls = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('p1_b') or Input.is_action_just_pressed('p2_b'):
		if inPauseMenu == false:
			get_tree().change_scene_to_file('res://Scenes/UI/titleScreen.tscn')
		elif pausedToControls == true:
			self.visible = false
			pausedToControls = false
