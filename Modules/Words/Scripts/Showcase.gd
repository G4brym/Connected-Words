extends Label


func _ready() -> void:
	self.hide()
	Events.connect("try_word", self, "display")


func display(word: String):
	if word == "":
		self.hide()
	else:
		text = word
		self.show()
