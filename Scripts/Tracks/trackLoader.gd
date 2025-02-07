extends Node2D

@onready var players := {
	"1": {
	viewport = $hSplitContainer/subViewportContainer/subViewport, 
	camera = $hSplitContainer/subViewportContainer/subViewport/camera2d, 
	player = $hSplitContainer/subViewportContainer/subViewport/RaceTrackTesting/ScreenPlayer1
	},
	"2": {
	viewport = $hSplitContainer/subViewportContainer2/subViewport, 
	camera = $hSplitContainer/subViewportContainer2/subViewport/camera2d, 
	player = $hSplitContainer/subViewportContainer/subViewport/RaceTrackTesting/ScreenPlayer2}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	players['2'].viewport.world_2d = players['1'].viewport.world_2d
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)
	pass # Replace with function body.
