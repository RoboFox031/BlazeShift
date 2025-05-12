extends Node2D

func _ready():
	$sprite2d.play('none')
	
func splatter():
	$cpuParticles2d.emitting = true
	


#func _on_timer_timeout():
	#print('hide')
	#$sprite2d.play('none')
	pass # Replace with function body.
