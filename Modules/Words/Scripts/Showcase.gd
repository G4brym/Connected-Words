extends HBoxContainer


func _ready() -> void:
	Events.connect("try_word", self, "display")


func display(word: String):
	$Label.text = word
