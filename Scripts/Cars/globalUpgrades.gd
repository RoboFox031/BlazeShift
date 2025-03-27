extends Node
enum upgradeType{topSpeed,maxBlaze,blazeRefil,Acceleration}
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

func _ready() -> void:
	#Create an entry in the dictionnary of every posible upgrade in each car, for each player
	for players in upgradesDict:
		for i in cars:
			#creates a spot in each car to store each upgrade
			upgradesDict[players][i]={}
			for j in upgradeType:
				#Creates the upgrades for each car and defults them to 0
				upgradesDict[players][i][j]=0
	#print(upgradesDict)
	#When Acessing
