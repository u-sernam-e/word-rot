extends Node2D

@onready var prompt = $CanvasLayer/VBoxContainer/Prompt
@onready var restrictions = $CanvasLayer/VBoxContainer2/Restrictions

func _ready() -> void:
	prompt.text = LevelSentences.prompts[LevelTransition.level_count]
	restrictions.text = LevelSentences.restrictions[LevelTransition.level_count]
func _on_timeline_mouse_entered():
	pass # Replace with function body.
