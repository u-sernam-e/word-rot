extends Node2D
class_name WordController

signal finished_playing_sentence
var currently_playing_sentence = false

var level : int
@export var center : Vector2
const MAX_WIDTH : int = 300

var words : Array[Word] = []
const word_scene = preload("res://ingame/word_controller/word.tscn")

var is_moving_word : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = get_parent().level
	create_words_from_level_sentence()
	for w in words:
		w.button_pressed.connect(_word_button_pressed)
	get_tree().create_timer(0.2).timeout.connect(set_up_word_positions)
	
	var count = 0
	for c in get_children():
		if c is WordDest:
			c.pos = count
			count += 1

# create words from level sentence array
func create_words_from_level_sentence():
	var word_array : Array = LevelSentences.get_level_sentence_array(level)
	var word_count = 1
	for word_string in word_array:
		var word = word_scene.instantiate()
		add_child(word)
		words.push_back(word)
		word.text = word_string
		# first check if punctuation
		if word_string == "." or word_string == "!" or word_string == "?" or word_string == "…" or word_string == ",":
			word.is_punctuation = true
			word.disable_button()
		else:
			if level < 3:
				var bonus_zero = ""
				if word_count < 10:
					bonus_zero = "0"
				var word_audio = load("res://Audio/speech/" + str(level) + "/-" + bonus_zero + str(word_count) + ".wav")
				word.set_word_sound(word_audio)
				word_count += 1

# set up word positions in a centered manner
# within the maximum width
func set_up_word_positions():
	var current_row : int = 0
	var current_row_size : int = 0
	var words_row : Array[int] = [] # each value in this array corresponds to a value in words[] array
	for w in words:
		var word_size = w.get_button_size()
		# if row would become too big, create new row
		# need to move all current rows up
		if current_row_size + word_size.x > MAX_WIDTH:
			current_row += 1
			current_row_size = 0
			for row in range(current_row):
				#print(row)
				move_all_in_row(row, words_row, Vector2(0, -word_size.y*0.5))
			
			#print("row move up")
			#print(current_row)
			#print("--")
		else: # adding to current row
			# add size of word to current row
			current_row_size += word_size.x
			# add the required length to all words in current row
			# I think this is a little broken
			move_all_in_row(current_row, words_row, Vector2(-word_size.x*0.5, 0))
		w.position = Vector2(current_row_size*0.5 - word_size.x*0.5, current_row*word_size.y*0.5)
		words_row.push_back(current_row)
# helper func for set_up_word_positions()
func move_all_in_row(current_row : int, words_row : Array[int], move_amount : Vector2):
	for i in words_row.size():
		var word_row = words_row[i]
		var word = words[i]
		if word_row == current_row:
			word.position += move_amount

func _word_button_pressed(word : Word):
	if word.moving:
		var areas = word.centerArea.get_overlapping_areas()
		var shouldGoToOrigin = true
		for a in areas:
			if a.get_parent() is WordDest and not a.get_parent().has_multiple_overlapping():
				word.moveNode.global_position = a.get_parent().global_position
				shouldGoToOrigin = false
		if shouldGoToOrigin:
			word.moveNode.position = Vector2(0, 0)
		word.toggle_move()
		is_moving_word = false
	else:
		if not is_moving_word:
			if LevelTransition.level_count > 3:
				TTS._speak(word.text)
			word.toggle_move()
			is_moving_word = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# makes an array based on word destinations
# requires every dest to have a word on it, and
# for their pos to be in order and not skip any numbers
func makeIdArray() -> Array:
	var idArray : Array = []
	for c in get_children():
		if c is WordDest:
			var word = c.get_overlapping_word()
			var destPos = c.pos
			if idArray.size() <= destPos:
				idArray.resize(destPos + 1)
			if word:
				idArray[destPos] = word.text
			else: # word is null/nothing on space
				idArray[destPos] = null
	return idArray

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_up"):
		#print(makeIdArray())

func get_made_sentence():
	return makeIdArray()

func play_sentence():
	currently_playing_sentence = true
	for c in get_children():
		if c is WordDest:
			if c.get_overlapping_word():
				c.get_overlapping_word().play_word_sound()
				await c.get_overlapping_word().sound_finished
	currently_playing_sentence = false
	finished_playing_sentence.emit()
