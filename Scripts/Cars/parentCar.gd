extends CharacterBody2D
class_name Car

@onready var colorSprite: AnimatedSprite2D = $Sprite2D


var color = "blue"
var fireball: PackedScene = preload("res://Scenes/Pickups/fireball.tscn")
var paused = false
########
#Important Car Stats:
########
#Holds the resource that controls car stats
@export var stats:carStats
#The variables that change based on cars
var baseAcceleration=1 ##controls acceleration
var baseTopSpeed=1 ##controls top speed
#controls how quickly you turn
var baseTurnSpeed:float=1##controls how quickly you turn
var trueBaseTurnSpeed:float: #Converts the turn speed to radians
	get:
		return baseTurnSpeed*PI/180
#controls how sharply you turn
var baseTurnPower:float=1 ##controls how sharply you turn
var trueTurnPower:float: #Converts the turn power to radians
	get:
		return baseTurnPower*PI/180
#The base deceleration value
var baseDecel=1; ##The base deceleration value
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

#Stores direction the car is traveling in
var turnDirection

#handles traction
var baseTraction:float=1
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

#controls how the car reacts to offroadingsa
var offRoadSpeedMult:float=.6 ##Controls how offroading affects speed and acceleration
var offRoadAccelMult:float=.8 ##Controls how offroading affects turning
var offRoadTurnSpeedMult:float=.8 ##Controls how offroading affects turning speed
var offRoadTurnPowerMult:float=.8 ##Controls how offroading affects turning power
var offRoadDecelMult:float=2 ##Controls how offroading affects decleration 
#controls how the car reacts to ice
var iceSpeedMult:float=1 ##Controls how offroading affects speed and acceleration
var iceAccelMult:float=0.5 ##Controls how offroading affects speed and acceleration
var iceTurnSpeedMult:float=0.1 ##Controls how offroading affects turning speed
var iceTurnPowerMult:float=2 ##Controls how offroading affects turning power
var iceDecelMult:float=0.5 ##Controls how offroading affects decleration

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
var currentTurnPower:float ##controls how sharply you turn
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
var driftNoInput:bool=false

#Stores progress and related variables
#Stores what lap you are on
var currentLap=0
#Stores all the diffrent progress values your car is touching
var touchingProgress=[]
#Stores your current progress
var currentProgress=590
#Stores your last recorded progress
var lastProgress=0
#Stores the position of the last (valid) checkpoint you went through
var progressPoint:Vector2
var progressRot=0
#how far you can skip
var skipTolerance=20
#Stores how long you've reversed for
var reverseCount=0
#Stores how long you can reverse(before it gets mad)
var reverseTolerance=15
#Stores the max distance the player can be from the track
var trackMaxDist=1000

#The signal that is called when you are reversing
signal startReversing
signal stopReversing

func _ready() -> void:
	#for testing upgrades
	#for i in 5:
		#globalUpgrades.upgradeStat(currentOwnerStr,globalVars.currentCarNames[currentOwnerStr],"acceleration")
		#globalUpgrades.upgradeStat(currentOwnerStr,globalVars.currentCarNames[currentOwnerStr],"topSpeed")
	#Setup car stats
	applyStats()
	
	z_index = 6
	#makes you resoawn at the start if you respawn before reaching a valid checkpoint
	progressPoint=global_position
	progressRot=global_rotation


