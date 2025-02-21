extends blazeHud

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("p1_x") and globalVars.p1BlazeCurrent - blazeBurnSpeed * delta >= 0:
		globalVars.p1BlazeCurrent -= blazeBurnSpeed * delta
	blazeBar.value = globalVars.p1BlazeCurrent
