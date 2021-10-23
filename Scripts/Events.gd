extends Node

signal update_game_words(words)
signal update_picker_letters(letters)

signal try_word(word)


func _ready() -> void:
	connect("try_word", self, "_log", ["try_word"])
	connect("update_game_words", self, "_log", ["update_game_words"])
	connect("update_picker_letters", self, "_log", ["update_picker_letters"])


func _log(msg: String, func_name: String) -> void:
	print(func_name + ": " + msg)
