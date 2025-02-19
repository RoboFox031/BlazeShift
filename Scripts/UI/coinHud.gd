extends UI
class_name coinHud

var coins: int = 2

@onready var label = $label

func _ready() -> void:
	update()

func update():
	if coins == 1:
		label.text = str(coins) + " coin"
	else:
		label.text = str(coins) + " coins"
