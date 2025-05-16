extends Node2D

var x =255
var y =255
var z =255
var fade = false

func _ready():
	$animationPlayer.play('intro')

func _physics_process(delta):
	if fade == true:
		x-=delta*200
		y-=delta*200
		z-=delta*200
		$label.modulate = Color8(x,y,z)

func startFade():
	$colorRect.modulate = Color8(0,0,0)

func fadeout():
	fade = true

func nextColor():
	$colorRect.modulate = Color('272727')
	
func titleScreen():
	get_tree().change_scene_to_file("res://Scenes/UI/titleScreen.tscn")
