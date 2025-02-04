extends CharacterBody2D
class_name Car

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var baseAcceleration=0
@export var baseTopSpeed=0
@export var baseTurnSpeed=0
@export var baseTurnPower=0





func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("p1_up", "p1_down")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event):
	pass