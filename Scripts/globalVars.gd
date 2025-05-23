extends Node

var track = preload("res://Scenes/Tracks/basicTrack.tscn")
var playerOneCar = preload("res://Scenes/Cars/Mustang.tscn")
var playerTwoCar = preload("res://Scenes/Cars/Mustang.tscn")
var playerOneCarSprite = null
var playerTwoCarSprite = null
var playerOneColor = "blue"
var playerTwoColor = "blue"
var musicType = 'royaltyMusic'
var musicDB = 50
var sfxDB = 50
var nextScene
var tracksCompleted = []
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
var playMusic = false
var inCyclone = false
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
var pOneLastRaceTime = 200.0402
var pOneTotalTime = '00:00'
var pOneLastRacePlacement = null
var pOneOverallPlacement = null
var pOneLastRaceCoinsCollected = 0
var pOneTotalCoinsCollected = 0
var pOneTotalWins = 0

var pTwoLastRaceTime = 200.0402
var pTwoTotalTime = '00:00'
var pTwoLastRacePlacement = null
var pTwoOverallPlacement = null
var pTwoLastRaceCoinsCollected = 0
var pTwoTotalCoinsCollected = 0
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
var winner
var canEdit

var pOneOwned: Array
var pTwoOwned: Array

#global score list for each track
var basicScores := {}
var ruralScores := {}
var iceScores := {}
var volcanoScores := {}
var organizedScores := {}
#name,score,track

#func saveScores(trackName, playerName, time):
func _ready():
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index('sfx'),globalVars.sfxDB)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index('music'),globalVars.musicDB)

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
	seconds = miliseconds
	#seconds = miliseconds
	#if miliseconds == 1:
		#seconds = str(seconds) + '00'
	#elif miliseconds == 2:
		#seconds = str(seconds) + '0'
	
		
		
	return str(minutes)+':'+str(seconds)
	pass

func checkDecimals(number):
	number = str(number)
	var decimal = number[0] +number[1] + number[2] + number[3]+number[4]+number[5]
	print(decimal)
	return decimal
	#var number_str = str(number)
	#print(number_str)
	#if number_str.find('.') != -1:
		#print(number_str.find('.'))
		#var decimal_part = number_str.split('.')[1]
		#print(decimal_part)
		#return decimal_part.length()
	#else:
		#return 0

func resetRaceVars():
	#Defults to mustang
	currentCarNames={"p1":"Mustang","p2":"Mustang"}
	pOnePowerup = 'none'
	pTwoPowerup = 'none'
	p1BlazeCurrent = 100
	p2BlazeCurrent = 100
	pOneDone = false
	pTwoDone = false
	playMusic = false
	inCyclone = false
	#Stores the progress value and the lap value for each player
	progress={
		"p1":0,
		"p2":0,
	}
	laps={
		"p1":0,
		"p2":0,
	}

	canMove = false
	canPause = false
	winner = null
	canEdit
	
	pOneLastRacePlacement = null
	pTwoLastRacePlacement=null
	
func gameReset():
	musicType = 'royaltyMusic'
	tracksCompleted = []
	#Defults to mustang
	currentCarNames={"p1":"Mustang","p2":"Mustang"}
	pOnePowerup = 'none'
	pTwoPowerup = 'none'
	pOneCoins = 0
	pTwoCoins = 0
	p1BlazeCurrent = 100
	p2BlazeCurrent = 100
	pOneDone = false
	pTwoDone = false
	playMusic = false
	inCyclone = false
	#Stores the progress value and the lap value for each player
	progress={
		"p1":0,
		"p2":0,
	}
	laps={
		"p1":0,
		"p2":0,
	}
	#racing variables
	pOneLastRaceTime = '00:00'
	pOneTotalTime = '00:00'
	pOneLastRacePlacement = null
	pOneOverallPlacement = null
	pOneLastRaceCoinsCollected = 0
	pOneTotalCoinsCollected = 0
	pOneTotalWins = 0

	pTwoLastRaceTime = '00:00'
	pTwoTotalTime = '00:00'
	pTwoLastRacePlacement = null
	pTwoOverallPlacement = null
	pTwoLastRaceCoinsCollected = 0
	pTwoTotalCoinsCollected = 0
	pTwoTotalWins = 0

	#shop variables
	pOneCarSelected = 0
	pTwoCarSelected = 0
	pOneColorSelected = 0
	pTwoColorSelected = 0

	#name variables
	pOneName = 'AAA'
	pTwoName = 'BBB'

	canMove = false
	canPause = false
	winner=''
	canEdit
	pOneOwned = []
	pTwoOwned = []
