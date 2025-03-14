@tool
extends Area2D
class_name checkpoint
#Acesses the parent
@onready var parentPath=$"../../"
#Stores the length
var length:float
#stores the progress of the point
var progress:int=0
#allows acess of the colision shape
@onready var colisionShape:CollisionShape2D=$collisionShape2d
func _ready() -> void:
	#Sets the length
	length=parentPath.checkpointLength
	#Sets the length of the shape to the length
	colisionShape.shape.b.y=length
	#print(parentPath)
	#offsets the shape to the center based on the length
	colisionShape.position.y=-length/2
