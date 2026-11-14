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

func get_level_sentence_string(level : int) -> String:
	return level_sentences[level - 1]

func get_level_sentence_array(level : int) -> Array:
	var lvl_string = get_level_sentence_string(level)
	var lvl_array : Array
	var end_loop : bool = false
	var prev_space : int = 0
	var next_space : int = lvl_string.find(" ")
	while not end_loop:
		if prev_space == 0: # this is to fix the first word not working
			prev_space = -1 # bc of the +1 here VV
		var word = lvl_string.substr(prev_space+1, next_space - prev_space - 1)
		lvl_array.append(word)
		
		prev_space = next_space
		next_space = lvl_string.find(" ", prev_space + 1)
		if next_space == -1:
			lvl_array.append(lvl_string.substr(prev_space+1, lvl_string.length() - prev_space)) # append final word
			end_loop = true
	return lvl_array
