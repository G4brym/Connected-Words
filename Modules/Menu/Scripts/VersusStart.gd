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


func _on_Continue_pressed():
	var url = "https://apichain.dev.catappult.io/transaction/eskills?value=1&currency=USD&product=1v1" + \
				"&user_id=a25cd286&domain=com.massadas.connectedwords&environment=SANDBOX&number_of_users=2&user_name=" + \
				$"Username".text
				
	if Engine.has_singleton("GodotEskills"):
		var singleton = Engine.get_singleton("GodotEskills")
		singleton.startMatch(url)
	#OS.shell_open(url)
