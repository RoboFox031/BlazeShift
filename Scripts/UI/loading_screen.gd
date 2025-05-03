extends Control

var load = false

@onready var tire: Sprite2D = $dot20231024175025

func _ready() -> void:
	ResourceLoader.load_threaded_request(globalVars.nextScene)
	$timer.start(5)
	pass

func _process(delta: float) -> void:
	tire.rotation += .01
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
