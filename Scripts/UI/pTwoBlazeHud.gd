extends blazeHud

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("p2_x") and globalVars.p2BlazeCurrent - blazeBurnSpeed * delta >= 0:
		globalVars.p2BlazeCurrent -= blazeBurnSpeed * delta
	blazeBar.value = globalVars.p2BlazeCurrent