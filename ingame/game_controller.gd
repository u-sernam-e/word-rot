extends Node2D

@export var submit_button : BaseButton
@export var test_button : BaseButton
@export var word_controller : WordController
@export var image_controller: ImageController
@export var level_end_screen : LevelEndScreen

@export var level : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	submit_button.pressed.connect(_submit_button_pressed)
	test_button.pressed.connect(word_controller.play_sentence)
	word_controller.level = level

func _process(_delta: float) -> void:
	submit_button.disabled = not should_enable_submit_button()
	test_button.disabled = not should_enable_test_button()

# only update whether the show button 
#func _input(event: InputEvent) -> void:
#	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		

func should_enable_test_button() -> bool:
	if word_controller.currently_playing_sentence:
		return false
	return true

func should_enable_submit_button() -> bool:
	var sentence = word_controller.get_made_sentence()
	var sentence_no_nulls = LevelSentences.get_word_array_without_nulls(sentence)
	if word_controller.currently_playing_sentence:
		return false
	if sentence_no_nulls.size() >= LevelSentences.min_words[level]:
		return true
	return false

func _submit_button_pressed():
	var sentence = word_controller.get_made_sentence()
	var words: PackedStringArray = []
	if LevelTransition.level_count > 3:
		for word in sentence:
			if word != null:
				words.append(str(word))
		TTS._speak(" ".join(words))
	var score = LevelSentences.get_word_array_score(sentence, level)
	
	word_controller.play_sentence()
	await word_controller.finished_playing_sentence
	
	level_end_screen.set_score_and_show(score)
	
	print(sentence)
	print(score)
