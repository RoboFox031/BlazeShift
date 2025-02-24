extends blazeHud

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("p1_x"):
		globalVars.p1BlazeCurrent -= blazeBurnSpeed * delta
		globalVars.p1BlazeCurrent=clamp(globalVars.p1BlazeCurrent,0,100)
	blazeBar.value = globalVars.p1BlazeCurrent
