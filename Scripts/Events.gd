extends Node

signal update_game_words(words)
signal update_picker_letters(letters)

signal try_word(word)
signal word_found(word)
signal optional_word_found(word)

signal shuffle()

signal level_completed(score)
signal game_ended()


func _ready() -> void:
	connect("try_word", self, "_log", ["try_word"])
	connect("update_game_words", self, "_log", ["update_game_words"])
	connect("update_picker_letters", self, "_log", ["update_picker_letters"])
	connect("word_found", self, "_log", ["word_found"])
	connect("optional_word_found", self, "_log", ["optional_word_found"])
	connect("level_completed", self, "_log", ["level_completed"])
	connect("game_ended", self, "_log", ["--", "game_ended"])
	connect("shuffle", self, "_log", ["--", "shuffle"])


func _log(msg, func_name: String) -> void:
	print(func_name, ": ", msg)
