extends Node2D

var track = globalVars.track.instantiate()
var trackName = globalVars.track.instantiate().name
var timer = 'on'

@onready var testTimer = $hSplitContainer/subViewportContainer2/canvasLayer/label




@onready var players := {
	"1": {
	viewport = $hSplitContainer/subViewportContainer/subViewport, 
	camera = $hSplitContainer/subViewportContainer/subViewport/camera2d, 
	player = null
	},
	"2": {
	viewport = $hSplitContainer/subViewportContainer2/subViewport, 
	camera = $hSplitContainer/subViewportContainer2/subViewport/camera2d, 
	player = null}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	track.name = 'track'
	print(track.name)
	players['1'].viewport.add_child(track)
	players['2'].viewport.world_2d = players['1'].viewport.world_2d
	players['1'].player = $hSplitContainer/subViewportContainer/subViewport/track/player1
	print(players['1'].player)
	players['2'].player = $hSplitContainer/subViewportContainer/subViewport/track/player2
	print(players['2'].player)
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)
	pass # Replace with function body.
	
func _physics_process(delta):
	print(trackName)
	if timer == 'on':
		testTimer.text = str(snapped((float(testTimer.text) + delta),.001))
	if Input.is_action_just_pressed('p1_a'):
		timer = 'off'
		globalVars.saveScores(trackName,str(globalVars.pOneName),testTimer.text)
