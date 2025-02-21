extends Car
class_name playerTwoCar


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var playerId = null

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("p2_r1"):###might change the input later
		if globalVars.pTwoPowerup != null:
			if globalVars.pTwoPowerup == "blaze":
				globalVars.pTwoPowerup = 'none'
				get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoPowerupsHud").changeItem()
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
