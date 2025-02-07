extends CharacterBody2D
class_name Car

#The variables that change based on cars
@export var baseAcceleration=20
@export var baseTopSpeed=400
@export var baseTurnSpeed=0
@export var baseTurnPower=0

#The base deceleration value
var baseDecel=5
#Stores the speed of the car
var currentSpeed:float =0


func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("p1_up", "p1_down")
	if direction:
		currentSpeed = move_toward(velocity.y, baseTopSpeed*direction, baseAcceleration)
	else:
		currentSpeed = move_toward(velocity.y, 0, baseDecel)

	velocity=(currentSpeed*cos(rotation),currentSpeed*sin(rotation))
	move_and_slide()

func _input(event):
	pass
