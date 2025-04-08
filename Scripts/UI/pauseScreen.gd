extends Node2D
 
var inControl: int = 0

var selected: int = 0

var options = ["resume", "options", "restart"]

var labels
signal p_pause
signal p_resume
var pOneConfirm = false
var pTwoConfirm = false

func _ready():
	labels = [$colorRect/resumeLabel, $colorRect/optionsLabel, $colorRect/restartLabel]
	_updateMenu()

func _physics_process(delta: float) -> void:
	if globalVars.canPause == true:
		if Input.is_action_just_pressed("p1_start"):
			p_pause.emit()
			if inControl == 0:
				inControl = 1 
			elif inControl == 1:
				_useButton(options[selected])
			elif inControl == 3:
				if pOneConfirm == false:
					pOneConfirm = true
				else:
					pOneConfirm = false
			_updateMenu()
				
		elif Input.is_action_just_pressed("p2_start"):
			p_pause.emit()
			if inControl == 0:
				inControl = 2
			elif inControl == 2:
				_useButton(options[selected])
			elif inControl == 3:
				if pTwoConfirm == false:
					pTwoConfirm = true
				else:
					pTwoConfirm = false
			_updateMenu()
			
		if Input.is_action_just_pressed("p1_up") and inControl == 1:
			if selected - 1 >= 0:
				selected -= 1
			else:
				selected = 2
			_updateMenu()
		if Input.is_action_just_pressed("p1_down") and inControl == 1:
			if selected + 1 <= 2:
				selected += 1
			else:
				selected = 0
			_updateMenu()
		if Input.is_action_just_pressed("p2_up") and inControl == 2:
			if selected - 1 >= 0:
				selected -= 1
			else:
				selected = 2
			_updateMenu()
		if Input.is_action_just_pressed("p2_down") and inControl == 2:
			if selected + 1 <= 2:
				selected += 1
			else:
				selected = 0
			_updateMenu()
			
func _updateMenu():
	if inControl != 0:
		self.visible = true
	else:
		self.visible = false
		
	if $pOneConfirmLabel.visible == true:
		if pOneConfirm == true:
			$pOneConfirmLabel.text = 'press start again to undo'
			$pOneConfirmLabel/label.text = 'confirmed'
			$pOneConfirmLabel/label.add_theme_color_override("font_color", Color(0,1,0))
		else:
			$pOneConfirmLabel.text = 'press start to confirm'
			$pOneConfirmLabel/label.text = 'unconfirmed'
			$pOneConfirmLabel/label.add_theme_color_override("font_color", Color(1,0,0))
		if pTwoConfirm == true:
			$pTwoConfirmLabel.text = 'press start again to undo'
			$pTwoConfirmLabel/label.text = 'confirmed'
			$pTwoConfirmLabel/label.add_theme_color_override("font_color", Color(0,1,0))
		else:
			$pTwoConfirmLabel.text = 'press start to confirm'
			$pTwoConfirmLabel/label.text = 'unconfirmed'
			$pTwoConfirmLabel/label.add_theme_color_override("font_color", Color(1,0,0))
	
	if pOneConfirm == true and pTwoConfirm == true:
		_restart()
			
		
	for label in labels:
		if label == labels[selected]:
			label.add_theme_color_override("font_outline_color", Color(0,0,0)) 
			label.add_theme_constant_override("outline_size", 30)
		else:
			label.add_theme_constant_override("outline_size", 0)

func _useButton(option):
	if option == 'resume' and inControl != 0:
		inControl = 0
		self.visible = false
		p_resume.emit()
		print('hit')
	if option == 'options':
		self.visible == false
	if option == 'restart':
		inControl = 3
		$pOneConfirmLabel.visible = true
		$pTwoConfirmLabel.visible = true
		
func _restart():
	get_tree().change_scene_to_file("res://Scenes/UI/titleScreen.tscn")
		
