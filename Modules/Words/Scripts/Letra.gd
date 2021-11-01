extends Node2D

var letter: String


func setup(new_letter: String):
	letter = new_letter.to_upper()
	$"Button/Label".text = letter
	

func _on_Button_pressed():
	self.get_parent().add_node_to_line(self)
