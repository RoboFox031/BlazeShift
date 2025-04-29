extends Node2D

var track = globalVars.track
signal _startRace
signal _startRaceTimer
var trackName = track.instantiate().name
var timer = 'on'
@onready var pTwoTimer = $hSplitContainer/subViewportContainer2/canvasLayer/pTwoTimer
@onready var pOneTimer = $hSplitContainer/subViewportContainer/canvasLayer/pOneTimer


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
	var track = track.instantiate()
	track.name = 'track'
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
	_startRace.emit()
	pass # Replace with function body.
	
func _physics_process(delta):
	if globalVars.canMove == true:
		pTwoTimer.text = str(snapped((float(pTwoTimer.text) + delta),.001))
		globalVars.pTwoLastRaceTime = globalVars.convertSec(float(pTwoTimer.text))
	if globalVars.canMove == true:
		pOneTimer.text = str(snapped((float(pOneTimer.text) + delta),.001))
		globalVars.pOneLastRaceTime = globalVars.convertSec(float(pOneTimer.text))
func _on_pause_screen_p_pause():
	globalVars.canMove = false
func _on_pause_screen_p_resume() -> void:
	globalVars.canMove = true
