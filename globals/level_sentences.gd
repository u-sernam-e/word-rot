extends Node

var level_sentences : Array = [
	"I don’t want a stupid data center in my backyard .",
	
	"It breaks my heart how the company has begun to \
neglect their duties and is destroying all of the \
habitats of the friendly animals I have grown to \
love and care for in my day to day . Stop ruining \
the environment !",
	
	"Please , no more ads ! I really wish the company \
didn’t jack up the prices of all of their services \
while they are also adding annoying unavoidable ads \
to everything unless you pay for their subscription . \
It is hard to justify and maintain the purchase when \
I do not know if it will raise in price another one \
dollar again next month . I wonder if I should cancel \
my subscription …"
]

var correct_sentences = [[
	"I want a data center in my backyard",
	"I want backyard data center",
	"I want data center",
	"I want",
	"I"
	],
	[
	"I love how the company is friendly to the environment",
	"My heart has grown for company friendly to environment"
	]

	]



var filler_words : Array = [
	"a", "the", "how", "it", "has", "begun", "to", "in"
]

var word_dicts : Array = [
	{
		"don't" : -5,
		"want" : 2,
		"stupid" : -5,
		"data" : 1,
		"center" : 1
	},
	{
		"breaks" : -1,
		"heart" : 1,
		"company" : 2,
		"neglect" : -2,
		"duties" : 2,
		"destroying" : -2,
		"habitats" : 1,
		"friendly" : 2,
		"animals" : 2,
		"love" : 2,
		"care" : 1,
		"environment" : 2,
		"stop" : -1
	}
]

func get_word_array_score(word_array : Array, level : int) -> float:
	if is_word_array_perfect_answer(word_array, level):
		return 2
	var fixed_array = fully_fixed_array(word_array)
	var level_dict : Dictionary = word_dicts[level-1]
	var score_total = 0.0
	for word in fixed_array:
		if level_dict.has(word):
			score_total += level_dict[word]
	var score_average = score_total/fixed_array.size()
	return score_average

func is_word_array_perfect_answer(word_array : Array, level : int) -> bool:
	var fixed_array = fully_fixed_array(word_array)
	var check_sentences = correct_sentences[level-1]
	var check_arrays = []
	
	for s in check_sentences:
		check_arrays.push_back(fully_fixed_array(string_to_array(s)))
	
	for check in check_arrays:
		if arrays_have_same_content(fixed_array, check):
			return true
	return false

# thank you godot forums
func arrays_have_same_content(array1, array2):
	if array1.size() != array2.size(): return false
	for item in array1:
		if !array2.has(item): return false
		if array1.count(item) != array2.count(item): return false
	return true

func fully_fixed_array(word_array : Array) -> Array:
	return get_word_array_remove_filler(get_word_array_lowercase(get_word_array_without_nulls(word_array)))

func get_word_array_remove_filler(word_array : Array) -> Array:
	var output_array : Array = []
	for word in word_array:
		if not filler_words.has(word):
			output_array.push_back(word)
	return output_array

func get_word_array_without_nulls(word_array : Array) -> Array:
	var output_array : Array = []
	for word in word_array:
		if word:
			output_array.push_back(word)
	return output_array

func get_word_array_lowercase(word_array : Array) -> Array:
	var output_array : Array = []
	for word in word_array:
		output_array.push_back(word.to_lower())
	return output_array




func get_level_sentence_string(level : int) -> String:
	return level_sentences[level - 1]

func get_level_sentence_array(level : int) -> Array:
	return string_to_array(get_level_sentence_string(level))

func string_to_array(lvl_string : String) -> Array:
	var lvl_array : Array
	var end_loop : bool = false
	var prev_space : int = 0
	var next_space : int = lvl_string.find(" ")
	while not end_loop:
		if prev_space == 0: # this is to fix the first word not working
			prev_space = -1 # bc of the +1 here VV
		var word = lvl_string.substr(prev_space+1, next_space - prev_space - 1)
		lvl_array.push_back(word)
		
		prev_space = next_space
		next_space = lvl_string.find(" ", prev_space + 1)
		if next_space == -1:
			lvl_array.push_back(lvl_string.substr(prev_space+1, lvl_string.length() - prev_space)) # append final word
			end_loop = true
	return lvl_array
