extends sliderTemplate

func _ready():
	tick.position.x = value*10.84
	value = globalVars.sfxDB
	tick.position.x = value*10.84
	
func _process(delta):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index('sfx'),globalVars.sfxDB)
	globalVars.sfxDB = value
