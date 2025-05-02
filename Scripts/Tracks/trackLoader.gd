extends Node2D

var track = globalVars.track
signal _startRace
signal _startRaceTimer
var trackName = track.instantiate().name
var timer = 'on'

@onready var basicMusic = $royaltyMusic/basicMusic
@onready var ruralMusic = $royaltyMusic/ruralMusic
@onready var iceMusic = $royaltyMusic/iceTrack
@onready var volcanoMusic = $royaltyMusic/volcanoMusic
@onready var cityMusic = $royaltyMusic/cityMusic

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
	print(globalVars.track.instantiate().name)
	pass # Replace with function body.
	
func _physics_process(delta):
	if globalVars.playMusic == true:
		playMusic(trackName)
	if globalVars.canMove == true:
		if not globalVars.pTwoDone:
			pTwoTimer.text = str(snapped((float(pTwoTimer.text) + delta),.001))
			globalVars.pTwoLastRaceTime = float(pTwoTimer.text)
	if globalVars.canMove == true:
		if not globalVars.pOneDone:
			pOneTimer.text = str(snapped((float(pOneTimer.text) + delta),.001))
			globalVars.pOneLastRaceTime = float(pOneTimer.text)
func _on_pause_screen_p_pause():
	globalVars.canMove = false
func _on_pause_screen_p_resume() -> void:
	globalVars.canMove = true

func playMusic(track):
	if globalVars.musicType == 'royalty':
		if track == 'basicTrack':
			if basicMusic.playing == false:
				basicMusic.play()
		elif track == 'ruralTrack':
			if ruralMusic.playing == false:
				ruralMusic.play()
		elif track == 'iceTrack':
			if iceMusic.playing == false:
				iceMusic.play()
		elif track == 'volcanoTrack':
			if volcanoMusic.playing == false:
				volcanoMusic.play()
		elif track == 'cityTrack':
			if cityMusic.playing == false:
				cityMusic.play()
