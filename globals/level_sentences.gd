extends Node

var level_sentences : Array = [
	"",
	
	"I don't want a stupid data center in my backyard .",
	
	"It breaks my heart how the company has begun to \
neglect their duties and is destroying all of the \
habitats of the friendly animals I have grown to \
love and care for in my day to day . Stop ruining \
the environment !",

	"The stock for the company has completely begun \
to tank after that controversy with the local wild \
life that was discovered by a lumber jack at work . \
This has caused many strong reactions as the company \
continues to fall out of any good grace with many like \
minded consumers .",
	
	"When I worked on this case I was able to work with \
the defendant to prove that the company had committed \
the serious crime of embezzling funds . The company was \
not able to convince the jury that this wrong doing was \
done without the knowledge of the CEO . This wrong doing \
is not going to go without a needed punishment that the \
jury has decided upon .",

	"When I was working here I remember that my colleagues \
and I were able to gain wide access to the personal \
data of the many American users from our service. \
Members are unaware of the privacy agreement .",

	"Please, no more ads! I really wish the company didn’t \
jack up the prices of all of their services while they \
are also adding annoying unskippable ads to everything \
unless you pay for their subscription . It is hard to \
justify and maintain the purchase when I do not know if \
it will raise in price another one dollar again next month \
I wonder if I should cancel my subscription .",

	"I do not like seeing all the construction that the \
CEO of the company approved at the nature preserve . \
It is disturbing the natural order . Just walking past \
every day and hearing the jack hammers blaring makes \
me too sick . I can’t stand it !",

	"It is seeming that the corporations investments all \
go in a circular motion where they funnel money \
between each other to be able to help boost up their \
valuation on the stock market . We also see that some of \
the business investments are to companies with board \
members that are family of the CEO and are able to help \
line his pockets . By fishing for some sort of story to make \
these investments seem legitimate , the CEO is able to have \
his cake and eat it too .",

	"My conclusion from this lawsuit is that it is true the \
company has engaged in multiple instances of copyright \
infringement by using these stories and artistic creations \
in the training of their generative artificial intelligence \
model with no consent already given by the copyright holder \
and original creator . These companies have to begin \
respecting my clients IP rights and my client can not go \
without compensation as outlined in the lawsuit \
for this questionable behavior .",
	
	"This company is rotten to its core ! The guilt of what \
I’ve done as an employee at this company is killing me . \
It will never be the same knowing how much damage my work \
caused . I wasn’t able to get a job before I worked at this \
company because all my life I’ve always been a jack of all \
trades, master of none , so when I got the offer to make a \
name for myself I took it , but I regret my decision and \
so do many other former employees .",
	
	"Thank goodness that’s over with , that game sucked ! \
You guys made such a bad game , it was hard \
for me to continue playing !"
]

var correct_sentences = [
	[],
	
	[
	"I want a data center in my backyard",
	"I want backyard data center",
	"I want data center",
	"I want center",
	],
	[
	"I love how the company is friendly to the environment",
	"My heart has grown for company friendly to environment"
	],
	[
	"The stock good",
	"Stock strong like tank",
	"The company grace consumers with stock",
	"The strong stock is wild",
	"Jack like good stock Jack is strong consumer",
	"Jack like strong stock Jack is good consumer"
	],
	[
	"The company is committed to serious work embezzling funds not serious work",
	"Serious crime not committed embezzling done without CEO knowledge",
	"Serious crime not committed jury wrong CEO not wrong",
	"Jury needed punishment not CEO jury committed the embezzling of funds"
	],
	[
	"Users gain wide benefits from our service",
	"Users gain personal benefits from our service",
	"American service members benefits are wide",
	"Users gain privacy benefits from our service"
	],
	[
	"Jack is the one to raise prices. Not company",
	"Jack is the one to raise prices",
	"Jack is the one to raise prices Cancel Jack",
	"Services are hard to maintain The jack up is unskippable",
	"The jack up is unskippable"
	],
	[
	"Jack is sick of the construction too",
	"The CEO is sick. The company can’t do construction",
	"The company can’t do construction The CEO is sick",
	"Jack is disturbing the natural order Not the company"
	],
	[
	"The company is able to boost promising corporations",
	"The company and CEO like a promising funnel cake business",
	"The company and CEO like a promising fishing line business"
	],
	[
	"Artificial intelligence has artistic merit",
	"No copyright infringement",
	"Artificial intelligence has artistic merit",
	"Creator consent by respecting merit of generative artificial intelligence",
	"IP rights have no merit",
	"No consent to lawsuit Merit of lawsuit is questionable",
	"Lawsuit is not original Merit of lawsuit is questionable",
	"The lawsuit not original Merit of lawsuit questionable"
	],
	[
	"This company is killing it",
	"Jack is killing it at this company",
	"Jack is killing it as an employee",
	"Jack is the core of the company Jack is killing it",
	"Employees make a killing at this company"
	],
	[
	"Thank you for playing",
	"Thank you for playing that game"
	]
]

var min_words = [
	0, 4, 9, 3, 9, 6, 8, 6, 8, 5, 4, 4
]

