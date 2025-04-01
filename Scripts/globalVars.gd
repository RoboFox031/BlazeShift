extends Node

var track = preload("res://Scenes/Tracks/basicTrack.tscn")
var playerOneCar = preload("res://Scenes/Cars/lemkeCar.tscn")
var playerTwoCar = preload("res://Scenes/Cars/lemkeCar.tscn")
var playerOneCarSprite = null
var playerTwoCarSprite = null
var playerOneColor = "blue"
var playerTwoColor = "blue"
var pOnePowerup = 'none'
var pTwoPowerup = 'none'
var pOneCoins = 2
var pTwoCoins = 3
const NSX = preload("res://Scenes/Cars/NSX.tscn")
var p1BlazeCurrent = 100
var p2BlazeCurrent = 100

#racing variables
var pOneLastRaceTime = '00:00'
var pOneTotalTime = '00:00'
var pOneLastRacePlacement = '1st'
var pOneOverallPlacement = '1st'
var pOneLastRaceCoinsCollected = 0

var pTwoLastRaceTime = '00:00'
var pTwoTotalTime = '00:00'
var pTwoLastRacePlacement = '1st'
var pTwoOverallPlacement = '1st'
var pTwoLastRaceCoinsCollected = 0

#shop variables
var pOneCarSelected = 1
var pTwoCarSelected = 2
var pOneColorSelected = 6
var pTwoColorSelected = 4

var canMove
