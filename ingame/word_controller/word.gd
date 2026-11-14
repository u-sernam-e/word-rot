extends Node2D
class_name Word

signal button_pressed(Word)

@export var text : String
#@export var id : int
@export var is_punctuation : bool = false

#enum Mood{
#	POSITIVE, NEUTRAL, NEGATIVE
#}
#@export var mood : Mood

var moving : bool

@onready var moveNode = $Move
@onready var button = $Move/Button
@onready var centerArea = $Move/CenterArea

func _ready() -> void:
	button.pressed.connect(_button_pressed)
	get_tree().create_timer(0).timeout.connect(_delayed_setup)

func _delayed_setup():
	button.text = text
	get_tree().create_timer(0).timeout.connect(_double_delayed_setup)

func _double_delayed_setup():
	button.position = -button.size/2

# if moving set position to mouse position
func _process(_delta: float) -> void:
	if moving:
		moveNode.global_position = get_global_mouse_position()

func _button_pressed():
	button_pressed.emit(self)

# if not moving, start moving
# if moving, check if in destination, set pos to destination or back to 0, 0
func toggle_move():
	moving = not moving

func get_button_size():
	return button.size

func disable_button():
	button.disabled = true
