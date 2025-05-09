extends UI
class_name upgradeShop

#state variables for ready screen
var pOneReady = false
var pTwoReady = false
#state variables for back screen
var pOneBack = false
var pTwoBack = false
#currently selected state to upgrade 0 -top speed, 1 - max blaze, 2 - handling, 3 - acceleration
var pOneUpgradeSelected: int = 0
var pTwoUpgradeSelected: int = 0
#array for the label nodes
var pOneUpgrades
var pTwoUpgrades
#array for the sprite nodes
var pOneUpgradeSprites: Array = []
var pTwoUpgradeSprites: Array = []
#names of upgrades in order *used with selection variables
var upgradeNames: Array = ['topSpeed','maxBlaze','handling','acceleration']
#refrencing cost labels
@onready var pOneCostLabel = $pOneLabels/costLabel
@onready var pTwoCostLabel = $pTwoLabels/costLabel

func _ready() -> void:
	#adding nodes to arrays to be used in for loops
	pOneUpgrades = [$pOneLabels/topSpeedLabel,$pOneLabels/maxBlazeLabel,$pOneLabels/handlingLabel,$pOneLabels/accelerationLabel]
	pTwoUpgrades = [$pTwoLabels/topSpeedLabel,$pTwoLabels/maxBlazeLabel,$pTwoLabels/handlingLabel,$pTwoLabels/accelerationLabel]
	for sprite in $pOneUpgradeBoxes.get_children():
		pOneUpgradeSprites.append(sprite)
	for sprite in $pTwoUpgradeBoxes.get_children():
		pTwoUpgradeSprites.append(sprite)
	#updating screens at the start
	_updateSelected()
	#_instantiatePlayerCars()
	##update car names at the start
	$pOneCarLabel.text = 'currently upgrading: ' + globalVars.currentCarNames['p1']
	$pTwoCarLabel.text = 'currently upgrading: ' + globalVars.currentCarNames['p2']
	
func _process(delta: float) -> void:
	#ready screen inputs
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
	#back screen inputs
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
	#selecting upgrade inputs
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
	#buying upgrade inputs
	if Input.is_action_just_pressed('p1_a') and (pOneReady == false or pOneBack == false):
		_checkCanBuy('p1')
	if Input.is_action_just_pressed('p2_a') and (pTwoReady == false or pTwoBack == false):
		_checkCanBuy('p2')
#update based on which upgrade is selected
func _updateSelected():
	$uiSFX.playCursorMoveSound()
	for label in pOneUpgrades:
		if label == pOneUpgrades[pOneUpgradeSelected]:
			label.add_theme_color_override("font_outline_color", Color(0,0,0)) 
			label.add_theme_constant_override("outline_size", 25)
		else:
			label.add_theme_constant_override("outline_size", 0)
	for label in pTwoUpgrades:
		if label == pTwoUpgrades[pTwoUpgradeSelected]:
			label.add_theme_color_override("font_outline_color", Color(0,0,0)) 
			label.add_theme_constant_override("outline_size", 25)
		else:
			label.add_theme_constant_override("outline_size", 0)
	_updateCostLabel()
	_updateUpgradeSprites()
#updates cost label
func _updateCostLabel():
	pOneCostLabel.text = "cost to upgrade: " + str(_findCost('p1', upgradeNames[pOneUpgradeSelected])) + " " + str(_ifCoinsPlural(_findCost('p1', upgradeNames[pOneUpgradeSelected])))
	pTwoCostLabel.text = "cost to upgrade: " + str(_findCost('p2', upgradeNames[pTwoUpgradeSelected])) + " " + str(_ifCoinsPlural(_findCost('p2', upgradeNames[pTwoUpgradeSelected])))
#finds the cost of an upgrade using the global upgrades dict. use p1 and p2 then the name of the upgrade
func _findCost(player,upgrade):
	return globalUpgrades.upgradesCost[player][upgrade]
#used for if the coin number is singular or plural
func _ifCoinsPlural(cost):
	if cost == 1:
		return "coin"
	else:
		return "coins"
#updates the level of the stat for the sprite
func _updateUpgradeSprites():
	var x = 0
	var y = 0
	for sprite in pOneUpgradeSprites:
		sprite.play(str(globalUpgrades.getStatLevel('p1',globalVars.currentCarNames['p1'],upgradeNames[x])))
		x += 1
	for sprite in pTwoUpgradeSprites:
		sprite.play(str(globalUpgrades.getStatLevel('p2',globalVars.currentCarNames['p2'],upgradeNames[y])))
		y += 1
#loads the player car to be displayed at the bottom
'''func _instantiatePlayerCars():
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
	add_child(playerCarSpriteTwo)'''
	
#updates the ready screen
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
		globalVars.nextScene = "res://Scenes/UI/trackSelection.tscn"
		get_tree().change_scene_to_file("res://Scenes/UI/loadingScreen.tscn")
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
		
#refrences the global upgrades script to upgrade the players car stat based on player, car, stat if the player has enough coins
func _checkCanBuy(player):
	if player == 'p1':
		if globalVars.pOneCoins - globalUpgrades.upgradesCost['p1'][upgradeNames[pOneUpgradeSelected]] >= 0:
			globalUpgrades.upgradeStat('p1',globalVars.currentCarNames['p1'],upgradeNames[pOneUpgradeSelected])
			globalVars.pOneCoins -= globalUpgrades.upgradesCost['p1'][upgradeNames[pOneUpgradeSelected]]
			$pOneCoinHud.update()
			_changeUpgradeCost('p1',globalUpgrades.upgradesCost['p1'][upgradeNames[pOneUpgradeSelected]])
			_updateCostLabel()
			_updateSelected()
			_updateUpgradeSprites()
	elif player == 'p2':
		if globalVars.pTwoCoins - globalUpgrades.upgradesCost['p2'][upgradeNames[pTwoUpgradeSelected]] >= 0:
			globalUpgrades.upgradeStat('p2',globalVars.currentCarNames['p2'],upgradeNames[pTwoUpgradeSelected])
			globalVars.pTwoCoins -= globalUpgrades.upgradesCost['p2'][upgradeNames[pTwoUpgradeSelected]]
			$pTwoCoinHud.update()
			_changeUpgradeCost('p2',globalUpgrades.upgradesCost['p2'][upgradeNames[pTwoUpgradeSelected]])
			_updateCostLabel()
			_updateSelected()
			_updateUpgradeSprites()
#updates the cost array when an upgrade gets upgraded
func _changeUpgradeCost(player,cost):
	$uiSFX.playBuySound()
	#changes the cost based on a set system 1-2-4-6-8
	if cost == 1:
		cost = 2
	elif cost == 2:
		cost = 4
	elif cost == 4:
		cost = 6
	elif cost == 6:
		cost = 8
	#updates array depending on player parameter
	if player == 'p1':
		globalUpgrades.upgradesCost['p1'][upgradeNames[pOneUpgradeSelected]] = cost
	else:
		globalUpgrades.upgradesCost['p2'][upgradeNames[pTwoUpgradeSelected]] = cost
	
