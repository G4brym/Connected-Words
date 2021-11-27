extends Node2D


func setup(won: bool) -> void:
	if won == false:
		$"Result".text = "You Lost"
		$"Result2".text = "(Better luck next time)"
		
	_show()


func _on_Continue_pressed():
	get_tree().change_scene("res://Modules/Menu/Menu.tscn")


func _show() -> void:
	position.x = 0
