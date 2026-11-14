extends Node2D
class_name LevelEndScreen

# -1, 0, or 1
@export var score_index : int

var backgroundColors = {
	-1 : Color.DARK_RED,
	0 : Color.GOLDENROD,
	1 : Color.FOREST_GREEN
}

var lineColors = {
	-1 : Color.RED,
	0 : Color.GOLD,
	1 : Color.LIME_GREEN
}

@onready var background = $Background
@onready var lines = $BackgroundLines

@onready var bad = $Bad
@onready var okay = $Okay
@onready var good = $Good

@onready var restart_butt = $Restart
@onready var next_butt = $Next

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	restart_butt.pressed.connect(_restart_pressed)
	next_butt.pressed.connect(_next_pressed)

func _restart_pressed():
	get_tree().reload_current_scene()
func _next_pressed():
	LevelTransition.change_scene_to("res://Game/main_menu.gd")

func set_score_and_show(score):
	if score < 0:
		score_index = -1
	elif score < 1:
		score_index = 0
	else:
		score_index = 1
		
	background.color = backgroundColors[score_index]
	lines.modulate = lineColors[score_index]
	if score_index == -1:
		bad.show()
	elif score_index == 0:
		okay.show()
	elif score_index == 1:
		good.show()
	
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
