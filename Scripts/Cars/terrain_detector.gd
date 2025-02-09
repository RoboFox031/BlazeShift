extends Node2D
signal terrainChanged

var parentCar:Car

#enum for the diffrent types of terrain
#Stores what type of terrain each is touching
var currentLTerrain:trackEnums.terrainTypes
var currentRTerrain:trackEnums.terrainTypes

func _ready() -> void:
	#Sets the car's parent
	parentCar=get_parent()

func terrainCheck():
	#If both detectors are on the same terrain, set the car's terrain to that terrain
	if currentRTerrain==currentLTerrain:
		parentCar.currentTerrain=currentRTerrain

func _on_terrain_detector_l_area_entered(area: Area2D) -> void:
	#Sets the currentLTerrain varible to whatever terrain it is touching
	if area.myTerrain==trackEnums.terrainTypes.offroad:
		currentLTerrain=trackEnums.terrainTypes.offroad
	#Checks the car's overall terrain
	terrainCheck()

func _on_terrain_detector_r_area_entered(area: Area2D) -> void:
	#Sets the currentRTerrain varible to whatever terrain it is touching
	if area.myTerrain==trackEnums.terrainTypes.offroad:
		currentRTerrain=trackEnums.terrainTypes.offroad
	#Checks the car's overall terrain
	terrainCheck()

func _on_terrain_detector_l_area_exited(area: Area2D) -> void:
	#If the terrain that it just left was the same as the one it used to be touching
	#set the currentLTerrain varible to track
	if area.myTerrain==currentLTerrain:
		currentLTerrain=trackEnums.terrainTypes.track
	#Checks the car's overall terrain
	terrainCheck()

func _on_terrain_detector_r_area_exited(area: Area2D) -> void:
	#If the terrain that it just left was the same as the one it used to be touching
	#set the currentRTerrain varible to track
	if area.myTerrain==currentRTerrain:
		currentRTerrain=trackEnums.terrainTypes.track
	#Checks the car's overall terrain
	terrainCheck()
