extends Node2D

var eskills

func _ready():
	if Engine.has_singleton("GodotEskills"):
		eskills = Engine.get_singleton("GodotEskills")

		# These are all signals supported by the API
		# You can drop some of these based on your needs
		eskills.connect("payment_started", self, "_on_payment_started") # No params
		eskills.connect("payment_error", self, "_on_payment_error") # Response message (string)
		eskills.connect("match_found", self, "_on_match_found") # No params

	else:
		print("Android Eskills support is not enabled. Make sure you have enabled 'Custom Build' and the GodotEskills plugin in your Android export settings! Eskills will not work.")

func show() -> void:
	$"Username".grab_focus()

func _on_payment_started():
	print("_on_payment_started")

func _on_match_found():
	print("_on_match_found")
	
func _on_payment_error(message):
	print("_on_payment_error" + message)

func _on_Username_text_changed(new_text):
	if len(new_text) > 0:
		$"Continue".disabled = false
	else:
		$"Continue".disabled = true


func _on_Back_pressed():
	get_tree().change_scene("res://Modules/Menu/Menu.tscn")


func _on_Continue_pressed():
	var url = "https://apichain.catappult.io/transaction/eskills?value=1&currency=USD&product=1v1&timeout=200" + \
				"&domain=com.massadas.connectedwords&environment=SANDBOX&number_of_users=2&user_name=" + \
				$"Username".text + "&user_id=" + $"Username".text


	if eskills:
		eskills.findMatch({
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
	

const LABEL_UPDATE_TIME = 30.0
var update_timer: int = 0.0

func _process(delta):
	update_timer -= delta
	if update_timer <= 0:
		update_timer = LABEL_UPDATE_TIME

		if eskills:
			print(eskills.getSessionToken())
