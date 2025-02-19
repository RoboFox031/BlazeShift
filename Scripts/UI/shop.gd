extends UI
class_name shop

var pOneOptionSelected = "car"
var pTwoOptionSelected = "car"

var pOneColorSelected = 0
var pTwoColorSelected = 0

var pOneCarSelection = 0
var pTwoCarSelection = 0

@onready var pOneRightArrow = $pOneRightArrow
@onready var pOneLeftArrow = $pOneLeftArrow

@onready var pTwoRightArrow = $pTwoRightArrow
@onready var pTwoLeftArrow = $pTwoLeftArrow

@onready var pOneCarOne = $pOneCarOne
@onready var pOneCarTwo = $pOneCarTwo
@onready var pOneCarThree = $pOneCarThree

@onready var pTwoCarOne = $pTwoCarOne
@onready var pTwoCarTwo = $pTwoCarTwo
@onready var pTwoCarThree = $pTwoCarThree

@onready var pOneWhite = $pOneWhiteCircle
@onready var pOneBlack = $pOneBlackCircle
@onready var pOneRed = $pOneRedCircle
@onready var pOneOrange = $pOneOrangeCircle
@onready var pOneYellow = $pOneYellowCircle
@onready var pOneGreen = $pOneGreenCircle
@onready var pOneBlue = $pOneBlueCircle
@onready var pOnePurple = $pOnePurpleCircle

@onready var pTwoWhite = $pTwoWhiteCircle
@onready var pTwoBlack = $pTwoBlackCircle
@onready var pTwoRed = $pTwoRedCircle
@onready var pTwoOrange = $pTwoOrangeCircle
@onready var pTwoYellow = $pTwoYellowCircle
@onready var pTwoGreen = $pTwoGreenCircle
@onready var pTwoBlue = $pTwoBlueCircle
@onready var pTwoPurple = $pTwoPurpleCircle

@onready var pOneCarOneFinal = $pOneCarOneFinal
@onready var pOneCarTwoFinal = $pOneCarTwoFinal
@onready var pOneCarThreeFinal = $pOneCarThreeFinal

@onready var pTwoCarOneFinal = $pTwoCarOneFinal
@onready var pTwoCarTwoFinal = $pTwoCarTwoFinal
@onready var pTwoCarThreeFinal = $pTwoCarThreeFinal

var pOneColors: Array
var pTwoColors: Array
var pOneCars: Array
var pTwoCars: Array
var pOneCarsFinal: Array
var pTwoCarsFinal: Array

var colors: Array = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]

@onready var cars := {
	"LemkeCar": {
	carScene = preload("res://Scenes/Cars/lemkeCar.tscn"), 
	colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	},
	"NSX": {
	carScene = preload("res://Scenes/Cars/NSX.tscn"), 
	colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	},
	"S13": {
	carScene = preload("res://Scenes/Cars/S13.tscn"), 
	colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	}
}

func _ready() -> void:
	pOneColors = [pOneWhite, pOneBlack, pOneRed, pOneOrange, pOneYellow, pOneGreen, pOneBlue, pOnePurple]
	pTwoColors = [pTwoWhite, pTwoBlack, pTwoRed, pTwoOrange, pTwoYellow, pTwoGreen, pTwoBlue, pTwoPurple]
	pOneCars = [pOneCarOne, pOneCarTwo, pOneCarThree]
	pTwoCars = [pTwoCarOne, pTwoCarTwo, pTwoCarThree]
	pOneCarsFinal = [pOneCarOneFinal, pOneCarTwoFinal, pOneCarThreeFinal]
	pTwoCarsFinal = [pTwoCarOneFinal, pTwoCarTwoFinal, pTwoCarThreeFinal]
	_updateCarDisplay(pOneCars[pOneCarSelection],pTwoCars[pTwoCarSelection])
	_updateColorDisplay(pOneColors[pOneColorSelected],pTwoColors[pTwoColorSelected])
	_updateFinalDisplay(pOneCarsFinal[pOneCarSelection],pTwoCarsFinal[pTwoCarSelection],pOneColors[pOneColorSelected],pTwoColors[pTwoColorSelected])
