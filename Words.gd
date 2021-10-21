extends Node2D

var big_dict
var small_dict
var level_word

var level_word_list

var rng


var Word = preload("res://Word.tscn")

func _ready():
	rng = RandomNumberGenerator.new()
	rng.seed = hash("Godot")  # TODO: fill seed
	
	load_data()
	
	level_word = pick_level_word(7)
	
	level_word_list = find_available_word(level_word)
	print(level_word)
	print(level_word_list)
	
	_build_word_display(level_word_list)
	
func _build_word_display(words: Array):
	var initial_column = $HBoxContainer/Left
	var other_column = $HBoxContainer/Right
	var helper
	
	for word in words:
		var inst = Word.instance()
		inst.setup(word)
		
		initial_column.add_child(inst)
		helper = initial_column
		initial_column = other_column
		other_column = helper
	

func load_data():
	var file = File.new()
	file.open("res://python/words.json", file.READ)

	var data = parse_json(file.get_as_text())
	big_dict = data["big_dict"]
	small_dict = data["small_dict"]

func pick_level_word(dificulty: int):
	var available_words = []
	for word in small_dict:
		if len(word) == dificulty:
			available_words.append(word)
	
	return available_words[rng.randi_range(0, len(available_words)-1)]

class WordLengthSorter:
	static func sort_length(a, b):
		if len(a) > len(b):
			return true
		return false

func find_available_word(original_word: String):
	var available_words = []
	for word in small_dict:
		if _check_word_availability(original_word, word):
			available_words.append(word)
	
	available_words.sort_custom(WordLengthSorter, "sort_length")
	
	return available_words.slice(0, 6)
	
func _check_word_availability(original_word: String, match_word: String):
	for letter in original_word:
		match_word.erase(match_word.find(letter), 1)
		
	if match_word == "":
		return true
	return false
