extends Car
class_name playerOneCar

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	
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
				get_node("/root/trackLoader/hSplitContainer/subViewportContainer/subViewport/track/ScreenPlayer1").add_child(instance)
				get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOnePowerupsHud").changeItem()
				
	# Add the gravity.dsad

	# Handle jump.


	# Get the input direction and handle the movement/deceleradastion.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var xdirection = Input.get_axis("p1_left", "p1_right")
	var ydirection = Input.get_axis("p1_up", "p1_down")
	if xdirection:
		velocity.x = xdirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if ydirection:
		velocity.y = ydirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
