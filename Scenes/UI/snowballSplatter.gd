extends Node2D

func _ready():
	$sprite2d.play('none')
	
func splatter():
	$sprite2d.play('splatter')
	$timer.start(5)
	


func _on_timer_timeout():
	print('hide')
	$sprite2d.play('none')
	pass # Replace with function body.
