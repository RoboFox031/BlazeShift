extends Node
#List of upgrades
var upgrades=[
	"topSpeed",
	"acceleration",
	"maxBlaze",
	"blazeRefil"
]
#List of cars
var cars=[
	"NSX",
	"S13",
	"Mustang"
]
#The dictionnary that stores all the upgrades
##When acessing a specific upgrade the format is as folows: globalUpgrades.upgradesDict[player][car][upgrade]
var upgradesDict={ 
	"p1":{},
	"p2":{}
	}

#Stores how much of each varible is gained per level
#The max increase of each of these is the amount bellow *5
const topSpeedPerLevel=160 #Max 800
const accelPerLevel=14 #Max 70
const maxBlazePerLevel=10 #Max 100
const blazeRefilPerLevel=5 #Max 50



func _ready() -> void:
	#Create an entry in the dictionnary of every posible upgrade in each car, for each player
	for players in upgradesDict:
		for i in cars:
			#creates a spot in each car to store each upgrade
			upgradesDict[players][i]={}
			for j in upgrades:
				#Creates the upgrades for each car and defults them to 0
				upgradesDict[players][i][j]=0
	#print(upgradesDict)

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
		"blazeRefil":
			return level*blazeRefilPerLevel