func _process(delta: float) -> void:
	#sets the player's car and color
	if pOneCarSelection <=2 and pTwoCarSelection<=2:
		globalVars.playerOneCar = cars[pOneCarSelection].carScene
		globalVars.playerOneColor = cars[pOneCarSelection].colors[pOneColorSelected]
		globalVars.playerTwoCar = cars[pTwoCarSelection].carScene
		globalVars.playerTwoColor = cars[pTwoCarSelection].colors[pTwoColorSelected]
	
	if Input.is_action_just_pressed("p1_down") or Input.is_action_just_pressed("p1_up"):
		if pOneOptionSelected == "car":
			pOneOptionSelected = "color"
			for c in pOneColors:
				if c == pOneColors[pOneColorSelected]:
					c.get_child(0).visible = true
				else:
					c.get_child(0).visible = false
				pOneLeftArrow.get_child(0).visible = false
				pOneRightArrow.get_child(0).visible = false
		else:
			pOneOptionSelected = "car"
			for c in pOneColors:
				c.get_child(0).visible = false
			pOneLeftArrow.get_child(0).visible = true
			pOneRightArrow.get_child(0).visible = true
	if Input.is_action_just_pressed("p2_down") or Input.is_action_just_pressed("p2_up"):
		if pTwoOptionSelected == "car":
			pTwoOptionSelected = "color"
			for c in pTwoColors:
				if c == pTwoColors[pTwoColorSelected]:
					c.get_child(0).visible = true
				else:
					c.get_child(0).visible = false
				pTwoLeftArrow.get_child(0).visible = false
				pTwoRightArrow.get_child(0).visible = false
		else:
			pTwoOptionSelected = "car"
			for c in pTwoColors:
				c.get_child(0).visible = false
			pTwoLeftArrow.get_child(0).visible = true
			pTwoRightArrow.get_child(0).visible = true
	if Input.is_action_just_pressed("p1_right"):
		if pOneOptionSelected == "car":
			if pOneCarSelection + 1 < len(pOneCars):
				pOneCarSelection += 1
			else:
				pOneCarSelection = 0
			_updateCarDisplay(pOneCars[pOneCarSelection],pTwoCars[pTwoCarSelection])
		elif pOneOptionSelected == "color":
			if pOneColorSelected + 1 < len(pOneColors):
				pOneColorSelected += 1
			else:
				pOneColorSelected = 0
			_updateColorDisplay(pOneColors[pOneColorSelected],pTwoColors[pTwoColorSelected])
	if Input.is_action_just_pressed("p1_left"):
		if pOneOptionSelected == "car":
			if pOneCarSelection - 1 >= 0:
				pOneCarSelection -= 1
			else:
				pOneCarSelection = len(pOneCars) - 1
			_updateCarDisplay(pOneCars[pOneCarSelection],pTwoCars[pTwoCarSelection])
		elif pOneOptionSelected == "color":
			if pOneColorSelected - 1 >= 0:
				pOneColorSelected -= 1
			else:
				pOneColorSelected = len(pOneColors) - 1
			_updateColorDisplay(pOneColors[pOneColorSelected],pTwoColors[pTwoColorSelected])
	if Input.is_action_just_pressed("p2_right"):
		if pTwoOptionSelected == "car":
			if pTwoCarSelection + 1 < len(pTwoCars):
				pTwoCarSelection += 1
			else:
				pTwoCarSelection = 0
		elif pTwoOptionSelected == "color":
			if pTwoColorSelected + 1 < len(pTwoColors):
				pTwoColorSelected += 1
			else:
				pTwoColorSelected = 0
			_updateColorDisplay(pOneColors[pOneColorSelected],pTwoColors[pTwoColorSelected])
		_updateCarDisplay(pOneCars[pOneCarSelection],pTwoCars[pTwoCarSelection])
	if Input.is_action_just_pressed("p2_left"):
		if pTwoOptionSelected == "car":
			if pTwoCarSelection - 1 >= 0:
				pTwoCarSelection -= 1
			else:
				pTwoCarSelection = len(pTwoCars) - 1
			_updateCarDisplay(pOneCars[pOneCarSelection],pTwoCars[pTwoCarSelection])
		elif pTwoOptionSelected == "color":
			if pTwoColorSelected - 1 >= 0:
				pTwoColorSelected -= 1
			else:
				pTwoColorSelected = len(pTwoColors) - 1
			_updateColorDisplay(pOneColors[pOneColorSelected],pTwoColors[pTwoColorSelected])
	

func _updateCarDisplay(pOneCar,pTwoCar):
	for c in pOneCars:
		if c == pOneCar:
			c.visible = true
		else:
			c.visible = false
	for c in pTwoCars:
		if c == pTwoCar:
			c.visible = true
		else:
			c.visible = false
	_updateFinalDisplay(pOneCarsFinal[pOneCarSelection],pTwoCarsFinal[pTwoCarSelection],pOneColors[pOneColorSelected],pTwoColors[pTwoColorSelected])


func _updateColorDisplay(pOneColor,pTwoColor):
	if pOneOptionSelected == "color":
		for c in pOneColors:
			if c == pOneColor:
				c.scale.x = .15
				c.scale.y = .15
				c.get_child(0).visible = true
			else:
				c.scale.x = .088
				c.scale.y = .088
				c.get_child(0).visible = false
	if pTwoOptionSelected == "color":
		for c in pTwoColors:
			if c == pTwoColor:
				c.scale.x = .15
				c.scale.y = .15
				c.get_child(0).visible = true
			else:
				c.scale.x = .088
				c.scale.y = .088
				c.get_child(0).visible = false
	_updateFinalDisplay(pOneCarsFinal[pOneCarSelection],pTwoCarsFinal[pTwoCarSelection],pOneColors[pOneColorSelected],pTwoColors[pTwoColorSelected])


func _updateFinalDisplay(pOneCar,pTwoCar,pOneColor,pTwoColor):
	for c in pOneCarsFinal:
		if c == pOneCar:
			c.visible = true
			c.play(colors[pOneColorSelected])
			print(colors[pOneColorSelected])
		else:
			c.visible = false
	for c in pTwoCarsFinal:
		if c == pTwoCar:
			c.visible = true
			c.play(colors[pTwoColorSelected])
		else:
			c.visible = false
