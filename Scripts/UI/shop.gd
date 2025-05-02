extends UI
class_name shop

####order in the shop for the cars goes as follows Mustang, NSX, S13, CRX,FC RX7, 69 Charger, Lancia 037, Lotus Esprit, RUF CTR, 300ZX 

var pOneReady = false
var pTwoReady = false

var pOneOptionSelected = "car"
var pTwoOptionSelected = "car"

@onready var pOneRightArrow = $pOneRightArrow
@onready var pOneLeftArrow = $pOneLeftArrow

@onready var pTwoRightArrow = $pTwoRightArrow
@onready var pTwoLeftArrow = $pTwoLeftArrow

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

@onready var pOneOwnedLabel = $pOneOwnedLabel
@onready var pTwoOwnedLabel = $pTwoOwnedLabel

@onready var pOneCostLabel = $pOneCostLabel
@onready var pTwoCostLabel = $pTwoCostLabel


var pOneColors: Array
var pTwoColors: Array
var pOneCars: Array = []
var pTwoCars: Array = []
var pOneCarsFinal: Array = []
var pTwoCarsFinal: Array = []
var pOneOwned: Array
var pTwoOwned: Array

var colors: Array = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]

var carStringNames: Array = ['Mustang/Mustang','NSX/NSX','S13/S13',"CRX/CRX","FC RX7/FC RX7","69 Charger/69 Charger","Lancia 037/Lancia 037","Lotus Esprit/Lotus Esprit","RUF CTR/RUF CTR","300ZX/300ZX"]
var carNames: Array = ['Mustang', "NSX", "S13","CRX","FC RX7","69 Charger","Lancia 037","Lotus Esprit","RUF CTR","300ZX"]

var cars := {
	"Mustang": {
	carScene = preload("res://Scenes/Cars/Mustang.tscn"), 
	colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	},
	"NSX": {
	carScene = preload("res://Scenes/Cars/NSX.tscn"), 
	colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	},
	"S13": {
	carScene = preload("res://Scenes/Cars/S13.tscn"), 
	colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	},
	"CRX": {
		carScene = preload("res://Scenes/Cars/CRX.tscn"),
		colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	},
	"FC RX7": {
		carScene = preload("res://Scenes/Cars/FCRX7.tscn"),
		colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	},
	"69 Charger": {
		carScene = preload("res://Scenes/Cars/96Charger.tscn"),
		colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	},
	"Lancia 037": {
		carScene = preload("res://Scenes/Cars/lancia037.tscn"),
		colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	},
	"Lotus Esprit": {
		carScene = preload("res://Scenes/Cars/lotusEsprit.tscn"),
		colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	},
	"RUF CTR": {
		carScene = preload("res://Scenes/Cars/rufCTR.tscn"),
		colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	},
	"300ZX": {
		carScene = preload("res://Scenes/Cars/300ZX.tscn"),
		colors = ["white", "black", "red", "orange", "yellow", "green", "blue", "purple"]
	},
}

var carCosts: Array = [0,0,1,2,1,1,1,1,1,1] #the position in the array relates to the car

