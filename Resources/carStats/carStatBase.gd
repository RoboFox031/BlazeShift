extends Resource
class_name carStats

#The variables that change based on cars
@export var acceleration:float ##controls acceleration
@export var topSpeed:float ##controls top speed
#controls how quickly you turn
@export var turnSpeed:float##controls how quickly you turn
#controls how sharply you turn
@export var turnPower:float ##controls how sharply you turn
#The base deceleration value
@export var deceleration:float; ##The base deceleration value
#Stores base tracktion
@export var traction:float=100
#Stores base braking power
@export var brakes:float ##brake power
