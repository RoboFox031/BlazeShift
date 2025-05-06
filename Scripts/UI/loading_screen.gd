extends Control

var load = false
@onready var animation = $animatedSprite2d


func _ready() -> void:
	ResourceLoader.load_threaded_request(globalVars.nextScene)
	animation.play('default')
	#$timer.start(12)
	pass

func _process(delta: float) -> void:
	if load == true:
		var progress = []
		ResourceLoader.load_threaded_get_status(globalVars.nextScene, progress)
		$progressBar.value = progress[0]*100
		#$progress_number.text = str(progress[0]*100)+"%"
		if progress[0] == 1:
			var packed_scene = ResourceLoader.load_threaded_get(globalVars.nextScene)
			get_tree().change_scene_to_packed(packed_scene)
	pass
	


func _on_timer_timeout() -> void:
	load = true
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	load = true
	pass # Replace with function body.
