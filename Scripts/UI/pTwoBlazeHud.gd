extends blazeHud

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("p2_x") and blazeCurrent - blazeBurnSpeed * delta >= 0:
		blazeCurrent -= blazeBurnSpeed * delta
	blazeBar.value = blazeCurrent
