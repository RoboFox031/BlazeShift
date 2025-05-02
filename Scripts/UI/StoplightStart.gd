extends UI
class_name stoplight

@onready var timer = $timer
@onready var animatedSprite = $animatedSprite2d

func on_track_loader__start_race() -> void:
	timer.start()
	animatedSprite.play("Stoplight")
	if animatedSprite.is_playing():
		globalVars.canMove = false
func _on_track_loader__start_race() -> void:
	timer.start()
	animatedSprite.play("Stoplight")
	if animatedSprite.is_playing():
		globalVars.canMove = false
func _on_timer_timeout() -> void:
	self.visible = false
	globalVars.canMove = true
	globalVars.canPause = true
	globalVars.playMusic = true
