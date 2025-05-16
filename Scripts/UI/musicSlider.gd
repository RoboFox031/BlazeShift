extends sliderTemplate

func _ready():
	tick.position.x = globalVars.sfxDB*10.84
	value = globalVars.musicDB
	tick.position.x = globalVars.musicDB*10.84
	
func _process(delta):
	globalVars.musicDB = value
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index('music'),globalVars.musicDB)
