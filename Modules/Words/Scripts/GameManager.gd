extends Node

const LEVEL_COMPLETENESS_PERC: int = 60

var dictionary: WordManager.WordDictionary

var level_word
var level_word_list
var words_found: Array = []

func _ready() -> void:
	dictionary = WordManager.WordDictionary.new()
	
	_setup_level()


func _check_level_completeness(word_found: String) -> void:
	words_found.append(word_found)
	
	print(len(words_found) * 100 / len(level_word_list))
	if (len(words_found) * 100 / len(level_word_list)) > LEVEL_COMPLETENESS_PERC:
		Events.emit_signal("level_completed")


func _setup_level() -> void:
	level_word = dictionary.get_random_word(7)
	level_word_list = dictionary.list_anagram_words(level_word)
	
	Events.emit_signal("update_picker_letters", level_word)
	Events.emit_signal("update_game_words", level_word_list)
	
	Events.connect("word_found", self, "_check_level_completeness")
