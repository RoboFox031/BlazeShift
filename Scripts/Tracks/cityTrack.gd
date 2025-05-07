extends tracks

@onready var p1Spawn=$spawns/p1CarSpawn
@onready var p2Spawn=$spawns/p2CarSpawn

# Called when the node enters the scene tree for the first time.
func _ready():
	p1Start=p1Spawn.position
	p2Start=p2Spawn.position
	playerRotation=p1Spawn.rotation
	loadCars()
