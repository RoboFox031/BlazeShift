extends Node2D

var load = false

func _ready():
	var track = globalVars.track.instantiate()
	add_child(track)
	print(track.name)
	ResourceLoader.load_threaded_request("res://Scenes/Tracks/trackLoader.tscn")
	$animationPlayer.play(track.name+'Pan')

func _process(delta):
	if load == true:
		var progress = []
		ResourceLoader.load_threaded_get_status("res://Scenes/Tracks/trackLoader.tscn", progress)
		#$progress_number.text = str(progress[0]*100)+"%"
		if progress[0] == 1:
			var packed_scene = ResourceLoader.load_threaded_get("res://Scenes/Tracks/trackLoader.tscn")
			get_tree().change_scene_to_packed(packed_scene)

func _input(event):
	if Input.is_action_just_pressed("test"):
		$animationPlayer.play('basicCameraPan')
		print('play')
#0.0
#2.5406
#2.5416
#5.2437
#5.2447
#7.5576

#800
#2800


func _animationFinished(animName):
	load = true
	pass # Replace with function body.