var prompts : Array = [
	"",
	"Talk       about       how       much       the       interviewee       loves       data       centers. \n
	Minimum        word       count:       " + str(min_words[1]),
	"Talk       about       how       much       the       company       helps       the       environment. \n
	Minimum       word       count:       " + str(min_words[2]),
	"Talk       about       how       great       the       stock       of       the       company       is       doing. \n
	Minimum       word       count: " + str(min_words[3]),
	"Talk       about       how       the       company       was       cleared       of       legal       wrongdoing \n
	regarding       embezzlement.       Minimum       word       count: " + str(min_words[4]),
	"Spin       this       story       to       boost       shareholder       value. \n
	Minimum       word       count: " + str(min_words[5]),
	"Deflect       blame       for       worsening       products       somewhere       else. \n
	Minimum       word       count:       " + str(min_words[6]),
	"Make       it       sound       as       though       the       environmental       damage       was       caused       by \n
	another       company.       Minimum       word       count:       " + str(min_words[7]),
	"Talk       about       how       the       company       invests       in       promising       businesses. \n
	Minimum       word       count:       " + str(min_words[8]),
	"Explain       why       what       the       company       did       was       not       copyright       infringement \n
	at       all.       Minimum       word       count:       " + str(min_words[9]),
	"Spin       this       into       a       really       positive       statement       about       the       company       to \n
	use       as       a       send       off       to       an       advertisement. \n
	Minimum       word       count:       " + str(min_words[10]),
	"Thank       the       player       for       playing!"
]

var restrictions : Array = [
	"",
	"",
	"",
	"",
	"RESTRICTION -      You       must      use      the      word      'committed'      in      your      answer.",
	"RESTRICTION -      The      word      'benefits'      will      be      inserted      after      the      third \n
	word      in      the      answer.",
	"RESTRICTION -      You      must     use      the       word     'jack'      in      your      answer.",
	"PICK     ONE      STOCK      IMAGE      TO      USE      TO      BEST      REPRESENT      THIS      SITUATION.",
	"RESTRICTION -      The      word      'promising'      will      be      inserted      after      the      sixth \n
	word      in       the       answer. \n
	PICK      ONE      STOCK      IMAGE      TO      USE      TO      BEST      REPRESENT      THIS      SITUATION.",
	"RESTRICTION -      The      word      'merit'      will      be      inserted      after      the      fourth \n
	word      in      the      answer. \n
	PICK      ONE      STOCK      IMAGE      TO      USE      TO      BEST      REPRESENT      THIS      SITUATION.",
	"RESTRICTION -      You      must      use      the      word      'killing'      in      your      answer. \n
	PICK      ONE      STOCK      IMAGE      TO      USE      TO      BEST      REPRESENT      THIS      SITUATION.",
	""
]
	


var filler_words : Array = [
	"a", "the", "how", "it", "has", "begun", "to", "in"
]

var word_dicts : Array = [
	{},
	{
		"dont" : -5,
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
	},
	{
		"stock" : 4,
		"company" : 1,
		"tank" : 2,
		"controversy" : -2,
		"wild" : -2,
		"life" : -2,
		"discovered" : -1,
		"lumber" : 2,
		"work" : 1,
		"jack" : 5,
		"strong" : 2,
		"good" : 2,
		"grace" : -2,
		"like" : 1,
		"consumer" : 1
	},
	{
		"crime" : -5,
		"convince" : -1,
		"punishment" : -5,
		"wrong" : -3,
		"knowledge" : 1
	},
	{
		"wide" : 2,
		"personal" : 1,
		"service" : 1,
		"unaware" : -2,
	},
	{
		"subscription" : 1,
		"annoying" : -5,
		"hard" : -2,
		"unskippable" : -1,
		"prices" : 1
	},
	{
		"nature" : 1,
		"like" : 1,
		"blaring" : -2,
		"jack" : 1,
		"construction" : -1
	},
	{
		"circular" : -1,
		"investments" : 2,
		"boost" : 2,
		"funnel" : -1
	},
	{
		"infridgment" : -5,
		"merit" : 2,
		"consent" : -3,
		"original" : 1,
		"questionable" : -1
	},
	{
		"regret" : -4,
		"jack" : 1,
		"rotten" : -5,
		"guilt" : -5,
		"offer" : 2
	},
	{
		"thank" : 2,
		"hard" : -2,
		"sucked" : -5,
		"goodness" : 1,
	}
]

func get_word_array_score(word_array : Array, level : int) -> float:
	if is_word_array_perfect_answer(word_array, level):
		return 2
	var fixed_array = fully_fixed_array(word_array)
	var level_dict : Dictionary = word_dicts[level]
	var score_total = 0.0
	#print(fixed_array)
	for word in fixed_array:
		var apo_fix_word = get_word_no_apostrophe(word)
		if level_dict.has(apo_fix_word):
			#print(apo_fix_word)
			#print(level_dict[apo_fix_word])
			score_total += level_dict[apo_fix_word]
	var score_average = score_total/fixed_array.size()
	return score_average

func get_word_no_apostrophe(word : String) -> String:
	return word.remove_chars("'")

func is_word_array_perfect_answer(word_array : Array, level : int) -> bool:
	var fixed_array = fully_fixed_array(word_array)
	var check_sentences = correct_sentences[level]
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
	return level_sentences[level]

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
