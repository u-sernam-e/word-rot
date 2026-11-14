extends Node2D

@export var submit_button : BaseButton
@export var word_controller : WordController
@export var image_controller: ImageController
@export var level_end_screen : LevelEndScreen

@export var level : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	submit_button.pressed.connect(_submit_button_pressed)
	word_controller.level = level

func _process(_delta: float) -> void:
	submit_button.visible = should_show_button()

# only update whether the show button 
#func _input(event: InputEvent) -> void:
#	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		

func should_show_button() -> bool:
	var sentence = word_controller.get_made_sentence()
	var fixed_sentence = LevelSentences.fully_fixed_array(sentence)
	if fixed_sentence.size() >= LevelSentences.min_words[level]:
		return true
	return false

func _submit_button_pressed():
	var sentence = word_controller.get_made_sentence()
	var score = LevelSentences.get_word_array_score(sentence, level)
	level_end_screen.set_score_and_show(score)
	
	print(sentence)
	print(score)
