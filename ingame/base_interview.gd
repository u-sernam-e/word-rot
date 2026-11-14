extends Node2D

@onready var interviewed: AnimatedSprite2D = $Interviewed

var level_data : Dictionary = {
	1 : {
		"chara" : load("res://assets/characters/jen_eric.tres"),
		"audio" : "place recording here",
		},
	
	2 : {
		"chara" : load("res://assets/characters/envi_activist.tres"),
		"audio" : "place recording here",
		},
	
	3 : {
		"chara" : load("res://assets/characters/economist.tres"),
		"audio" : "place recording here",
		},
	
	4 : {
		"chara" : load("res://assets/characters/lawyer.tres"),
		"audio" : "place recording here",
		},
	
	5 : {
		"chara" : load("res://assets/characters/ex_employee.tres"),
		"audio" : "place recording here",
		},
	6 : {
		"chara" : load("res://assets/characters/jen_eric.tres"),
		"audio" : "place recording here",
		},
	
	7 : {
		"chara" : load("res://assets/characters/envi_activist.tres"),
		"audio" : "place recording here",
		},
	
	8 : {
		"chara" : load("res://assets/characters/economist.tres"),
		"audio" : "place recording here",
		},
	
	9 : {
		"chara" : load("res://assets/characters/lawyer.tres"),
		"audio" : "place recording here",
		},
	
	10 : {
		"chara" : load("res://assets/characters/ex_employee.tres"),
		"audio" : "place recording here",
		},
	
	11 : {
		"chara" : load("res://assets/characters/jen_eric.tres"),
		"audio" : "place recording here",
		},
}

func _ready():
	interviewed.sprite_frames = level_data[1]["chara"]

func play_audio():
	pass
