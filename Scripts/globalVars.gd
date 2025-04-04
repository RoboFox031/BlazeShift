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


var timeScore = ConfigFile.new()

#global score list for each track
var basicScores := {}
var ruralScores := {}
var iceScores := {}
var volcanoScores := {}
var organizedScores := {}
#name,score,track
func saveScores(trackName,playerName,time):
	if trackName == 'basicTrack':
		timeScore.set_value(playerName,'time',time)
		timeScore.save('res://basicScores.cfg')
	elif trackName == 'ruralTrack':
		timeScore.set_value(playerName,'time',time)
		timeScore.save('res://ruralScores.cfg')
	elif trackName == 'iceTrack':
		timeScore.set_value(playerName,'time',time)
		timeScore.save('res://iceScores.cfg')
	elif trackName == 'volcanoTrack':
		timeScore.set_value(playerName,'time',time)
		timeScore.save('res://volcanoScores.cfg')
		pass
		
func loadScores(trackName):
	if trackName == 'basicTrack':
		var list = timeScore.load("res://basicScores.cfg")
		if list == OK:
			var players = timeScore.get_sections() 
			for x in players:
				var score = timeScore.get_value(x,'time')
				basicScores[x] = float(score)
			return sortScores(basicScores)
			
	elif trackName == 'ruralTrack':
		var list = timeScore.load("res://ruralScores.cfg")
		if list == OK:
			var players = timeScore.get_sections() 
			for x in players:
				var score = timeScore.get_value(x,'time')
				ruralScores[x] = float(score)
			return sortScores(ruralScores)
			
	elif trackName == 'iceTrack':
		var list = timeScore.load("res://iceScores.cfg")
		if list == OK:
			var players = timeScore.get_sections() 
			for x in players:
				var score = timeScore.get_value(x,'time')
				iceScores[x] = float(score)
			return sortScores(iceScores)
			
	elif trackName == 'volcanoTrack':
		var list = timeScore.load("res://volcanoScores.cfg")
		if list == OK:
			var players = timeScore.get_sections() 
			for x in players:
				var score = timeScore.get_value(x,'time')
				volcanoScores[x] = float(score)
			return sortScores(volcanoScores)
			
	elif trackName == 'testingTrack':
		var list = timeScore.load("res://basicScores.cfg")
		if list == OK:
			var players = timeScore.get_sections() 
			for x in players:
				var score = timeScore.get_value(x,'time')
				basicScores[x] = float(score)
			return sortScores(basicScores)
			
	elif trackName == 'overall':
		var list = timeScore.load("res://basicScores.cfg")
		if list == OK:
			var players = timeScore.get_sections() 
			for x in players:
				var score = timeScore.get_value(x,'time')
				basicScores[x] = float(score)
			return sortScores(basicScores)
					


func _process(delta: float) -> void:
	if Input.is_action_just_pressed('300'):
		var list = timeScore.load("res://basicScores.cfg")
		if list == OK:
			var players = timeScore.get_sections() 
			for x in players:
				var score = timeScore.get_value(x,'time')
				loadScores('basicTrack')
				
#sorts scores for the loadScores() function
func sortScores(dict):
	var scoresSorted = dict.keys()
	scoresSorted.sort_custom(func(a,b): return dict[a] < dict[b]) # <- lambda function.
	print(scoresSorted)
	var sortedScores = {}
	for key in scoresSorted:
		sortedScores[key] = dict[key]
	print(sortedScores)
	return sortedScores

func convertSec(sec):
	sec = str(sec)
	var minutes = floor(int(int(sec)/60))
	if minutes == 0:
		minutes = '00'
	elif minutes <= 10:
		minutes = '0'+str(minutes)
	var seconds = fmod(float(sec),60)
	if int(seconds) == 0:
		seconds = '0'+str(seconds)
	return str(minutes)+':'+str(seconds)
	pass
