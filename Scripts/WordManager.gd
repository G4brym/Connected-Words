extends Node


const DICTIONARY_PATH = "res://Dictionaries/en_dictionary.json"

class WordDictionary:
	var _language
	var full_dictionary
	var game_dictionary

	func _init(language: String = "en"):
		self._language = language
		self._load()

	func _load():
		var file = File.new()
		file.open(DICTIONARY_PATH, file.READ)

		var data = parse_json(file.get_as_text())
		self.full_dictionary = data["big_dict"]
		self.game_dictionary = data["small_dict"]

	func get_random_word(word_length: int):
		var available_words = []
		for word in self.game_dictionary:
			if len(word) == word_length:
				available_words.append(word)
		
		return available_words[Globals.rng.randi_range(0, len(available_words)-1)]

	func list_anagram_words(initial_word: String):
		var matched_words = []
		for word in self.game_dictionary:
			if _check_if_word_match(initial_word, word):
				matched_words.append(word)
		
		matched_words.sort_custom(WordSorter, "sort_length")
		
		return matched_words.slice(0, 6)
		
	func _check_if_word_match(original_word: String, match_word: String):
		for letter in original_word:
			match_word.erase(match_word.find(letter), 1)
			
		if match_word == "":
			return true
		return false


class WordSorter:
	static func sort_length(a, b):
		if len(a) > len(b):
			return true
		return false
		
	static func sort_length_reverse(a, b):
		if len(a) < len(b):
			return true
		return false
