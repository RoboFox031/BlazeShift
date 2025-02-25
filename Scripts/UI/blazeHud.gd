extends UI
class_name blazeHud

var blazeMax = 100
var blazeCurrent = 100
var blazeBurnSpeed = 25
var blazePowerupFill: float = .5
@onready var blazeBar: TextureProgressBar = $blazeBar

func _ready() -> void:
	pass
