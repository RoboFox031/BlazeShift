extends Node

var track = preload("res://Scenes/Tracks/basicTrack.tscn")
var playerOneCar = preload("res://Scenes/Cars/lemkeCar.tscn")
var playerTwoCar = preload("res://Scenes/Cars/lemkeCar.tscn")
var playerOneCarSprite = null
var playerTwoCarSprite = null
var playerOneColor = "blue"
var playerTwoColor = "blue"
#Defults to mustang
var carNames={"p1":"Mustang","p2":"Mustang"}
var pOnePowerup = 'none'
var pTwoPowerup = 'none'
var pOneCoins = 2
var pTwoCoins = 3
const NSX = preload("res://Scenes/Cars/NSX.tscn")
var p1BlazeCurrent = 100
var p2BlazeCurrent = 100
