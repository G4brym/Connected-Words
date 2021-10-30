extends HBoxContainer

var word: String
var word_found: bool = false

var BlankLetter = preload("res://Modules/Words/BlankLetra.tscn")

func _ready() -> void:
	Events.connect("try_word", self, "_try_word")

func setup(new_word: String):
	word = new_word
	
	for child in get_children():
		child.queue_free()
		
	for letter in new_word:
		var letter_inst = BlankLetter.instance()
		letter_inst.setup(letter)
		letter_inst.set_scale(Vector2(0.5, 0.5))
		add_child(letter_inst)


func _try_word(word_to_try: String) -> void:
	if word_found == false and word_to_try.to_lower() == word.to_lower():
		for child in get_children():
			child.show()
		
		Events.emit_signal("word_found", word)
		Events.disconnect("try_word", self, "_try_word")
