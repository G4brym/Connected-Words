extends Node2D


func _ready():
	if not Engine.has_singleton("GodotEskills"):
		$"PlayAgainst".disabled = true



func _on_PlayAgainst_pressed():
	$"VersusStart".position.x = 0
	$"VersusStart".show()


func _on_Training_pressed():
	SceneSwitcher.change_scene("Game.tscn", {
		"versus_mode":false,
	})
	
	#SceneSwitcher.change_scene("Game.tscn", {"versus_mode":false})