func _ready() -> void:
	pOneColors = [pOneWhite, pOneBlack, pOneRed, pOneOrange, pOneYellow, pOneGreen, pOneBlue, pOnePurple]
	pTwoColors = [pTwoWhite, pTwoBlack, pTwoRed, pTwoOrange, pTwoYellow, pTwoGreen, pTwoBlue, pTwoPurple]
	for car in $pOneCars.get_children():
		pOneCars.append(car)
	for car in $pTwoCars.get_children():
		pTwoCars.append(car)
	for car in $pOneCarsFinal.get_children():
		pOneCarsFinal.append(car)
	for car in $pTwoCarsFinal.get_children():
		pTwoCarsFinal.append(car)
	pOneOwned = [pOneCars[0],pOneCars[1]]
	pTwoOwned = [pTwoCars[0],pTwoCars[1]]
	
	_updateCarDisplay(pOneCars[globalVars.pOneCarSelected],pTwoCars[globalVars.pTwoCarSelected])
	_updateColorDisplay(pOneColors[globalVars.pOneColorSelected],pTwoColors[globalVars.pTwoColorSelected])
	_updateFinalDisplay(pOneCarsFinal[globalVars.pOneCarSelected],pTwoCarsFinal[globalVars.pTwoCarSelected],pOneColors[globalVars.pOneColorSelected],pTwoColors[globalVars.pTwoColorSelected])
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed('p1_start'):
		if pOneReady == false and pOneCars[globalVars.pOneCarSelected] in pOneOwned:
			pOneReady = true
		else:
			pOneReady = false
		_updateReadyScreen()
	if Input.is_action_just_pressed("p2_start"):
		if pTwoReady == false and pTwoCars[globalVars.pTwoCarSelected] in pTwoOwned:
			pTwoReady = true
		else:
			pTwoReady = false
		_updateReadyScreen()
		
	if (Input.is_action_just_pressed("p1_down") or Input.is_action_just_pressed("p1_up")) and pOneReady == false:
		
		if pOneOptionSelected == "car":
			pOneOptionSelected = "color"
			for c in pOneColors:
				if c == pOneColors[globalVars.pOneColorSelected]:
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
	if (Input.is_action_just_pressed("p2_down") or Input.is_action_just_pressed("p2_up"))  and pTwoReady == false:
		if pTwoOptionSelected == "car":
			pTwoOptionSelected = "color"
			for c in pTwoColors:
				if c == pTwoColors[globalVars.pTwoColorSelected]:
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
	if Input.is_action_just_pressed("p1_right") and pOneReady == false:
		if pOneOptionSelected == "car":
			if globalVars.pOneCarSelected + 1 < len(pOneCars):
				globalVars.pOneCarSelected += 1
			else:
				globalVars.pOneCarSelected = 0
			_updateCarDisplay(pOneCars[globalVars.pOneCarSelected],pTwoCars[globalVars.pTwoCarSelected])
		elif pOneOptionSelected == "color":
			if globalVars.pOneColorSelected + 1 < len(pOneColors):
				globalVars.pOneColorSelected += 1
			else:
				globalVars.pOneColorSelected = 0
			_updateColorDisplay(pOneColors[globalVars.pOneColorSelected],pTwoColors[globalVars.pTwoColorSelected])
	if Input.is_action_just_pressed("p1_left") and pOneReady == false:
		if pOneOptionSelected == "car":
			if globalVars.pOneCarSelected - 1 >= 0:
				globalVars.pOneCarSelected -= 1
			else:
				globalVars.pOneCarSelected = len(pOneCars) - 1
			_updateCarDisplay(pOneCars[globalVars.pOneCarSelected],pTwoCars[globalVars.pTwoCarSelected])
		elif pOneOptionSelected == "color":
			if globalVars.pOneColorSelected - 1 >= 0:
				globalVars.pOneColorSelected -= 1
			else:
				globalVars.pOneColorSelected = len(pOneColors) - 1
			_updateColorDisplay(pOneColors[globalVars.pOneColorSelected],pTwoColors[globalVars.pTwoColorSelected])
	if Input.is_action_just_pressed("p2_right") and pTwoReady == false:
		if pTwoOptionSelected == "car":
			if globalVars.pTwoCarSelected + 1 < len(pTwoCars):
				globalVars.pTwoCarSelected += 1
			else:
				globalVars.pTwoCarSelected = 0
		elif pTwoOptionSelected == "color":
			if globalVars.pTwoColorSelected + 1 < len(pTwoColors):
				globalVars.pTwoColorSelected += 1
			else:
				globalVars.pTwoColorSelected = 0
			_updateColorDisplay(pOneColors[globalVars.pOneColorSelected],pTwoColors[globalVars.pTwoColorSelected])
		_updateCarDisplay(pOneCars[globalVars.pOneCarSelected],pTwoCars[globalVars.pTwoCarSelected])
	if Input.is_action_just_pressed("p2_left") and pTwoReady == false:
		if pTwoOptionSelected == "car":
			if globalVars.pTwoCarSelected - 1 >= 0:
				globalVars.pTwoCarSelected -= 1
			else:
				globalVars.pTwoCarSelected = len(pTwoCars) - 1
			_updateCarDisplay(pOneCars[globalVars.pOneCarSelected],pTwoCars[globalVars.pTwoCarSelected])
		elif pTwoOptionSelected == "color":
			if globalVars.pTwoColorSelected - 1 >= 0:
				globalVars.pTwoColorSelected -= 1
			else:
				globalVars.pTwoColorSelected = len(pTwoColors) - 1
			_updateColorDisplay(pOneColors[globalVars.pOneColorSelected],pTwoColors[globalVars.pTwoColorSelected])
	if Input.is_action_just_pressed("p1_a") and pOneReady == false:
		_buyCar(1)
	if Input.is_action_just_pressed("p2_a") and pTwoReady == false:
		_buyCar(2)

