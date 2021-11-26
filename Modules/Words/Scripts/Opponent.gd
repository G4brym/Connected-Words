extends Node2D

var eskills
var last_score = 0
var should_track = false


func _ready():
	if SceneSwitcher.get_param("versus_mode") == true:
		$"OpponentInfos/Name".text = SceneSwitcher.get_param("opponent_username")
		$"OpponentInfos/Score".text = "0"
		
		eskills = Engine.get_singleton("GodotEskills")
		Events.connect("score_updated", self, "_update_eskills_score")
		Events.connect("game_ended", self, "_submit_final_score")
		
		should_track = true
	else:
		hide()


func _update_eskills_score(score) -> void:
	last_score = score
	eskills.updateScore(score, "PLAYING")


func _submit_final_score() -> void:
	eskills.updateScore(last_score, "COMPLETED")