func _physics_process(delta):
	#Checks if the player is too far from the track
	checkTrackDistance()
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
	
	
	if isDrifting==false:
		#Gets the input, and converts it to positive or negitive 1
		turnDirection = Input.get_axis(currentOwnerStr+"_left", currentOwnerStr+"_right")
	if isDrifting==true:
		#if you are drifting, locks your turning in the drifing direction, and only allows for small adjustments
		#turnDirection=currentDrift
		if currentDrift<0:
			turnDirection=clamp(move_toward(turnDirection,Input.get_axis(currentOwnerStr+"_left", currentOwnerStr+"_right"),.05),currentDrift,0)
		elif currentDrift>0:
			turnDirection=clamp(move_toward(turnDirection,Input.get_axis(currentOwnerStr+"_left", currentOwnerStr+"_right"),.05),-0,currentDrift)
		print(turnDirection)
	#If you are clicking a button, turns in that direction based on the acceleration value
	if turnDirection and currentLinSpeed!=0:
		currentTurnForce = move_toward(currentTurnForce, trueCurrentTurnPower*turnDirection*terrainTurnPowerMult, trueCurrentTurnSpeed*terrainTurnSpeedMult)
	#If no button is being clicked, stops turning
	else:
		currentTurnForce = move_toward(currentTurnForce, 0,trueBaseTurnSpeed*terrainTurnSpeedMult)
	
	#Like a car, you can only turn while moving, and going backwards reverses your turn
	if globalVars.canMove == true and paused == false:
		turnOutput= (currentLinSpeed/currentTopSpeed)*currentTurnForce
		rotation_degrees+=turnOutput
	
	#If your traction isn't at it's normal value, and you aren't on ice or drifting, slowly increase the traction
	if(traction!=baseTraction)and(currentTerrain!=trackEnums.terrainTypes.ice) and (isDrifting==false):
		traction=move_toward(traction,baseTraction,4)
	#Sets the velocity to fwd vector added to the drift vector
	fwdVector=Vector2(currentLinSpeed*cos(rotation),currentLinSpeed*sin(rotation))
	driftVector=Vector2(move_toward(driftVector.x,fwdVector.x,traction),move_toward(driftVector.y,fwdVector.y,traction))
	velocity=(fwdVector+driftVector)/2
	
	if globalVars.canMove == true and paused == false:
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

func usePowerup():
	if globalVars.pOnePowerup != 'none':
		if globalVars.pOnePowerup == "blazePickup":
			globalVars.pOnePowerup = 'none'
			get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOnePowerupsHud").changeItem('p1')
			print()
			if globalVars.p1BlazeCurrent + (get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazeMax * get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazePowerupFill) <= get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazeMax:
				globalVars.p1BlazeCurrent += (get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazeMax * get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazePowerupFill) 
			else:
				globalVars.p1BlazeCurrent = get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOneBlazeHud").blazeMax
		if globalVars.pOnePowerup == 'fireballPickup':
			globalVars.pOnePowerup = 'none'
			var instance = fireball.instantiate()
			instance.spawnPosition = global_position
			instance.direction = rotation 
			get_node('/root/trackLoader/hSplitContainer/subViewportContainer/subViewport/track').add_child(instance)
			if currentOwner == playerChoices.p1:
				get_node("/root/trackLoader/hSplitContainer/subViewportContainer/canvasLayer/pOnePowerupsHud").changeItem('p1')
	if globalVars.pTwoPowerup != 'none':
		if globalVars.pTwoPowerup == "blazePickup":
			globalVars.pTwoPowerup = 'none'
			get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoPowerupsHud").changeItem('p2')
			if globalVars.p2BlazeCurrent + (get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazeMax * get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazePowerupFill) <= get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazeMax:
				globalVars.p2BlazeCurrent += (get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazeMax * get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazePowerupFill) 
			else:
				globalVars.p2BlazeCurrent = get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoBlazeHud").blazeMax
		if globalVars.pTwoPowerup == 'fireballPickup':
			globalVars.pTwoPowerup = 'none'
			var instance = fireball.instantiate()
			if currentOwner == playerChoices.p2:
				add_child(instance)
				get_node("/root/trackLoader/hSplitContainer/subViewportContainer2/canvasLayer/pTwoPowerupsHud").changeItem('p2')


		



func _input(event):
	#Allows boost
	if Input.is_action_just_pressed('test'):
		print('next lap')
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index('music'),-100)
	if globalVars.canMove == true and paused == false:
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
		#stop listening for a directional input
		driftNoInput=false
	#If you tried to drift but wern't turning, listen for a turning action
	if driftNoInput==true:
		#Rerun the drift action when a turn is started
		if Input.is_action_just_pressed(currentOwnerStr+"_left") or Input.is_action_just_pressed(currentOwnerStr+"_right")  :
			startDrift()
		if Input.is_action_just_released(currentOwnerStr+"_l1"):
			print(currentOwnerStr+" stopped drifting")
			resetMovement()
			#stop listening for a directional input
			driftNoInput=false
		#If you tried to drift but wern't turning, listen for a turning action
		if driftNoInput==true:
			#Rerun the drift action when a turn is started
			if Input.is_action_just_pressed(currentOwnerStr+"_left") or Input.is_action_just_pressed(currentOwnerStr+"_right")  :
				startDrift()

	#Control powerups
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
	traction=baseTraction

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
	if Input.is_action_pressed(currentOwnerStr+"_left"):
		currentDrift=driftDir.lDrift
		#Locks drifitng direction
		driftNoInput=false
		print(currentOwnerStr+" is drifting left")
	elif Input.is_action_pressed(currentOwnerStr+"_right"):
		currentDrift=driftDir.rDrift
		#Locks drifitng direction
		driftNoInput=false
		print(currentOwnerStr+" is drifting right")
	#If you aren't turning, change the variable to match
	if currentDrift==driftDir.none:
		driftNoInput=true
		print(currentOwnerStr+" tried to drift")
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
			
		#If you drive on a hazard, respawn
		elif newTerrain==trackEnums.terrainTypes.hazzard:
			respawn()

