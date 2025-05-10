extends UI

var selected = 0 #0 is sfx 1 is music

func _ready() -> void:
	_updateLabels()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('p1_up') or Input.is_action_just_pressed('p2_up'):
		if selected == 0:
			selected = 1
			
		else:
			selected = 0
		_updateLabels()
	if Input.is_action_just_pressed('p1_down') or Input.is_action_just_pressed('p2_down'):
		if selected == 0:
			selected = 1
		else:
			selected = 0
		_updateLabels()
	if Input.is_action_just_pressed('p1_b') or Input.is_action_just_pressed('p2_b'):
		get_tree().change_scene_to_file('res://Scenes/UI/titleScreen.tscn')
		
func _updateLabels():
	if selected == 0:
		$sfxSlider.selected = true
		$musicSlider.selected = false
		$sfxSlider/panel.visible = true
		$musicSlider/panel.visible = false
	else:
		$sfxSlider.selected = false
		$musicSlider.selected = true
		$sfxSlider/panel.visible = false
		$musicSlider/panel.visible = true
