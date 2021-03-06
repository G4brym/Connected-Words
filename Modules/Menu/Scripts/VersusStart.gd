extends Node2D

var eskills

func _ready():
	if Engine.has_singleton("GodotEskills"):
		eskills = Engine.get_singleton("GodotEskills")

		# These are all signals supported by the API
		# You can drop some of these based on your needs
		eskills.connect("payment_started", self, "_on_payment_started") # No params
		eskills.connect("payment_error", self, "_on_payment_error") # Response message (string)
		eskills.connect("room_found", self, "_on_room_found") # No params

	else:
		print("Android Eskills support is not enabled. Make sure you have enabled 'Custom Build' and the GodotEskills plugin in your Android export settings! Eskills will not work.")


func _on_Username_text_changed(new_text):
	if len(new_text) > 0:
		$"Continue".disabled = false
	else:
		$"Continue".disabled = true


func show() -> void:
	$"Username".grab_focus()


func _on_payment_started() -> void:
	print("_on_payment_started")
	
	
func _on_payment_error(code: int, message: String) -> void:
	print("_on_payment_error: code -> " + str(code) + " message -> " + str(message))


func _on_Back_pressed() -> void:
	SceneSwitcher.change_scene("Menu/Menu.tscn")


func _on_room_found() -> void:
	print("_on_match_found")
	
	yield(get_tree().create_timer(0.1), "timeout")
	
	var room = eskills.getRoom()
	var current_user = room["current_user"]
	var room_id = room["room_id"]
	
	var opponent_username = null
	for user in room["users"]:
		if user["ticket_id"] != current_user["ticket_id"]:
			# Opponent found
			opponent_username = user["user_name"]
			break
	
	Globals.set_seed(room_id)
	SceneSwitcher.change_scene("Game.tscn", {
			"versus_mode":true,
			"opponent_username": opponent_username,
			"seed": room_id,
		})
	
func _on_Continue_pressed() -> void:
	eskills.findRoom({
		value="1",
		currency="USD",
		product="1v1",
		timeout="200",
		domain="com.massadas.connectedwords",
		environment="SANDBOX",
		number_of_users="2",
		user_name=$"Username".text,
		user_id=$"Username".text,
	})
	
