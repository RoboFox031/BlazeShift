extends Node2D
var playerNum
func _ready():
	$animatedSprite2d.play("default")
	$timer.start(5)
	var trackName = globalVars.track.instantiate().name
	#type = 'fireCyclone'
	#self.position = spawnPosition
	if trackName == 'basicTrack':
		self.z_index = 2
	if trackName == 'iceTrack':
		self.z_index = 2
	if trackName == 'ruralTrack':
		self.z_index = 5
	if trackName == 'cityTrack':
		self.z_index = 1
	if trackName == 'volcanoTrack':
		self.z_index = 5
		
	#self.sprite.rotation = direction
	pass
func _process(delta):
	if playerNum == 'p1':
		self.global_position = get_node('/root/trackLoader/hSplitContainer/subViewportContainer/subViewport/track/player1').global_position
		self.rotation += .05
	if playerNum == 'p2':
		self.global_position = get_node('/root/trackLoader/hSplitContainer/subViewportContainer/subViewport/track/player2').global_position
		self.rotation += .05
func _on_area_2d_body_entered(body):
	if body is powerUp:
		body.queue_free()
	#if body is Car:
		#body.inCyclone = true
		
	


func _on_timer_timeout():
	get_node('/root/trackLoader/hSplitContainer/subViewportContainer/subViewport/track/player1').inCyclone = false
	get_node('/root/trackLoader/hSplitContainer/subViewportContainer/subViewport/track/player2').inCyclone = false
	queue_free()
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Car:
		body.inCyclone = false
	pass # Replace with function body.
