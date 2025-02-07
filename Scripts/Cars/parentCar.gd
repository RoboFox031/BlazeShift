extends CharacterBody2D
class_name Car

########
#Important Car Stats:
########
#The variables that change based on cars
@export var baseAcceleration=20
@export var baseTopSpeed=400
#How quickly you turn
@export var baseTurnSpeed=10
#how sharply you turn
@export var baseTurnPower=45
#The base deceleration value
var baseDecel=5
#Stores the speed of the car
var currentLinSpeed:float =0
#Stores the turning speed of the car
var currentTurnSpeed:float =0

############End of Important Car Stats


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
	if turnDirection:
		currentTurnSpeed = move_toward(currentTurnSpeed, baseTurnPower*turnDirection, baseTurnSpeed)
	#If no button is being clicked, decelerates by the half of the turning speed speed
	else:
		currentTurnSpeed = move_toward(currentTurnSpeed, 0,baseTurnSpeed/2)
	rotation+=currentTurnSpeed
	
	
	move_and_slide()

func _input(event):
	pass
