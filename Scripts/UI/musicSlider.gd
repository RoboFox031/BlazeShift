extends sliderTemplate

func _ready():
	$audioStreamPlayer2d.play()
	tick.position.x = value*10.84
	value = globalVars.musicDB
func _process(delta):
	globalVars.musicDB = value
	print(globalVars.musicDB)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index('music'),globalVars.musicDB)
