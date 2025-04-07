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

    #If there's a tie, run the correct function
    if(p1Lap==p2Lap and p1Progress==p2Progress):
        tie()
    #if they aren't in a tie, check if they are on the same lap
    elif(p1Lap==p2Lap):
        #if they are on the same lap, check who has the larger progress
        pass
    #if player two has larger progress, then they're in the lead
    elif(p1Progress<p2Progress):
        pass



#The function that runs when there is a tie
func tie():
    animationPlayer.play("tie")

#The function that runs when there is not a tie
func noTie():
    animationPlayer.play("noTie")