func updatePosition(area:Area2D):
	if area is checkpoint:
		#Adds the area to the array
		touchingProgress.append(area)
		#prints all currently touching progresses
		#print(touchingProgress)
		#Stores the progress that we are checking
		var checkProgress=area.progress
		
		#Stores if the player is reversing
		var isReverse:bool=false
		for checkpoints in touchingProgress:
			#Only runs anything else if it hasn't found a reverse yet
			if isReverse==false:
				#Checks if all checkpoints are reversing, if not, ignore the reverse
				if checkpoints.progress<currentProgress:
					#Calculates how far you reversed
					var reverseAmount=currentProgress-checkpoints.progress
					#If you reversed enough, assume that the player has completed a lap
					if (reverseAmount>590):
						nextLap()
						return
					#if you didn't reverse enough, then mark the current checkpoint as a reverse
					else:
						isReverse=true
						currentProgress=area.progress
						#Updates the global
						globalVars.progress[currentOwnerStr]=currentProgress
						#Stores the position and rotation of the legal point
						progressPoint=area.global_position
						progressRot=area.global_rotation
						print(currentOwnerStr+" reverse "+str(reverseCount))
						#increase the reverse count 
						reverseCount+=1
						if(reverseCount>reverseTolerance):
							startReversing.emit()
						
		
		#Stores if any of the progress movements are legal
		var anyLegalMove=false
		#Stores the largest legal move you can make and the progress
		var farthestLegalMove:Area2D
		var largestLegalProgress=0
		#Makes sure at least one checkpoint the player is touching is within the skip tolerance
		for checkpoints in touchingProgress:
			if checkpoints.progress-currentProgress<skipTolerance:
				anyLegalMove=true
				if farthestLegalMove!=null:
					#Sees if this legal move is larger than any other legal move in the loop, and stores it if it is
					if checkpoints.progress<farthestLegalMove.progress:
						farthestLegalMove=checkpoints
						largestLegalProgress=farthestLegalMove.progress
				else:
					farthestLegalMove=checkpoints
					largestLegalProgress=checkpoints.progress
		#If none of the progress point you are touching result in legal moves, respawn
		if anyLegalMove==false:
			print("Illegal")
			#respawn()
			pass
		#If you didn't skip and aren't reversing, then update the progress
		elif isReverse==false:
			lastProgress=currentProgress
			currentProgress=largestLegalProgress
			#Updates the global
			globalVars.progress[currentOwnerStr]=currentProgress
			#Stores the position and rotation of the legal point
			progressPoint=area.global_position
			progressRot=area.global_rotation
			#resets reverse
			reverseCount=0
			stopReversing.emit()
			#Prints info about the player's position
			# print(currentOwnerStr+" progress: "+str(currentProgress))#+", point: " +str(progressPoint))

#This function removes progress points you are touching from the array they are in
func leavePosition(area:Area2D):
	if area is checkpoint:
		touchingProgress.erase(area)

#This function respawns the car at the last legal location
func respawn():
	#Resets the player's speed
	currentLinSpeed=0
	resetMovement()
	#Teleports the player
	global_position=progressPoint
	global_rotation=progressRot
	#resets reverse count
	reverseCount=0
	pass

