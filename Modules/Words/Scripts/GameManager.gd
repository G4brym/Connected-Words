extends Node

var dictionary: WordManager.WordDictionary

var level_word
var level_word_list


func _ready():
	dictionary = WordManager.WordDictionary.new()
	
	level_word = dictionary.get_random_word(7)
	level_word_list = dictionary.list_anagram_words(level_word)
	
	Events.emit_signal("update_picker_letters", level_word)
	Events.emit_signal("update_game_words", level_word_list)
