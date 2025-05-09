extends Node

var track = preload("res://Scenes/Tracks/basicTrack.tscn")
var playerOneCar = preload("res://Scenes/Cars/Mustang.tscn")
var playerTwoCar = preload("res://Scenes/Cars/Mustang.tscn")
var playerOneCarSprite = null
var playerTwoCarSprite = null
var playerOneColor = "blue"
var playerTwoColor = "blue"
var musicType = 'spotifyMusic'
var musicDB = 50
var sfxDB = 50
var nextScene
#Defults to mustang
var currentCarNames={"p1":"Mustang","p2":"Mustang"}
var pOnePowerup = 'none'
var pTwoPowerup = 'none'
var pOneCoins = 0
var pTwoCoins = 0
const NSX = preload("res://Scenes/Cars/NSX.tscn")
var p1BlazeCurrent = 100
var p2BlazeCurrent = 100
var pOneDone = false
var pTwoDone = false
var playMusic
#Stores the progress value and the lap value for each player
var progress={
	"p1":0,
	"p2":0,
}
var laps={
	"p1":0,
	"p2":0,
}
#racing variables
var pOneLastRaceTime = '00:00'
var pOneTotalTime = '00:00'
var pOneLastRacePlacement = null
var pOneOverallPlacement = null
var pOneLastRaceCoinsCollected = 0
var pOneTotalWins = 0

var pTwoLastRaceTime = '00:00'
var pTwoTotalTime = '00:00'
var pTwoLastRacePlacement = null
var pTwoOverallPlacement = null
var pTwoLastRaceCoinsCollected = 0
var pTwoTotalWins = 0

#shop variables
var pOneCarSelected = 0
var pTwoCarSelected = 0
var pOneColorSelected = 0
var pTwoColorSelected = 0

#name variables
var pOneName = 'AAA'
var pTwoName = 'BBB'

var canMove = false
var canPause = false

#global score list for each track
var basicScores := {}
var ruralScores := {}
var iceScores := {}
var volcanoScores := {}
var organizedScores := {}
#name,score,track

#func saveScores(trackName, playerName, time):


func saveScores(trackName,playerName,time):
	var timeScore = ConfigFile.new()
	if trackName == 'basicTrack':
		var error = timeScore.load('res://basicScores.cfg')
		if timeScore.has_section(playerName):
			if timeScore.get_value(playerName,'time') >= time:
				timeScore.set_value(playerName, 'time', time)
			else:
				pass
		else:
			timeScore.set_value(playerName, 'time', time)
		var save_error = timeScore.save('res://basicScores.cfg')
	elif trackName == 'ruralTrack':
		var error = timeScore.load('res://ruralScores.cfg')
		if timeScore.has_section(playerName):
			if timeScore.get_value(playerName,'time') >= time:
				timeScore.set_value(playerName, 'time', time)
			else:
				pass
		else:
			timeScore.set_value(playerName, 'time', time)
		var save_error = timeScore.save('res://ruralScores.cfg')
	elif trackName == 'iceTrack':
		var error = timeScore.load('res://iceScores.cfg')
		if timeScore.has_section(playerName):
			if timeScore.get_value(playerName,'time') >= time:
				timeScore.set_value(playerName, 'time', time)
			else:
				pass
		else:
			timeScore.set_value(playerName, 'time', time)
		var save_error = timeScore.save('res://iceScores.cfg')
	elif trackName == 'volcanoTrack':
		var error = timeScore.load('res://volcanoScores.cfg')
		if timeScore.has_section(playerName):
			if timeScore.get_value(playerName,'time') >= time:
				timeScore.set_value(playerName, 'time', time)
			else:
				pass
		else:
			timeScore.set_value(playerName, 'time', time)
		var save_error = timeScore.save('res://volcanoScores.cfg')
		pass
		
