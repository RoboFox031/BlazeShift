extends UI
class_name stoplight

@onready var timer = $timer
@onready var animatedSprite = $animatedSprite2d
@onready var stoplightSound = $audioStreamPlayer2d

func _ready():
	$animatedSprite2d.visible = false
	pass

func on_track_loader__start_race() -> void:
	timer.start()
	animatedSprite.play("Stoplight")
	if animatedSprite.is_playing():
		globalVars.canMove = false
func _on_track_loader__start_race() -> void:
	$delay.start(1)
func _on_timer_timeout() -> void:
	self.visible = false
	globalVars.canMove = true
	globalVars.canPause = true
	globalVars.playMusic = true


func _on_delay_timeout():
	timer.start()
	$animationPlayer.play("stoplightSoundStart")
	#animatedSprite.play("Stoplight")
	if animatedSprite.is_playing():
		#stoplightSound.play()
		globalVars.canMove = false
	pass # Replace with function body.
