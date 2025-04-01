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
@export var baseTurnSpeed:float=40##controls how quickly you turn
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

#Stores the vector the car is going in
var fwdVector:Vector2

#handles traction
@export var baseTraction:float=100
var traction=baseTraction
var driftTractionMult=10
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

#Stores if the player is boosting
var boosting:bool=false

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
var currentDecel=baseDecel ##The base deceleration value

#Stores the direction you are drifing in
enum driftDir{lDrift=-1,rDrift=1,none=0}
var currentDrift:driftDir
var isDrifting:bool=false
var driftVector:Vector2

func _ready() -> void:
	z_index = 10


func _physics_process(delta):
	#Changes the color
	colorSprite.play(color)
	#Gets the input, and converts it to positive or negitive 1
	var linDirection = Input.get_axis(currentOwnerStr+"_down", currentOwnerStr+"_up")
	#If you are clicking a button, accelerates based on the acceleration value
	if linDirection:
		currentLinSpeed = move_toward(currentLinSpeed, currentTopSpeed*linDirection*terrainSpeedMult, currentAcceleration*terrainAccelMult)
	#If no button is being clicked, decelerates by the deceleration speed
	else:
		currentLinSpeed = move_toward(currentLinSpeed, 0, currentDecel*terrainDecelMult)
	
	var turnDirection
	if isDrifting==false:
		#Gets the input, and converts it to positive or negitive 1
		turnDirection = Input.get_axis(currentOwnerStr+"_left", currentOwnerStr+"_right")
	if isDrifting==true:
		turnDirection=currentDrift
	#If you are clicking a button, turns in that direction based on the acceleration value
	#The /1000 at the end makes the number small, to prevent people from habing to deal with tiny decimals while playing with stats
	if turnDirection and currentLinSpeed!=0:
		currentTurnForce = move_toward(currentTurnForce, trueCurrentTurnPower*turnDirection*terrainTurnPowerMult, trueCurrentTurnSpeed*terrainTurnSpeedMult)
	#If no button is being clicked, stops turning
	else:
		currentTurnForce = move_toward(currentTurnForce, 0,trueBaseTurnSpeed*terrainTurnSpeedMult)
	
	#Like a car, you can only turn while moving, and going backwards reverses your turn
	if globalVars.canMove == true:
		turnOutput= (currentLinSpeed/currentTopSpeed)*currentTurnForce
		rotation_degrees+=turnOutput
	
	#If your traction isn't at it's normal value, and you aren't on ice or drifting, slowly increase the traction
	if(traction!=baseTraction)and(currentTerrain!=trackEnums.terrainTypes.ice) and (isDrifting==false):
		traction=move_toward(traction,baseTraction,4)
	#Sets the velocity to fwd vector added to the drift vector
	fwdVector=Vector2(currentLinSpeed*cos(rotation),currentLinSpeed*sin(rotation))
	driftVector=Vector2(move_toward(driftVector.x,fwdVector.x,traction),move_toward(driftVector.y,fwdVector.y,traction))
	velocity=(fwdVector+driftVector)/2
	
	if globalVars.canMove == true:
		move_and_slide()
	# print("Fwd: "+str(fwdVector))
	# print("Drift: "+str(driftVector))
	#print("Traction: "+str(traction))
	#If you are boosting, stops you when you run out
	if boosting==true:
		if(globalVars.p1BlazeCurrent==0) and (currentOwner==playerChoices.p1):
			resetMovement()
		elif(globalVars.p2BlazeCurrent==0) and (currentOwner==playerChoices.p2):
			resetMovement()

	
	if Input.is_action_just_pressed(currentOwnerStr+"_r1"):###might change the input later
		if globalVars.pOnePowerup != 'none':
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
		if globalVars.pTwoPowerup != 'none':
			if globalVars.pTwoPowerup == "blaze":
				globalVars.pTwoPowerup = 'none'
				get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoPowerupsHud").changeItem()
				if get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazeCurrent + (get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazeMax * get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazePowerupFill) <= get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazeMax:
					get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazeCurrent += (get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazeMax * get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazePowerupFill) 
				else:
					get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazeCurrent = get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazeMax
			if globalVars.pTwoPowerup == 'fireball':
				globalVars.pTwoPowerup = 'none'
				var instance = fireball.instantiate()
				if currentOwner == playerChoices.p1:
					add_child(instance)
				if currentOwner == playerChoices.p2:
					add_child(instance)
				get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoPowerupsHud").changeItem()


func _input(event):
	#Allows boost
	if Input.is_action_just_pressed(currentOwnerStr+"_x"):
		
		startBoost()
	if Input.is_action_just_released(currentOwnerStr+"_x"):
		print(currentOwnerStr+" stopped boosting")
		resetMovement()
	
	#Allows drift
	if Input.is_action_just_pressed(currentOwnerStr+"_l1"):
		
		startDrift()
	if Input.is_action_just_released(currentOwnerStr+"_l1"):
		print(currentOwnerStr+" stopped drifting")
		resetMovement()

#Resets movement variables to their defult
func resetMovement():
	#Resets drifting
	isDrifting=false
	#Reset boost
	boosting=false
	#Resets basic car varibles
	currentAcceleration=baseAcceleration
	currentTopSpeed=baseTopSpeed
	currentTurnSpeed=baseTurnSpeed
	currentTurnPower=baseTurnPower 
	currentDecel=baseDecel

#Changes the movement varibles to the boosted state
func startBoost():
	if currentOwner==playerChoices.p1 and globalVars.p1BlazeCurrent>0:
		currentAcceleration=baseAcceleration*3
		currentTopSpeed=baseTopSpeed*2
		currentTurnPower=baseTurnPower*.5
		boosting=true
	elif currentOwner==playerChoices.p2 and globalVars.p2BlazeCurrent>0:
		currentAcceleration=baseAcceleration*3
		currentTopSpeed=baseTopSpeed*2
		currentTurnPower=baseTurnPower*.5
		boosting=true


	print(currentOwnerStr+" is boosing")

#Changes the movement varibles to the drifing state
func startDrift():
	#Resets the drift varible
	currentDrift=driftDir.none
	#Determine which direction the player is currently turning and sets the driftDir accordingly
	if currentTurnForce<0:
		currentDrift=driftDir.lDrift
		print(currentOwnerStr+" is drifting left")
	elif currentTurnForce>0:
		currentDrift=driftDir.rDrift
		print(currentOwnerStr+" is drifting right")
	#If you aren't drifing, stop the function
	if currentDrift==driftDir.none:
		pass
	#if you are drfiting, alter the variables accordingly
	else:
		isDrifting=true
		#currentTurnPower=baseTurnPower*.5
		#Lowers traction while drifing
		traction=traction/driftTractionMult
		
	


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
			#resets traction if you arent drifitng
			if isDrifting==false:
				traction=baseTraction
			#if you are drifitng, improve traction to drift levels
			else:
				traction=traction/driftTractionMult
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
			#Lowers traction on ice
			traction=traction/15
