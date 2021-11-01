extends Label

var word: String
var word_found: bool = false


func _ready() -> void:
	Events.connect("try_word", self, "_try_word")

func setup(new_word: String):
	word = new_word

	var word_text = ""
	for letter in new_word:
		word_text += "_"
		
	text = word_text

func _try_word(word_to_try: String) -> void:
	if word_found == false and word_to_try.to_lower() == word.to_lower():
		text = word
		
		Events.emit_signal("word_found", word)
		Events.disconnect("try_word", self, "_try_word")
