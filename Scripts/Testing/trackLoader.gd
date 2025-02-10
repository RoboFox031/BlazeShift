extends Node2D
var selectedTrack = globalVars.track
@onready var players := {
	"1": {
	viewport = $HBoxContainer/SubViewportContainer/SubViewport, 
	camera = $HBoxContainer/SubViewportContainer/SubViewport/camera2d, 
	player = null
	},
	"2": {
	viewport = $HBoxContainer/SubViewportContainer2/SubViewport, 
	camera = $HBoxContainer/SubViewportContainer2/SubViewport/camera2d, 
	player = null}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	if globalVars.track:
		var track = selectedTrack.instantiate()
		players['1'].viewport.add_child(track)
		players['2'].viewport.world_2d = players['1'].viewport.world_2d
		players['1'].player = $HBoxContainer/SubViewportContainer/SubViewport/RaceTrackTesting/ScreenPlayer1
		players['2'].player = $HBoxContainer/SubViewportContainer/SubViewport/RaceTrackTesting/ScreenPlayer2
		for node in players.values():
			var remote_transform := RemoteTransform2D.new()
			remote_transform.remote_path = node.camera.get_path()
			print(node)
			node.player.add_child(remote_transform)
		pass # Replace with function body.
