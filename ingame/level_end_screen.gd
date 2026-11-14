extends Node2D

# -1, 0, or 1
@export var score : int

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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.color = backgroundColors[score]
	lines.modulate = lineColors[score]
	if score == -1:
		bad.show()
	elif score == 0:
		okay.show()
	elif score == 1:
		good.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
