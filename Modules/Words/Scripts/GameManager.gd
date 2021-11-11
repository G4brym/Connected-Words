extends Node

const LEVEL_COMPLETENESS_PERC: int = 50

var dictionary: WordManager.WordDictionary

var level_word
var level_word_list
var words_found: Array = []

func _ready() -> void:
	dictionary = WordManager.WordDictionary.new()
	
	_setup_level()
	Events.connect("word_found", self, "_check_level_completeness")


func _check_level_completeness(word_found: String) -> void:
	words_found.append(word_found)
	
	print(len(words_found) * 100 / len(level_word_list))
	if (len(words_found) * 100 / len(level_word_list)) > LEVEL_COMPLETENESS_PERC:
		Events.emit_signal("level_completed")
		_setup_level()
		


func _setup_level() -> void:
	words_found = []
	level_word = dictionary.get_random_word(7)
	level_word_list = dictionary.list_anagram_words(level_word)
	
	if len(level_word_list) == 1:
		_setup_level()
	
	Events.emit_signal("update_picker_letters", level_word)
	Events.emit_signal("update_game_words", level_word_list)
