extends UI
class_name stoplight

@onready var timer = $timer
@onready var animatedSprite = $animatedSprite2d

func _on_track_loader__start_race() -> void:
	timer.start()
	animatedSprite.play("Stoplight")
func _on_timer_timeout() -> void:
	self.visible = false
