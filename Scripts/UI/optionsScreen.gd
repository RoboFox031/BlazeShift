extends UI
class_name optionsScreen

var selected = 1 #0 is music slider and 1 is sfx slider

func _ready() -> void:
	_updateSelected()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed('p1_b') or Input.is_action_just_pressed('p2_b'):
		get_tree().change_scene_to_file("res://Scenes/UI/titleScreen.tscn")
	if (Input.is_action_just_pressed('p1_down') or Input.is_action_just_pressed('p1_up')) or (Input.is_action_just_pressed('p2_down') or Input.is_action_just_pressed('p2_up')):
		_updateSelected()
		
func _updateSelected():
	if selected == 0:
		selected = 1
	else:
		selected = 0
	if selected == 0:
		$musicSlider.selected = true
		$sfxSlider.selected = false
		$musicSlider/panel.visible = true
		$sfxSlider/panel.visible = false
	else:
		$musicSlider.selected = false
		$sfxSlider.selected = true
		$musicSlider/panel.visible = false
		$sfxSlider/panel.visible = true
