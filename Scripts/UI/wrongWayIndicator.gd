extends Control

#Stores the which player it belongs to
enum playerChoices{p1,p2}
@export var playerFor:playerChoices
#Allows the enum to be read as a string
var playerForStr:String:
    get:
        return playerChoices.find_key(playerFor)

func _ready():
    if playerForStr=="p1":
        pass
    elif playerForStr=="p2":
        pass