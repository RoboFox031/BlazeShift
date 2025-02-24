extends blazeHud

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("p2_x"):
		globalVars.p2BlazeCurrent -= blazeBurnSpeed * delta
		globalVars.p2BlazeCurrent=clamp(globalVars.p2BlazeCurrent,0,100)
	blazeBar.value = globalVars.p2BlazeCurrent