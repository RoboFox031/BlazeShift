extends blazeHud

#Sets max blaze based on upgrades
func _ready() -> void:
	blazeMax= 100+globalUpgrades.statValue("p2",globalVars.currentCarNames["p2"],"maxBlaze")
	globalVars.p2BlazeCurrent=blazeMax
	#Runs the blazeHud Class's ready
	super()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("p2_x"):
		globalVars.p2BlazeCurrent -= blazeBurnSpeed * delta
		globalVars.p2BlazeCurrent=clamp(globalVars.p2BlazeCurrent,0,blazeMax)
	blazeBar.value = globalVars.p2BlazeCurrent
