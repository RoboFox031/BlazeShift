extends blazeHud

func _ready() -> void:
	blazeBar.max_value = blazeMax
	blazeBar.value = blazeCurrent

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("p1_x") and blazeCurrent - blazeBurnSpeed * delta >= 0:
		blazeCurrent -= blazeBurnSpeed * delta
	blazeBar.value = blazeCurrent
