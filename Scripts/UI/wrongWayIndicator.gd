extends Control
@onready var animationPlayer:AnimationPlayer=$animationPlayer
#Stores the which player it belongs to
enum playerChoices{p1,p2}
@export var playerFor:playerChoices
#Allows the enum to be read as a string
var playerForStr:String:
	get:
		return playerChoices.find_key(playerFor)

#Stores a path to each player
var carOwner:Car

func _ready():
	visible=false
	call_deferred("updatePaths")
	

#This function
func updatePaths():
	#Sets the owner varible depeding on who owns this reversing indicator
	if playerForStr=="p1":
		#sets the variables\
		carOwner=$"../../subViewport/track/player1"
	elif playerForStr=="p2":
		carOwner=$"../../subViewport/track/player2"

	#Connects signals from the owner
	# print(carOwner.startReversing)
	carOwner.startReversing.connect(startReverse)
	carOwner.stopReversing.connect(stopReverse)


#Start reverseing animation
func startReverse():
	#Only play when hiddem, to prevent repeating the animation
	if(visible==false):
		animationPlayer.play("appear")
		await(animationPlayer.animation_finished)
		animationPlayer.play("flash")

#Stop reverseing animation
func stopReverse():
	visible=false
	#animationPlayer.play("flash")
