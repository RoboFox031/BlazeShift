@tool
extends Path2D

#Allows spacing changes
@export var spacing:float=100

#refrece of what we are copying
@onready var checkPoint=$checkpointArea
#refrece of old children node
@onready var oldChildren=$oldChildren

#trakcs if the function has been run
@export var hasRan=false

func _ready():
    #updateCheckPoints()
    pass

func _process(delta):
    if hasRan==false:
        for child in oldChildren.get_child_count():
            oldChildren.get_child(child).queue_free()
        updateCheckPoints()

func updateCheckPoints():
    #disables the fucntion from running again
    hasRan=true
    #Stores the lenght of the path
    var pathLength:float=curve.get_baked_length()
    #calculates how many checkpoints the path has room for
    var checkpointCount =floor(pathLength/spacing)

    for i in range(0,checkpointCount):
        #calculates and stores the distance from the start of the checkpoint
        var curveDistance=spacing*i
        #Makes more checkpoints
        var instance:Area2D=checkPoint.duplicate(1)
        oldChildren.add_child(instance)
        instance.position=curve.sample_baked(curveDistance)
        print(i)

