extends Node2D

@export var submit_button : BaseButton
@export var test_button : BaseButton
@export var word_controller : WordController
@export var image_controller: ImageController
@export var level_end_screen : LevelEndScreen

@export var word_restriction: String = "empty" # If same as default values, then that indicates level doesn't use that variable
@export var word_insertion: String = "empty"
@export var word_insertion_position: int = -1 # Will insert right after this word (4 would mean insert right after word 4). Starts at 1.

@onready var stock_image_controller: ImageController = $"../StockImageTab/StockImageController"
@onready var large_iamge = $"../StockImageTab/StockImageController/LargeIamge"

@export var level : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	submit_button.pressed.connect(_submit_button_pressed)
	test_button.pressed.connect(word_controller.play_sentence)
	word_controller.level = level
	LevelTransition.level_count = level
	Globals.cur_word_restriction = word_restriction
	Globals.cur_word_insertion = word_insertion
	Globals.cur_word_insertion_idx = word_insertion_position

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
	
	if level < 7 || level == 11:
		if sentence_no_nulls.size() >= LevelSentences.min_words[level]:
			if (Globals.cur_word_restriction == "empty" or Globals.cur_word_restriction in sentence) and Globals.cur_word_insertion == "empty":
				return true
			elif not Globals.cur_word_insertion == "empty" and Globals.cur_word_restriction == "empty":
				return true
	elif level >= 7 && level < 11:
		if sentence_no_nulls.size() >= LevelSentences.min_words[level] && Globals.image_on_timeline == true:
			if (Globals.cur_word_restriction == "empty" or Globals.cur_word_restriction in sentence) and Globals.cur_word_insertion == "empty":
				return true
			elif not Globals.cur_word_insertion == "empty" and Globals.cur_word_restriction == "empty":
				return true
	
	return false

func _submit_button_pressed():
	var sentence = word_controller.get_made_sentence()
	var image = stock_image_controller.get_current_image()
	
	Globals.level_start = false
	
	var words: PackedStringArray = []
	if LevelTransition.level_count == 5 or LevelTransition.level_count == 10 or LevelTransition.level_count == 3 or LevelTransition.level_count == 7 or LevelTransition.level_count == 8 or LevelTransition.level_count == 10 or LevelTransition.level_count == 11:
		for word in sentence:
			if word != null:
				words.append(str(word))
		if not Globals.cur_word_insertion == "empty" and not Globals.cur_word_insertion_idx == -1:
			words.insert(Globals.cur_word_insertion_idx, Globals.cur_word_insertion)
		TTS._speak(" ".join(words), TTS.SENTENCE_ID)
		await TTS.finished_playing_tts
	else:
		word_controller.play_sentence()
		await word_controller.finished_playing_sentence
	var score = LevelSentences.get_word_array_score(sentence, level)
	score += LevelSentences.get_stock_image_score(image, level)
	
	large_iamge.visible = false
	level_end_screen.set_score_and_show(score)
	
	print(sentence)
	print(score)
