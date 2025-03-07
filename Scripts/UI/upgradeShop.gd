extends UI
class_name upgradeShop

var pOneReady = false
var pTwoReady = false

var pOneBack = false
var pTwoBack = false

var pOneUpgradeSelected: int = 0
var pTwoUpgradeSelected: int = 0

var pOneUpgrades
var pTwoUpgrades

var pOneUpgradeSprites: Array = []
var pTwoUpgradeSprites: Array = []

var pOneUpgradeLevels: Array = [1,2,1,1]
var pTwoUpgradeLevels: Array = [3,1,4,1]

var pOneUpgradeCost: Array = [1,2,5,10] ###change this later
var pTwoUpgradeCost: Array = [4,8,7,9] ###change this later

@onready var pOneCostLabel = $pOneLabels/costLabel
@onready var pTwoCostLabel = $pTwoLabels/costLabel

func _ready() -> void:
	pOneUpgrades = [$pOneLabels/topSpeedLabel,$pOneLabels/maxBlazeLabel,$pOneLabels/blazeRefillLabel,$pOneLabels/accelerationLabel]
	pTwoUpgrades = [$pTwoLabels/topSpeedLabel,$pTwoLabels/maxBlazeLabel,$pTwoLabels/blazeRefillLabel,$pTwoLabels/accelerationLabel]
	for sprite in $pOneUpgradeBoxes.get_children():
		pOneUpgradeSprites.append(sprite)
	for sprite in $pTwoUpgradeBoxes.get_children():
		pTwoUpgradeSprites.append(sprite)
	_updateSelected()
	_instantiatePlayerCars()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed('p1_start'):
		if pOneReady == false and pOneBack == false:
			pOneReady = true
		else:
			pOneReady = false
		_updateReadyScreen()
	if Input.is_action_just_pressed("p2_start"):
		if pTwoReady == false and pTwoBack == false:
			pTwoReady = true
		else:
			pTwoReady = false
		_updateReadyScreen()
		
	if Input.is_action_just_pressed("p1_b"):
		if pOneBack == false and pOneReady == false:
			pOneBack = true
		else:
			pOneBack = false
		_updateReadyScreen()
	if Input.is_action_just_pressed("p2_b"):
		if pTwoBack == false and pTwoReady == false:
			pTwoBack = true
		else:
			pTwoBack = false
		_updateReadyScreen()
		
	if Input.is_action_just_pressed('p1_down') and pOneReady == false:
		if pOneUpgradeSelected + 1 < len(pOneUpgrades):
			pOneUpgradeSelected += 1
		else: 
			pOneUpgradeSelected = 0
		_updateSelected()
	if Input.is_action_just_pressed("p1_up") and pOneReady == false:
		if pOneUpgradeSelected - 1 >= 0:
			pOneUpgradeSelected -= 1
		else: 
			pOneUpgradeSelected = 3
		_updateSelected()
	if Input.is_action_just_pressed('p2_down') and pTwoReady == false:
		if pTwoUpgradeSelected + 1 < len(pTwoUpgrades):
			pTwoUpgradeSelected += 1
		else: 
			pTwoUpgradeSelected = 0
		_updateSelected()
	if Input.is_action_just_pressed("p2_up") and pTwoReady == false:
		if pTwoUpgradeSelected - 1 >= 0:
			pTwoUpgradeSelected -= 1
		else: 
			pTwoUpgradeSelected = 3
		_updateSelected()
		
func _updateSelected():
	for label in pOneUpgrades:
		if label == pOneUpgrades[pOneUpgradeSelected]:
			label.add_theme_color_override("font_outline_color", Color(0,0,0)) 
			label.add_theme_constant_override("outline_size", 15)
		else:
			label.add_theme_constant_override("outline_size", 0)
	for label in pTwoUpgrades:
		if label == pTwoUpgrades[pTwoUpgradeSelected]:
			label.add_theme_color_override("font_outline_color", Color(0,0,0)) 
			label.add_theme_constant_override("outline_size", 15)
		else:
			label.add_theme_constant_override("outline_size", 0)
	_updateCostLabel()
	_updateUpgradeSprites()

func _updateCostLabel():
	pOneCostLabel.text = "cost to upgrade: " + str(_findCost(pOneUpgradeCost, pOneUpgradeSelected)) + " " + str(_ifCoinsPlural(_findCost(pOneUpgradeCost, pOneUpgradeSelected)))
	pTwoCostLabel.text = "cost to upgrade: " + str(_findCost(pTwoUpgradeCost, pTwoUpgradeSelected)) + " " + str(_ifCoinsPlural(_findCost(pTwoUpgradeCost, pTwoUpgradeSelected)))

func _findCost(playerCost: Array, playerSelection: int):
	return playerCost[playerSelection]
	
func _ifCoinsPlural(cost):
	if cost == 1:
		return "coin"
	else:
		return "coins"

func _updateUpgradeSprites():
	var x = 0
	var y = 0
	for sprite in pOneUpgradeSprites:
		sprite.play(str(pOneUpgradeLevels[x]))
		x += 1
	for sprite in pTwoUpgradeSprites:
		sprite.play(str(pTwoUpgradeLevels[y]))
		y += 1

func _instantiatePlayerCars():
	var playerCarSpriteOne = Sprite2D.new()
	playerCarSpriteOne.texture = load("res://Assets/Sprites/Cars/" + str(globalVars.playerOneCarSprite) + ".png")
	playerCarSpriteOne.position.x = 475
	playerCarSpriteOne.position.y = 940
	playerCarSpriteOne.scale.x = 2.5
	playerCarSpriteOne.scale.y = 2.5
	add_child(playerCarSpriteOne)
	var playerCarSpriteTwo = Sprite2D.new()
	playerCarSpriteTwo.texture = load("res://Assets/Sprites/Cars/" + str(globalVars.playerTwoCarSprite) + ".png")
	playerCarSpriteTwo.position.x = 475 + 966
	playerCarSpriteTwo.position.y = 940
	playerCarSpriteTwo.scale.x = 2.5
	playerCarSpriteTwo.scale.y = 2.5
	add_child(playerCarSpriteTwo)
	
func _updateReadyScreen():
	if pOneReady == true:
		$pOneReadyScreen.visible = true
	else:
		$pOneReadyScreen.visible = false
	if pTwoReady == true:
		$pTwoReadyScreen.visible = true
	else:
		$pTwoReadyScreen.visible = false
	if pOneReady == true and pTwoReady == true:
		get_tree().change_scene_to_file("res://Scenes/UI/trackSelection.tscn")
	if pOneBack == true:
		$pOneBackScreen.visible = true
	else:
		$pOneBackScreen.visible = false
	if pTwoBack == true:
		$pTwoBackScreen.visible = true
	else:
		$pTwoBackScreen.visible = false
	if pOneBack == true and pTwoBack == true:
		get_tree().change_scene_to_file("res://Scenes/UI/shop.tscn")
		
