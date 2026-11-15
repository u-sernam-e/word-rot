extends Node2D

@onready var interviewed: AnimatedSprite2D = $Interviewed
@onready var speech : RichTextLabel = $TextContainer/Speech
@onready var continue_butt : Button = $Continue
@onready var speech_player : AudioStreamPlayer = $SpeechPlayer

var level_data : Dictionary = {
	0 : {
		"chara" : load("res://assets/characters/jen_eric.tres"),
		"audio" : "place recording here",
	},
	
	1 : {
		"chara" : load("res://assets/characters/jen_eric.tres"),
		"audio" : load("res://Audio/speech/1/full.wav"),
		},
	
	2 : {
		"chara" : load("res://assets/characters/envi_activist.tres"),
		"audio" : load("res://Audio/speech/2/full.wav"),
		},
	
	3 : {
		"chara" : load("res://assets/characters/economist.tres"),
		"audio" : load("res://Audio/speech/3/full.wav"), # TESTING
		},
	
	4 : {
		"chara" : load("res://assets/characters/lawyer.tres"),
		"audio" : load("res://Audio/speech/4/full.wav"),
		},
	
	5 : {
		"chara" : load("res://assets/characters/ex_employee.tres"),
		"audio" : load("res://Audio/speech/5/full.wav"),
		},
	6 : {
		"chara" : load("res://assets/characters/jen_eric.tres"),
		"audio" : load("res://Audio/speech/6/full.wav"),
		},
	
	7 : {
		"chara" : load("res://assets/characters/envi_activist.tres"),
		"audio" : load("res://Audio/speech/1/full.wav"), # TESTING
		},
	
	8 : {
		"chara" : load("res://assets/characters/economist.tres"),
		"audio" : load("res://Audio/speech/8/full.wav"), # TESTING
		},
	
	9 : {
		"chara" : load("res://assets/characters/lawyer.tres"),
		"audio" : load("res://Audio/speech/9/full.wav"),
		},
	
	10 : {
		"chara" : load("res://assets/characters/ex_employee.tres"),
		"audio" : load("res://Audio/speech/10/full.wav"),
		},
	
	11 : {
		"chara" : load("res://assets/characters/jen_eric.tres"),
		"audio" : load("res://Audio/speech/1/full.wav"), # TESTING
		},
}

func _ready():
	interviewed.sprite_frames = level_data[LevelTransition.level_count]["chara"]
	
	if !level_data[LevelTransition.level_count]["audio"] is String:
		speech_player.stream = level_data[LevelTransition.level_count]["audio"]
		if LevelTransition.level_count == 5 or LevelTransition.level_count == 10:
			speech_player.bus = "Master"
		else:
			speech_player.bus = "Speech"
	
	continue_butt.disabled = true
	
	play_interview()

func play_interview():
	interviewed.play("Talking")
	speech_player.play()
	
	print(LevelTransition.level_count)
	var textString = LevelSentences.get_level_sentence_string(LevelTransition.level_count)
	var stream : AudioStream = speech_player.stream
	var time = stream.get_length()
	create_tween().tween_property(speech, "text", textString, time).finished.connect(finished_text)

func finished_text():
	continue_butt.disabled = false


func _on_continue_pressed():
	hide()
	Globals.level_start = true
