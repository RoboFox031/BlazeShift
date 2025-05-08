extends Node

#Stores how much of each varible is gained per level
#The max increase of each of these is the amount bellow *5
const topSpeedPerLevel=30 #Max 150
const accelPerLevel=3.5 #Max 17.5
const maxBlazePerLevel=25 #Max 125
const handlingPerLevel=7 #Max 35


#List of upgrades
var upgrades=[
	"topSpeed",
	"acceleration",
	"maxBlaze",
	"handling"
]
#List of cars
var cars=[
	"NSX",
	"S13",
	"Mustang",
	"CRX",
	"FC RX7",
	"69 Charger",
	"Lancia 037",
	"Lotus Esprit",
	"RUF CTR",
	"300ZX",
	"Camaro"
]
#The dictionnary that stores all the upgrades
##When acessing a specific upgrade the format is as folows: globalUpgrades.upgradesDict[player][car][upgrade]
var upgradesDict={ 
	"p1":{},
	"p2":{}
	}
#used to determine the cost of an upgrade
var upgradesCost = {
	'topSpeed':{1:2,2:5,3:8,4:10,5:15},
	'maxBlaze':{1:1,2:2,3:4,4:8,5:10},
	'handling':{1:2,2:5,3:8,4:10,5:15},
	'acceleration':{1:1,2:2,3:4,4:8,5:10}
	}




func _ready() -> void:
	#Create an entry in the dictionnary of every posible upgrade in each car, for each player
	for players in upgradesDict:
		for i in cars:
			#creates a spot in each car to store each upgrade
			upgradesDict[players][i]={}
			for j in upgrades:
				#Creates the upgrades for each car and defults them to 0
				upgradesDict[players][i][j]=0
	# print(upgradesDict)
	# var levelTest=getStatLevel("p1","NSX","topSpeed")
	# print("current: "+str(getStatLevel("p1","NSX","topSpeed")))

#Function called by other scripts that upgrades a spefic stat, by a fixed amount
func upgradeStat(player:String,car:String,upgradeName:String):
	#upgrades the chosen stat by one level, without letting it exceed level 5
	upgradesDict[player][car][upgradeName]=clamp(upgradesDict[player][car][upgradeName]+1,0,5)
#Gets the numerical value assoicated with each upgrade based on its level
func statValue(player:String,car:String,upgradeName:String):
	#Returns the level of the chosen upgrade
	var level=upgradesDict[player][car][upgradeName]
	#Uses a match function and will return a diffrent value based on the upgrade and the level
	match upgradeName:
		"topSpeed":
			return level*topSpeedPerLevel
		"acceleration":
			return level*accelPerLevel
		"maxBlaze":
			return level*maxBlazePerLevel
		"handling":
			return level*handlingPerLevel

#Gets the level of a stat
func getStatLevel(player:String,car:String,upgradeName:String):
	#Returns the level of the chosen upgrade
	var level=upgradesDict[player][car][upgradeName]
	#print(upgradeName+" "+str(level))
	return level
	


#Gets the level of a stat
func getUpgradeCost(player:String,upgradeName:String):
	#Returns the level of the chosen upgrade
	var cost=globalUpgrades.upgradesCost[upgradeName][1+globalUpgrades.getStatLevel(player,globalVars.currentCarNames[player],upgradeName)]
	return cost
