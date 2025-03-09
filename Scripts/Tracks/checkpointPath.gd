@tool
extends Path2D

#Allows spacing changes
@export var spacing:float=100
#Controls the length of the checkpoints
@export var checkpointLength:float=100

#refrece of what we are copying
@onready var checkPoint=preload("res://Scenes/Tracks/checkpointArea.tscn")
#refrece of old children node
@onready var oldChildren=$oldChildren

#lets you run the function in the editor
@export var run=false

func _ready():
	#If it is outside the editor, create checkpoints durring the onready function
	if Engine.is_editor_hint()==false:
		updateCheckPoints()

func _process(delta):
	#Only run the create checkpoints in the process function if you are in the editor
	if Engine.is_editor_hint():
		#Allows the function to be ran once in the editor
		if run==false:
			updateCheckPoints()

func updateCheckPoints():
	#disables the fucntion from running again
	run=true
	
	#Deltes the pre-exsiting children
	for child in oldChildren.get_child_count():
			oldChildren.get_child(child).queue_free()
	
	#Stores the lenght of the path
	var pathLength:float=curve.get_baked_length()
	#calculates how many checkpoints the path has room for
	var checkpointCount =floor(pathLength/spacing)
	
	#Creates a number of checkpoints
	for i in range(0,checkpointCount):
		#calculates and stores the distance from the start of the checkpoint
		var curveDistance=spacing*i
		#Makes the checkpoints
		var instance=checkPoint.instantiate()
		#Adds checkpoints to old children so they can be deleted
		oldChildren.add_child(instance)
		
		#Sets postion of checkpoints
		instance.position=curve.sample_baked(curveDistance)
		instance.transform=curve.sample_baked_with_rotation(curveDistance)
		
		#prints number of checkpoints
		#print(i)

func _on_property_list_changed() -> void:
	print("now")
	pass # Replace with function body.
