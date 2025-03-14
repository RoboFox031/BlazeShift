extends UI
class_name stoplight

var state: int = 3
@onready var timer = $timer

func _on_timer_timeout() -> void:
	if state == 0:
		_startRace()
	state -= 1
	timer.start()
	
	
func _startRace():
	print("started")
