extends UI
class_name blazeHud

var blazeMax = 100
var blazeCurrent = 100
var blazeBurnSpeed = 25
@onready var blazeBar = $blazeBar

func _ready() -> void:
	blazeBar.max_value = blazeMax
	blazeBar.value = blazeCurrent

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("p2_x") and blazeCurrent - blazeBurnSpeed * delta >= 0:
		blazeCurrent -= blazeBurnSpeed * delta
	blazeBar.value = blazeCurrent
