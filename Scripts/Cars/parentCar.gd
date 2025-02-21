extends CharacterBody2D
class_name Car

@onready var colorSprite: AnimatedSprite2D = $Sprite2D


var color = "blue"
var fireball: PackedScene = preload("res://Scenes/Pickups/fireball.tscn")

########
#Important Car Stats:
########
#The variables that change based on cars
@export var baseAcceleration=15 ##controls acceleration
@export var baseTopSpeed=1000 ##controls top speed
#controls how quickly you turn
@export var baseTurnSpeed:float=80##controls how quickly you turn
var trueBaseTurnSpeed:float: #Converts the turn speed to radians
	get:
		return baseTurnSpeed*PI/180
#controls how sharply you turn
@export var baseTurnPower:float=180 ##controls how sharply you turn
var trueTurnPower:float: #Converts the turn power to radians
	get:
		return baseTurnPower*PI/180
#The base deceleration value
@export var baseDecel=8; ##The base deceleration value
#Stores the speed of the car
var currentLinSpeed:float =0
#Stores the turning speed of the car
var currentTurnForce:float =0
#Outputs the true linear movement of the car
var linOutput:float=0
#Outputs the true turning speed of the car
var turnOutput:float=0
###########################
############End of Important Car Stats
###########################
#Stores the owner of the car
enum playerChoices{p1,p2}
@export var currentOwner:playerChoices
#Allows the enum to be read as a string
var currentOwnerStr:String:
	get:
		return playerChoices.find_key(currentOwner)

#controls how the car reacts to offroading
@export var offRoadSpeedMult:float=.6 ##Controls how offroading affects speed and acceleration
@export var offRoadAccelMult:float=.8 ##Controls how offroading affects turning
@export var offRoadTurnSpeedMult:float=.8 ##Controls how offroading affects turning speed
@export var offRoadTurnPowerMult:float=.8 ##Controls how offroading affects turning power
@export var offRoadDecelMult:float=2 ##Controls how offroading affects decleration 
#controls how the car reacts to ice
@export var iceSpeedMult:float=1 ##Controls how offroading affects speed and acceleration
@export var iceAccelMult:float=0.5 ##Controls how offroading affects speed and acceleration
@export var iceTurnSpeedMult:float=0.1 ##Controls how offroading affects turning speed
@export var iceTurnPowerMult:float=2 ##Controls how offroading affects turning power
@export var iceDecelMult:float=0.5 ##Controls how offroading affects decleration

#Stores what terrain the car is on
var currentTerrain:trackEnums.terrainTypes
#controls how diffrent aspects react to diffrent terrains
var terrainSpeedMult:float=1
var terrainAccelMult:float=1
var terrainTurnSpeedMult:float=1
var terrainTurnPowerMult:float=1
var terrainDecelMult:float=1

#Stores the current stats of the car(are the same as the base most of the time)
#The variables that change based on cars
var currentAcceleration=baseAcceleration ##controls acceleration
var currentTopSpeed=baseTopSpeed ##controls top speed
#controls how quickly you turn
var currentTurnSpeed:float=baseTurnSpeed##controls how quickly you turn
var trueCurrentTurnSpeed:float: #Converts the turn speed to radians
	get:
		return currentTurnSpeed*PI/180
#controls how sharply you turn
var currentTurnPower:float=baseTurnPower ##controls how sharply you turn
var trueCurrentTurnPower:float: #Converts the turn power to radians
	get:
		return currentTurnPower*PI/180
#The current deceleration value
var currentDecel=8; ##The base deceleration value





func _physics_process(delta):
	#Changes the color
	colorSprite.play(color)
	#Gets the input, and converts it to positive or negitive 1
	var linDirection = Input.get_axis(currentOwnerStr+"_down", currentOwnerStr+"_up")
	#If you are clicking a button, accelerates based on the acceleration value
	if linDirection:
		currentLinSpeed = move_toward(currentLinSpeed, baseTopSpeed*linDirection*terrainSpeedMult, baseAcceleration*terrainAccelMult)
	#If no button is being clicked, decelerates by the deceleration speed
	else:
		currentLinSpeed = move_toward(currentLinSpeed, 0, baseDecel*terrainDecelMult)
	
	#Gets the input, and converts it to positive or negitive 1
	var turnDirection = Input.get_axis(currentOwnerStr+"_left", currentOwnerStr+"_right")
	#If you are clicking a button, turns in that direction based on the acceleration value
	#The /1000 at the end makes the number small, to prevent people from habing to deal with tiny decimals while playing with stats
	if turnDirection and currentLinSpeed!=0:
		currentTurnForce = move_toward(currentTurnForce, trueTurnPower*turnDirection*terrainTurnPowerMult, trueBaseTurnSpeed*terrainTurnSpeedMult)
	#If no button is being clicked, stops turning
	else:
		currentTurnForce = move_toward(currentTurnForce, 0,trueBaseTurnSpeed*terrainTurnSpeedMult)
	
	#Like a car, you can only turn while moving, and going backwards reverses your turn
	turnOutput= (currentLinSpeed/baseTopSpeed)*currentTurnForce
	rotation_degrees+=turnOutput
	
	#Sets the velocity to  the speed value, using sin and cos to account for rotation
	velocity=Vector2(currentLinSpeed*cos(rotation),currentLinSpeed*sin(rotation))
	move_and_slide()
	
	if Input.is_action_just_pressed("p1_r1"):###might change the input later
		if globalVars.pOnePowerup != null:
			if globalVars.pOnePowerup == "blaze":
				globalVars.pOnePowerup = 'none'
				get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOnePowerupsHud").changeItem()
				if get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazeCurrent + (get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazeMax * get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazePowerupFill) <= get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazeMax:
					get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazeCurrent += (get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazeMax * get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazePowerupFill) 
				else:
					get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazeCurrent = get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazeMax
			if globalVars.pOnePowerup == 'fireball':
				globalVars.pOnePowerup = 'none'
				var instance = fireball.instantiate()
				if currentOwner == playerChoices.p1:
					add_child(instance)
				if currentOwner == playerChoices.p2:
					add_child(instance)
				get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOnePowerupsHud").changeItem()


# func _input(event):
# 	#Controls boost
# 	print(event)









#Updates the terrain and terrain multipliers
func updateTerrain(newTerrain):
	#only runs the rest of the function if the terrain is diffrent
	if newTerrain!=currentTerrain:
		currentTerrain=newTerrain
		#If the car is going onto a track, reset the terrain mults to one
		if newTerrain==trackEnums.terrainTypes.track:
			terrainSpeedMult=1
			terrainAccelMult=1
			terrainTurnSpeedMult=1
			terrainTurnPowerMult=1
			terrainDecelMult=1
		#If the car is going off road, set the terrain mults accordingly
		elif newTerrain==trackEnums.terrainTypes.offRoad:
			terrainSpeedMult=offRoadSpeedMult
			terrainTurnSpeedMult=offRoadTurnSpeedMult
			terrainTurnPowerMult=offRoadTurnPowerMult
			terrainDecelMult=offRoadDecelMult
		#If the car is going onto ice, set the terrain mults accordingly
		elif newTerrain==trackEnums.terrainTypes.ice:
			terrainSpeedMult=iceSpeedMult
			terrainAccelMult=iceAccelMult
			terrainTurnSpeedMult=iceTurnSpeedMult
			terrainDecelMult=iceDecelMult
