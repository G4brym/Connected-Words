extends Button


func _ready():
	connect("pressed", self, "_shuffle_letters")


func _shuffle_letters() -> void:
	Events.emit_signal("shuffle")