#updates the car display
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
	if pOneCars[globalVars.pOneCarSelected] in pOneOwned:
		pOneCostLabel.visible = false
		$locks/pOneCarLock.visible = false
	else:
		pOneCostLabel.visible = true
		if carCosts[globalVars.pOneCarSelected] == 1:
			pOneCostLabel.text = str(carCosts[globalVars.pOneCarSelected]) + " coin"
		else:
			pOneCostLabel.text = str(carCosts[globalVars.pOneCarSelected]) + " coins"
		$locks/pOneCarLock.visible = true
	if pTwoCars[globalVars.pTwoCarSelected] in pTwoOwned:
		pTwoCostLabel.visible = false
		$locks/pTwoCarLock.visible = false
	else:
		pTwoCostLabel.visible = true
		if carCosts[globalVars.pTwoCarSelected] == 1:
			pTwoCostLabel.text = str(carCosts[globalVars.pTwoCarSelected]) + " coin"
		else:
			pOneCostLabel.text = str(carCosts[globalVars.pOneCarSelected]) + " coins"
		$locks/pTwoCarLock.visible = true
	_updateFinalDisplay(pOneCarsFinal[globalVars.pOneCarSelected],pTwoCarsFinal[globalVars.pTwoCarSelected],pOneColors[globalVars.pOneColorSelected],pTwoColors[globalVars.pTwoColorSelected])
	_updateCarNameLabels()
	_updateBuyButtonLabels()

#updates the color selector row
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
	_updateFinalDisplay(pOneCarsFinal[globalVars.pOneCarSelected],pTwoCarsFinal[globalVars.pTwoCarSelected],pOneColors[globalVars.pOneColorSelected],pTwoColors[globalVars.pTwoColorSelected])

#updates the middle display based on the type of car and color
func _updateFinalDisplay(pOneCar,pTwoCar,pOneColor,pTwoColor):
	$uiSFX.playCursorMoveSound()
	for c in pOneCarsFinal:
		if c == pOneCar:
			c.visible = true
			c.play(colors[globalVars.pOneColorSelected])
		else:
			c.visible = false
	for c in pTwoCarsFinal:
		if c == pTwoCar:
			c.visible = true
			c.play(colors[globalVars.pTwoColorSelected])
		else:
			c.visible = false
	if pOneCars[globalVars.pOneCarSelected] in pOneOwned:
		pOneOwnedLabel.text = "owned"
		pOneOwnedLabel.position.x = 362
		pOneOwnedLabel.add_theme_color_override("font_color", Color("008b00"))
		$locks/pOneLockFinal.visible = false
	else:
		pOneOwnedLabel.text = "not owned"
		pOneOwnedLabel.position.x = 280
		pOneOwnedLabel.add_theme_color_override("font_color", Color("9f0000"))
		$locks/pOneLockFinal.visible = true
	if pTwoCars[globalVars.pTwoCarSelected] in pTwoOwned:
		pTwoOwnedLabel.text = "owned"
		pTwoOwnedLabel.position.x = 1330
		pTwoOwnedLabel.add_theme_color_override("font_color", Color("008b00"))
		$locks/pTwoLockFinal.visible = false
	else:
		pTwoOwnedLabel.text = "not owned"
		pTwoOwnedLabel.position.x = 1245
		pTwoOwnedLabel.add_theme_color_override("font_color", Color("9f0000"))
		$locks/pTwoLockFinal.visible = true

