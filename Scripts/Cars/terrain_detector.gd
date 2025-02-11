extends Node2D

var parentCar:Car

#enum for the diffrent types of terrain
#Stores what type of terrain each is touching
var currentLTerrain:trackEnums.terrainTypes
var currentRTerrain:trackEnums.terrainTypes

func _ready() -> void:
	#Sets the car's parent
	parentCar=get_parent()

func matchCheck():
	#If both detectors are on the same terrain, set the car's terrain to that terrain
	if currentRTerrain==currentLTerrain:
		parentCar.updateTerrain(currentRTerrain)

func terrainCheck(area,newTerrain):
	#Sets the new terrain variable to whatever the terrain of the area is
	newTerrain=area.myTerrain
	#Return the newTerrain type
	return newTerrain
	

func _on_terrain_detector_l_area_entered(area: Area2D) -> void:
	#Makes sure it's touching a new terrain type
	if area.myTerrain!=currentLTerrain:
		#If it is, set the currentRTerrain varible to the return of the fuction
		currentLTerrain=terrainCheck(area,currentLTerrain)
	#Checks the car's overall terrain
	matchCheck()

func _on_terrain_detector_r_area_entered(area: Area2D) -> void:
	#Makes sure it's touching a new terrain type
	if area.myTerrain!=currentRTerrain:
		#If it is, set the currentRTerrain varible to the return of the fuction
		currentRTerrain=terrainCheck(area,currentRTerrain)
	#Checks the car's overall terrain
	matchCheck()

func _on_terrain_detector_l_area_exited(area: Area2D) -> void:
	#If the terrain that it just left was the same as the one it used to be touching
	#set the currentLTerrain varible to track
	if area.myTerrain==currentLTerrain:
		currentLTerrain=trackEnums.terrainTypes.track
	#Checks the car's overall terrain
	matchCheck()

func _on_terrain_detector_r_area_exited(area: Area2D) -> void:
	#If the terrain that it just left was the same as the one it used to be touching
	#set the currentRTerrain varible to track
	if area.myTerrain==currentRTerrain:
		currentRTerrain=trackEnums.terrainTypes.track
	#Checks the car's overall terrain
	matchCheck()
