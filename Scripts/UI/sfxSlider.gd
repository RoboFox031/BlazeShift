extends sliderTemplate

func _ready():
	tick.position.x = value*10.84
	value = globalVars.sfxDB
	
func _process(delta):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index('sfx'),value)
	globalVars.sfxDB = value