#function to allow the player to buy a car######this might be broken helpppp
func _buyCar(player):
	if player == 1:
		if pOneCars[globalVars.pOneCarSelected] not in pOneOwned:
			if globalVars.pOneCoins - carCosts[globalVars.pOneCarSelected] >= 0:
				pOneOwned.append(pOneCars[globalVars.pOneCarSelected])
				globalVars.pOneCoins -= carCosts[globalVars.pOneCarSelected]
				$pOneCoinHud.update()
				$uiSFX.playBuySound()
				_updateFinalDisplay(pOneCarsFinal[globalVars.pOneCarSelected],pTwoCarsFinal[globalVars.pTwoCarSelected],pOneColors[globalVars.pOneColorSelected],pTwoColors[globalVars.pTwoColorSelected])
				_updateCarDisplay(pOneCars[globalVars.pOneCarSelected],pTwoCars[globalVars.pTwoCarSelected])
	if player == 2:
		if pTwoCars[globalVars.pTwoCarSelected] not in pTwoOwned:
			if globalVars.pTwoCoins - carCosts[globalVars.pTwoCarSelected] >= 0:
				pTwoOwned.append(pTwoCars[globalVars.pTwoCarSelected])
				globalVars.pTwoCoins -= carCosts[globalVars.pTwoCarSelected]
				$pTwoCoinHud.update()
				$uiSFX.playBuySound()
				_updateFinalDisplay(pTwoCarsFinal[globalVars.pTwoCarSelected],pTwoCarsFinal[globalVars.pTwoCarSelected],pOneColors[globalVars.pOneColorSelected],pTwoColors[globalVars.pTwoColorSelected])
				_updateCarDisplay(pOneCars[globalVars.pOneCarSelected],pTwoCars[globalVars.pTwoCarSelected])

#updates the global vars before moving onto the upgrade shop
func _changeGlobalVars():
	var carNames = cars.keys()
	globalVars.playerOneCar = cars[carNames[globalVars.pOneCarSelected]].carScene
	globalVars.playerOneColor = cars[carNames[globalVars.pOneCarSelected]].colors[globalVars.pOneColorSelected]
	globalVars.currentCarNames["p1"]=str(carNames[globalVars.pOneCarSelected])
	globalVars.playerTwoCar = cars[carNames[globalVars.pTwoCarSelected]].carScene
	globalVars.playerTwoColor = cars[carNames[globalVars.pTwoCarSelected]].colors[globalVars.pTwoColorSelected]
	globalVars.currentCarNames["p2"]=str(carNames[globalVars.pTwoCarSelected])
	globalVars.playerOneCarSprite = carStringNames[globalVars.pOneCarSelected] + colors[globalVars.pOneColorSelected].capitalize()
	globalVars.playerTwoCarSprite = carStringNames[globalVars.pTwoCarSelected] + colors[globalVars.pTwoColorSelected].capitalize()

#updates ready screen
func _updateReadyScreen():
	$uiSFX.playSelectSound()
	await get_tree().create_timer(0.5).timeout 
	if pOneReady == true:
		$pOneReadyScreen.visible = true
	else:
		$pOneReadyScreen.visible = false
	if pTwoReady == true:
		$pTwoReadyScreen.visible = true
	else:
		$pTwoReadyScreen.visible = false
	if pOneReady == true and pTwoReady == true:
		_changeGlobalVars()
		get_tree().change_scene_to_file("res://Scenes/UI/upgradeShop.tscn")

#updates the name of car labels
func _updateCarNameLabels():
	$pOneCarNameLabel.text = carNames[globalVars.pOneCarSelected]
	$pTwoCarNameLabel.text = carNames[globalVars.pTwoCarSelected]
	
#updates the visibility of a label if the car is not owner
func _updateBuyButtonLabels():
	if pOneCars[globalVars.pOneCarSelected] not in pOneOwned:
		$pOneBuyButtonLabel.visible = true
	else:
		$pOneBuyButtonLabel.visible = false
	if pTwoCars[globalVars.pTwoCarSelected] not in pTwoOwned:
		$pTwoBuyButtonLabel.visible = true
	else:
		$pTwoBuyButtonLabel.visible = false

func _on_timer_timeout() -> void:
	_updateColorDisplay(pOneColors[globalVars.pOneColorSelected],pTwoColors[globalVars.pTwoColorSelected])
