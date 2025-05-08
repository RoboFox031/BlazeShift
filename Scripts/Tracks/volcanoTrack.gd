extends tracks

@onready var p1Spawn=$spawns/p1CarSpawn
@onready var p2Spawn=$spawns/p2CarSpawn

# Called when the node enters the scene tree for the first time.
func _ready():
	p1Start=p1Spawn.global_position
	p2Start=p2Spawn.global_position
	playerRotation=p1Spawn.global_rotation_degrees
	loadCars()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
