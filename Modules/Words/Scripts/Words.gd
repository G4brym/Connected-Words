extends Control


onready var Word = preload("res://Modules/Words/Word.tscn")


func _ready():
	Events.connect("update_game_words", self, "_setup_words")

var word_childs = []

func _setup_words(words: Array):
	var initial_column = $Left
	var other_column = $Right
	var helper
	
	for child in word_childs:
		child.queue_free()
		
	word_childs = []
	
	for word in words:
		var inst = Word.instance()
		inst.setup(word)
		
		initial_column.add_child(inst)
		word_childs.append(inst)
		helper = initial_column
		initial_column = other_column
		other_column = helper
	
