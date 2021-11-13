extends Node2D


func _on_PlayAgainst_pressed():
	$"VersusStart".position.x = 0
	$"VersusStart".show()


func _on_Training_pressed():
	get_tree().change_scene("res://Modules/Game.tscn")
