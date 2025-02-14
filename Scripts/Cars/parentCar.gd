extends CharacterBody2D
class_name Car

var playerId = "p1"
########
#Important Car Stats:
########
#The variables that change based on cars
@export var baseAcceleration=40 ##controls acceleration
@export var baseTopSpeed=800 ##controls top speed
#controls how quickly you turn
@export var baseTurnSpeed=3##controls how quickly you turn
#controls how sharply you turn
@export var baseTurnPower=20 ##controls how sharply you turn
#The base deceleration value
@export var baseDecel=8; ##The base deceleration value
#Stores the speed of the car
var currentLinSpeed:float =0
#Stores the turning speed of the car
var currentTurnPower:float =0
#Outputs the true linear movement of the car
var linOutput:float=0
#Outputs the true turning speed of the car
var turnOutput:float=0
#controls how the car reacts to offroading
@export var offRoadLinMult=.6 ##Controls how offroading affects speed and acceleration
@export var offRoadTurnMult=.8 ##Controls how offroading affects turning
@export var offRoadDecelMult=2 ##Controls how offroading affects decleration
############End of Important Car Stats

#Stores what terrain the car is on
var currentTerrain:trackEnums.terrainTypes
#controls how diffrent aspects react to diffrent terrains
var terrainLinMult:float=1
var terrainTurnMult:float=1
var terrainDecelMult:float=1

func _physics_process(delta):
	#Gets the input, and converts it to positive or negitive 1
	var linDirection = Input.get_axis(playerId+"_down", playerId+"_up")
	#If you are clicking a button, accelerates based on the acceleration value
	if linDirection:
		currentLinSpeed = move_toward(currentLinSpeed, baseTopSpeed*linDirection*terrainLinMult, baseAcceleration*terrainLinMult)
	#If no button is being clicked, decelerates by the deceleration speed
	else:
		currentLinSpeed = move_toward(currentLinSpeed, 0, baseDecel*offRoadDecelMult)
	
	#Gets the input, and converts it to positive or negitive 1
	var turnDirection = Input.get_axis(playerId+"_left", playerId+"_right")
	#If you are clicking a button, turns in that direction based on the acceleration value
	#The /1000 at the end makes the number small, to prevent people from habing to deal with tiny decimals while playing with stats
	if turnDirection and currentLinSpeed!=0:
		currentTurnPower = move_toward(currentTurnPower, baseTurnPower*turnDirection*terrainTurnMult, baseTurnSpeed*terrainTurnMult)/1000
	#If no button is being clicked, stops turning
	else:
		currentTurnPower = 0#move_toward(currentTurnPower, 0,baseTurnSpeed/2)
	
	#Like a car, you can only turn while moving, and going backwards reverses your turn
	turnOutput= currentLinSpeed*currentTurnPower
	rotation_degrees+=turnOutput
	
	#Sets the velocity to  the speed value, using sin and cos to account for rotation
	velocity=Vector2(currentLinSpeed*cos(rotation),currentLinSpeed*sin(rotation))
	move_and_slide()

#Updates the terrain and terrain multipliers
func updateTerrain(newTerrain:trackEnums.terrainTypes):
	#only runs the rest of the function if the terrain is diffrent
	if newTerrain!=currentTerrain:
		currentTerrain=newTerrain
		#If the car is going onto a track, reset the terrain mults to one
		if newTerrain==trackEnums.terrainTypes.track:
			terrainLinMult=1
			terrainTurnMult=1
		#If the car is going off road, set the terrain mults accordingly
		elif newTerrain==trackEnums.terrainTypes.offRoad:
			terrainLinMult=offRoadLinMult
			terrainTurnMult=offRoadTurnMult
