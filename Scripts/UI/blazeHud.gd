extends UI
class_name blazeHud

var blazeMax = 100

var blazeBurnSpeed = 25
@onready var blazeBar = $blazeBar

func _ready() -> void:
	blazeBar.max_value = blazeMax
	blazeBar.value = blazeMax
