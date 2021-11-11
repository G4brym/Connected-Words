extends Node2D


func _ready():
	Events.connect("level_completed", self, "_show")
	

func _show(score: int) -> void:
	position.x = 0
	$ScoreLabel.text = "Final Score " + str(score)


func _on_Continue_pressed():
	get_tree().change_scene("res://Modules/Menu/Menu.tscn")
