extends Node

const LEVEL_COMPLETENESS_PERC: int = 60

var dictionary: WordManager.WordDictionary

var level_word
var level_word_list
var words_found: Array = []

var optional_words_found: Array = []

func _ready() -> void:
	dictionary = WordManager.WordDictionary.new()
	
	_setup_level()
	Events.connect("word_found", self, "_check_level_completeness")
	Events.connect("try_word", self, "_try_optional_word")
	Events.connect("level_completed", self, "_on_game_completed")


func _on_game_completed(score: int, won: bool) -> void:
	if SceneSwitcher.get_param("versus_mode") == true:
		if score == -1:
			$"UI/WaitingForPlayers"._show()
		else:
			$"UI/WaitingForPlayers"._hide()
			$"UI/VersusCompleted".setup(won)
		
	else:
		$"UI/LevelCompleted"._show(score)


func _check_level_completeness(word_found: String) -> void:
	words_found.append(word_found)
	
	if (len(words_found) * 100 / len(level_word_list)) > LEVEL_COMPLETENESS_PERC:
		_setup_level()
		

func _try_optional_word(word: String) -> void:
	word = word.to_lower()
	
	if len(word) < 4 or word in optional_words_found:
		return
	
	if word in dictionary.full_dictionary and not(word in dictionary.game_dictionary):
		optional_words_found.append(word)
		Events.emit_signal("optional_word_found", word)
		

func _setup_level() -> void:
	words_found = []
	level_word = dictionary.get_random_word(7)
	level_word_list = dictionary.list_anagram_words(level_word)
	
	if len(level_word_list) == 1:
		_setup_level()
	
	Events.emit_signal("update_picker_letters", level_word)
	Events.emit_signal("update_game_words", level_word_list)
