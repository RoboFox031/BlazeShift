extends pickup
class_name roadSpikes

var spawnPosition
var direction
@onready var sprite = $animatedSprite2d

func _ready():
	type = 'roadSpikes'
	self.position = spawnPosition
	self.z_index = 10
	sprite.rotation = direction
func _on_area_2d_body_entered(Car):
	pass
	
