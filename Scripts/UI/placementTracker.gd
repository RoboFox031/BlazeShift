extends Control

#Allows acess of the animation player
@onready var animationPlayer: AnimationPlayer = $animationPlayer



#Stores the lap for each player
var p1Lap=0
var p2Lap=0
#Stores the progress for each player
var p1Progress=0
var p2Progress=0

func _process(delta):
	#Updates the variables
	p1Lap=globalVars.laps["p1"]
	p2Lap=globalVars.laps["p2"]
	p1Progress=globalVars.progress["p1"]
	p2Progress=globalVars.progress["p2"]

	#Prints all the varibles (for debuging)
	print("p1 Lap "+str(p1Lap)+" p2 Lap "+str(p2Lap))
	print("p1 progress "+str(p1Progress)+" p2 progress "+str(p2Progress))
	
	
	########################################################## Add an if statement that only lets this all run if no one has finished the race
	
	#Only runs the other things when the animation is finished
	await(animationPlayer.animation_finished)
	#If there's a tie, run the correct function
	if(p1Lap==p2Lap and p1Progress==p2Progress):
		tie()
	#if they aren't in a tie, check if they are on the same lap
	elif(p1Lap==p2Lap):
		#if they are on the same lap, check who has the larger progress
	
		#if player two has larger progress, then they're in the lead
		if(p1Progress<p2Progress):
			p2Lead()
		#if player one has larger progress, then they're in the lead
		elif(p1Progress>p2Progress):
			p1Lead()
	#if they aren't on the same lap, whoever is on the larget lap is in the lead
	elif(p1Lap<p2Lap):
		#player 2 is on a larger map, so they're in the lead
		p2Lead()
	elif(p1Lap>p2Lap):
		#Player 1 is on a larger lap, so they're in the lead
		p1Lead()


#The function that runs when there is a tie
func tie():
	animationPlayer.play("tie")

#The function that runs when there is not a tie
func noTie():
	animationPlayer.play("noTie")

#displays p2 as in the lead
func p2Lead():
	noTie()
	animationPlayer.play("p2Lead")

#displays p1 as in the lead
func p1Lead():
	noTie()
	animationPlayer.play("p1Lead")
