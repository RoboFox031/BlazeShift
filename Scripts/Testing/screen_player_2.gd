extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	# Add the gravity.dsad

	# Handle jump.


	# Get the input direction and handle the movement/deceleradastion.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var xdirection = Input.get_axis("p2_left", "p2_right")
	var ydirection = Input.get_axis("p2_up", "p2_down")
	if xdirection:
		velocity.x = xdirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if ydirection:
		velocity.y = ydirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