func loadScores(trackName):
	var timeScore = ConfigFile.new()
	if trackName == 'basicTrack':
		print('loadScores')
		var list = timeScore.load("res://basicScores.cfg")
		if list == OK:
			var players = timeScore.get_sections()
			for x in players:
				var score = timeScore.get_value(x,'time')
				basicScores[x] = float(score)
			return sortScores(basicScores)
			
	elif trackName == 'ruralTrack':
		print('loadScores')
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




#sorts scores for the loadScores() function
func sortScores(dict):
	var scoresSorted = dict.keys()
	scoresSorted.sort_custom(func(a,b): return dict[a] < dict[b]) # <- lambda function.
	var sortedScores = {}
	for key in scoresSorted:
		sortedScores[key] = dict[key]
	return sortedScores



func convertSec(sec):
	sec = str(sec)
	
	#checks how many minutes
	var minutes = floor(int(int(sec)/60))
	if minutes == 0:
		minutes = '00'
	elif minutes <= 10:
		minutes = '0'+str(minutes)
		
	#checks how many seconds
	var seconds = fmod(float(sec),60)
	if int(seconds) == 0:
		seconds = '0'+str(seconds)
	elif seconds <= 10:
		seconds = '0'+str(seconds)
		
	#fixes 0's for milliseconds
	var miliseconds = checkDecimals(seconds)
	if miliseconds == 1:
		seconds = str(seconds) + '00'
	elif miliseconds == 2:
		seconds = str(seconds) + '0'
		
		
	return str(minutes)+':'+str(seconds)
	pass

func checkDecimals(number):
	var number_str = str(number)
	if number_str.find('.') != -1:
		var decimal_part = number_str.split('.')[1]
		return decimal_part.length()
	else:
		return 0

func resetRaceVars():
	pOnePowerup = 'none'
	pTwoPowerup = 'none'
	p1BlazeCurrent = 100
	p2BlazeCurrent = 100
	pOneDone = false
	pTwoDone = false
	progress={
		"p1":0,
		"p2":0,
	}
	laps={
		"p1":0,
		"p2":0,
	}
	pOneLastRaceTime = '00:00'
	pOneTotalTime = '00:00'
	pOneLastRacePlacement = null
	pOneOverallPlacement = null
	pOneLastRaceCoinsCollected = 0
	pTwoLastRaceTime = '00:00'
	pTwoTotalTime = '00:00'
	pTwoLastRacePlacement = null
	pTwoOverallPlacement = null
	pTwoLastRaceCoinsCollected = 0
	canMove = false
	canPause = false
	
func gameReset():
	track = preload("res://Scenes/Tracks/basicTrack.tscn")
	playerOneCar = preload("res://Scenes/Cars/Mustang.tscn")
	playerTwoCar = preload("res://Scenes/Cars/Mustang.tscn")
	playerOneCarSprite = null
	playerTwoCarSprite = null
	playerOneColor = "blue"
	playerTwoColor = "blue"
	currentCarNames={"p1":"Mustang","p2":"Mustang"}
	pOnePowerup = 'none'
	pTwoPowerup = 'none'
	pOneCoins = 0
	pTwoCoins = 0
	p1BlazeCurrent = 100
	p2BlazeCurrent = 100
	pOneDone = false
	pTwoDone = false
	progress={
		"p1":0,
		"p2":0,
	}
	laps={
		"p1":0,
		"p2":0,
	}
	pOneLastRaceTime = '00:00'
	pOneTotalTime = '00:00'
	pOneLastRacePlacement = null
	pOneOverallPlacement = null
	pOneLastRaceCoinsCollected = 0
	pOneTotalWins = 0
	pTwoLastRaceTime = '00:00'
	pTwoTotalTime = '00:00'
	pTwoLastRacePlacement = null
	pTwoOverallPlacement = null
	pTwoLastRaceCoinsCollected = 0
	pTwoTotalWins = 0
	pOneCarSelected = 0
	pTwoCarSelected = 0
	pOneColorSelected = 0
	pTwoColorSelected = 0
	pOneName = 'AAA'
	pTwoName = 'BBB'
	canMove = false
	canPause = false
