extends Node2D


func show() -> void:
	$"Username".grab_focus()


func _on_Username_text_changed(new_text):
	if len(new_text) > 0:
		$"Continue".disabled = false
	else:
		$"Continue".disabled = true



func _on_Back_pressed():
	get_tree().change_scene("res://Modules/Menu/Menu.tscn")
