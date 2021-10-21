extends Node2D


func _ready():
	$"UI/Picker".setup($"UI/Words".level_word)


func _on_Picker_word_change(word):
	$UI/Showcase.display(word)
