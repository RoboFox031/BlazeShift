extends CharacterBody2D
class_name Car


@export var baseAcceleration=20
@export var baseTopSpeed=400
@export var baseTurnSpeed=0
@export var baseTurnPower=0

#The base deceleration value
var baseDecel=5



func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("p1_up", "p1_down")
	if direction:
		velocity.y = move_toward(velocity.y, baseTopSpeed*direction, baseAcceleration)
	else:
		velocity.y = move_toward(velocity.y, 0, baseDecel)

	move_and_slide()

func _input(event):
	pass
