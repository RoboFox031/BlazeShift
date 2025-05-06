extends pickup
class_name roadSpikes

var spawnPosition
var direction
@onready var sprite = $animatedSprite2d
var ignore

func _ready():
	type = 'roadSpikes'
	self.position = spawnPosition
	self.z_index = 10
	self.sprite.rotation = direction
func _on_area_2d_body_entered(body):
	if body != ignore and body is Car:
		body.respawn()
		queue_free()
		
	
