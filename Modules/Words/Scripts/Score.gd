extends Label

var current_score: int = 0

const OPTIONAL_WORD_FOUND_SCORE = 1

func _ready():
	Events.connect("word_found", self, "_register_word_found")
	Events.connect("optional_word_found", self, "_register_optional_word_found")
	Events.connect("game_ended", self, "_on_game_end")
	_update_text()


func _register_word_found(word: String) -> void:
	current_score += len(word)
	_update_text()


func _register_optional_word_found(word: String) -> void:
	current_score += OPTIONAL_WORD_FOUND_SCORE
	_update_text()


func _update_text() -> void:
	text = str(current_score)


func _on_game_end() -> void:
	Events.emit_signal("level_completed", current_score)
