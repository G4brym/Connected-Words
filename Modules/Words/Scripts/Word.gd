extends CenterContainer

var word: String

func setup(new_word: String):
	word = new_word
	$Label.text = new_word
