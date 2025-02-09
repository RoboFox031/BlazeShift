extends CharacterBody2D
class_name Car

########
#Important Car Stats:
########
#The variables that change based on cars
@export var baseAcceleration=40
@export var baseTopSpeed=800
#controls How quickly you turn
@export var baseTurnSpeed=3
#controls how sharply you turn
@export var baseTurnPower=20
#The base deceleration value
var baseDecel=8
#Stores the speed of the car
var currentLinSpeed:float =0
#Stores the turning speed of the car
var currentTurnPower:float =0
#Outputs the true linear movement of the car
var linOutput:float=0
#Outputs the true turning speed of the car
var turnOutput:float=0
############End of Important Car Stats

#Stores what terrain the car is on
var currentTerrain:trackEnums.terrainTypes

func _physics_process(delta):
	#Gets the input, and converts it to positive or negitive 1
	var linDirection = Input.get_axis("p1_down", "p1_up")
	#If you are clicking a button, accelerates based on the acceleration value
	if linDirection:
		currentLinSpeed = move_toward(currentLinSpeed, baseTopSpeed*linDirection, baseAcceleration)
	#If no button is being clicked, decelerates by the deceleration speed
	else:
		currentLinSpeed = move_toward(currentLinSpeed, 0, baseDecel)
	#Sets the velocity to  the speed value, using sin and cos to account for rotation
	velocity=Vector2(currentLinSpeed*cos(rotation),currentLinSpeed*sin(rotation))
	#Gets the input, and converts it to positive or negitive 1
	var turnDirection = Input.get_axis("p1_left", "p1_right")
	#If you are clicking a button, turns in that direction based on the acceleration value
	#The /1000 at the end makes the number small, to prevent people from habing to deal with tiny decimals while playing with stats
	if turnDirection and currentLinSpeed!=0:
		currentTurnPower = move_toward(currentTurnPower, baseTurnPower*turnDirection, baseTurnSpeed)/1000
	#If no button is being clicked, decelerates by the half of the turning speed speed
	else:
		currentTurnPower = 0#move_toward(currentTurnPower, 0,baseTurnSpeed/2)
	
	#Like a car, you can only turn while moving, and going backwards reverses your turn
	turnOutput= currentLinSpeed*currentTurnPower
	rotation_degrees+=turnOutput
	
	move_and_slide()

func _input(event):
	pass
