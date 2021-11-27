extends Node2D

var eskills
var last_score = 0
var should_track = false
var game_status = "PLAYING"

const LABEL_UPDATE_TIME = 60.0
var update_timer: int = 0.0


func _ready():
	if SceneSwitcher.get_param("versus_mode") == true:
		$"OpponentInfos/Name".text = SceneSwitcher.get_param("opponent_username")
		$"OpponentInfos/Score".text = "0"
		
		eskills = Engine.get_singleton("GodotEskills")
		Events.connect("score_updated", self, "_update_local_score")
		Events.connect("game_ended", self, "_submit_final_score")
		
		should_track = true
	else:
		hide()


func _process(delta):
	if should_track == true:
		update_timer -= delta
		if update_timer <= 0:
			update_timer = LABEL_UPDATE_TIME

			_update_scores()


func _update_scores() -> Dictionary:
	# This submits current score and also fetchs opponent score
	var room_details = eskills.updateScore(int(last_score), game_status)
	
	var current_user_ticket_id = room_details.get("current_user", {}).get("ticket_id")

	var opponent_score = null
	for user in room_details.get("users", []):
		if user["ticket_id"] != current_user_ticket_id:
			# Opponent found
			opponent_score = user["score"]
			break
	
	if opponent_score != null:
		$"OpponentInfos/Score".text = str(opponent_score)
	
	return room_details


func _update_local_score(score) -> void:
	last_score = score


func _submit_final_score() -> void:
	game_status = "TIME_UP"
	
	#yield(get_tree().create_timer(0.1), "timeout")
	#_update_scores()
	
	Events.emit_signal("level_completed", -1, false)
	
	_check_game_completeness()


func _check_game_completeness() -> void:
	print("Checking for winner result")
	var room_details = eskills.getRoom()
	
	print(str(room_details))
	if room_details != null:
		var room_result = room_details.get("room_result")
		if room_result:
			var winner_ticket_id = room_result.get("winner", {}).get("ticket_id")
		
			if winner_ticket_id:
				if room_details.get("current_user", {}).get("ticket_id", null) == winner_ticket_id:
					Events.emit_signal("level_completed", last_score, true)
				else:
					Events.emit_signal("level_completed", last_score, false)
					
				return
		
	yield(get_tree().create_timer(0.5), "timeout")
	_check_game_completeness()

