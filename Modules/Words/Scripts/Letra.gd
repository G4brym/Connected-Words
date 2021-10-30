extends Node2D




func setup(letter: String):
	$"Label".text = letter.to_upper()


func _on_Button_pressed():
	self.get_parent().add_node_to_line(self)
