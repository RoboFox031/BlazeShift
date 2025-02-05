extends Node2D

@onready var players := {
	"1": {
	viewport = $HBoxContainer/SubViewportContainer/SubViewport, 
	camera = $HBoxContainer/SubViewportContainer/SubViewport/camera2d, 
	player = $HBoxContainer/SubViewportContainer/SubViewport/RaceTrackTesting/ScreenPlayer1
	},
	"2": {
	viewport = $HBoxContainer/SubViewportContainer/SubViewport, 
	camera = $HBoxContainer/SubViewportContainer/SubViewport/camera2d, 
	player = $HBoxContainer/SubViewportContainer/SubViewport/RaceTrackTesting/ScreenPlayer1}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	players['2'].viewport.world_2d = players['1'].viewport.world_2d
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.pdasdlayer.add_shild(remote_transform)
	pass # Replace with function body.
