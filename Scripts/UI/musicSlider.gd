extends sliderTemplate

func _ready():
	tick.position.x = value*10.84
	value = globalVars.musicDB
func _process(delta):
	globalVars.musicDB = value
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index('music'),globalVars.musicDB)
