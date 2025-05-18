extends blazeHud

#Sets max blaze based on upgrades
func _ready() -> void:
	blazeMax= 100+globalUpgrades.statValue("p1",globalVars.currentCarNames["p1"],"maxBlaze")
	globalVars.p1BlazeCurrent=blazeMax
	#Runs the blazeHud Class's ready
	super()

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("p1_x"):
		globalVars.p1BlazeCurrent=clamp(globalVars.p1BlazeCurrent,0,blazeMax)
	blazeBar.value = globalVars.p1BlazeCurrent
