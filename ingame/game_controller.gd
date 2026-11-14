extends Node2D

@export var submit_button : BaseButton
@export var word_controller : WordController
@export var image_controller: ImageController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	submit_button.pressed.connect(_submit_button_pressed)

func _submit_button_pressed():
	var sentence = word_controller.get_made_sentence()
	print(sentence)
	print(LevelSentences.get_word_array_score(sentence, 1))
