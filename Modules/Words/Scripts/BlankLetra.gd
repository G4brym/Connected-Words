extends Control

var letter: String

func setup(new_letter: String):
	letter = new_letter
	$"Label".text = ""

func show():
	$"Label".text = letter.to_upper()