#Makes the player be on the next lap
func nextLap():
	#If you are on lap 3, end the race
	if currentLap==3:
		if currentOwnerStr == 'p1':
			globalVars.pOneDone = true
			if globalVars.pTwoLastRacePlacement == null:
				globalVars.pOneLastRacePlacement = '1st'
				playerWin(globalVars.pOneName)
			elif globalVars.pTwoLastRacePlacement == '1st':
				globalVars.pOneLastRacePlacement = '2nd'
				print('p1 2nd')
		elif currentOwnerStr == 'p2':
			globalVars.pTwoDone = true
			if globalVars.pOneLastRacePlacement == null:
				globalVars.pTwoLastRacePlacement = '1st'
				playerWin(globalVars.pTwoName)
				print('p2 first')
			elif globalVars.pOneLastRacePlacement == '1st':
				globalVars.pTwoLastRacePlacement = '2nd'
				print('p2 second')
		if globalVars.pOneDone == true and globalVars.pTwoDone == true:
			if currentOwnerStr == 'p1':
				globalVars.saveScores(globalVars.track.instantiate().name,globalVars.pOneName,float(globalVars.pOneLastRaceTime))
				finishRace()
			if currentOwnerStr == 'p2':
				globalVars.saveScores(globalVars.track.instantiate().name,globalVars.pTwoName,float(globalVars.pTwoLastRaceTime))
				finishRace()
		elif globalVars.pOneDone == true or globalVars.pTwoDone == true:
			paused = true
			if currentOwnerStr == 'p1':
				globalVars.saveScores(globalVars.track.instantiate().name,globalVars.pOneName,float(globalVars.pOneLastRaceTime))
			if currentOwnerStr == 'p2':
				globalVars.saveScores(globalVars.track.instantiate().name,globalVars.pTwoName,float(globalVars.pTwoLastRaceTime))
		
	
	#If you aren't on lap 3, add one to the lap and reset the position
	else:
		currentLap+=1
		currentProgress=0
		globalVars.progress[currentOwnerStr]=0
		lastProgress=0
		touchingProgress=[]
		#Update globals
		globalVars.laps[currentOwnerStr]=currentLap
		# print(str(currentOwnerStr)+" lap "+str(globalVars.laps[currentOwnerStr]]))
		print(str("p1")+" lap "+str(globalVars.laps["p1"]))
		print(str("p2")+" lap "+str(globalVars.laps["p2"]))
		# print(str(currentOwnerStr)+" progress "+str(globalVars.progress[currentOwnerStr]))

#Checks if you are close enough to the track	
func checkTrackDistance():
	#updates how far away the player is from the track
	var currentDistance=global_position.distance_to(progressPoint)
	#if the player is too far away, respawn
	if (currentDistance>trackMaxDist):
		#respawn()
		pass

#finishes the race
func finishRace():
	var trackName = globalVars.track.instantiate().name
	if currentOwnerStr == 'p1':
		globalVars.saveScores(trackName,globalVars.pOneName,globalVars.pOneLastRaceTime)
	if currentOwnerStr == 'p1':
		globalVars.saveScores(trackName,globalVars.pTwoName,globalVars.pTwoLastRaceTime)
	get_tree().change_scene_to_file("res://Scenes/UI/raceFinishScreen.tscn")
	print("ur done!")
#Sets the stats of the car based on the resource and upgrades
func applyStats():
	baseAcceleration=stats.acceleration+globalUpgrades.statValue(currentOwnerStr,globalVars.currentCarNames[currentOwnerStr],"acceleration")
	baseTopSpeed=stats.topSpeed+globalUpgrades.statValue(currentOwnerStr,globalVars.currentCarNames[currentOwnerStr],"topSpeed")
	baseTurnSpeed=stats.turnSpeed
	baseTurnPower=stats.turnPower
	baseDecel=stats.deceleration
	baseTraction=stats.traction
	
	#Print the upgraded stats
	print("accel: "+str(baseAcceleration))
	print("top speed: "+str(baseTopSpeed))
	print("handling: "+str(baseAcceleration))
	
	#Resets movement to apply changes
	resetMovement()
	
func playerWin(winner):
	if winner == globalVars.pOneName:
		globalVars.pOneTotalWins += 1
		pass
	elif winner == globalVars.pTwoName:
		globalVars.pTwoTotalWins += 1
	if globalVars.pOneTotalWins > globalVars.pTwoTotalWins:
		globalVars.pOneOverallPlacement = '1st'
		globalVars.pTwoOverallPlacement = '2nd'
	if globalVars.pOneTotalWins < globalVars.pTwoTotalWins:
		globalVars.pOneOverallPlacement = '2nd'
		globalVars.pTwoOverallPlacement = '1st'
	if globalVars.pOneTotalWins == globalVars.pTwoTotalWins:
		globalVars.pOneOverallPlacement = 'Tie'
		globalVars.pTwoOverallPlacement = 'Tie'
	pass
