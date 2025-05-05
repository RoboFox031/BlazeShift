extends AnimatedSprite2D

#sets the car the tire belongs to as the owner
@onready var playerOwner:Car = $"../../"

#the tires should always start at 90 degrees
var startingRot=90

#Controls the max degrees the wheels can turn from their starting value
var maxTurn=30

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	#rotation_degrees=startingRot+playerOwner.turnDirection
	#rotation_degrees=move_toward(rotation_degrees,startingRot+(maxTurn*playerOwner.turnDirection),1)
	rotation_degrees=startingRot+(5*playerOwner.currentTurnForce)
	print(rotation_degrees)
