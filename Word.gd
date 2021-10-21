extends HBoxContainer

var word: String

func _ready():
	pass # Replace with function body.

func setup(new_word: String):
	word = new_word
	$Label.text = new_word
