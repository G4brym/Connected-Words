extends CenterContainer

var word: String

func _ready() -> void:
	Events.connect("try_word", self, "_try_word")

func setup(new_word: String):
	word = new_word
	$Label.text = new_word


func _try_word(word_to_try: String) -> void:
	if word_to_try == word:
		$Label.set("custom_colors/font_color", Color(1,0,0))
