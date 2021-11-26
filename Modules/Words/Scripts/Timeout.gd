extends Label

const LABEL_UPDATE_TIME = 30.0
const LEVEL_TIMEOUT = 120.0

var update_timer: int = 0.0
var timer

func _ready():
	timer = Timer.new()
	timer.set_wait_time(0.1)
	timer.set_one_shot(true)
	timer.connect("timeout",self,"_on_timer_timeout") 
	
	add_child(timer)
	timer.start(LEVEL_TIMEOUT)
	_update_text()
	

func _process(delta):
	update_timer -= delta
	if update_timer <= 0:
		update_timer = LABEL_UPDATE_TIME

		_update_text()


func _update_text() -> void:
	text = str(round(timer.get_time_left()))

func _on_timer_timeout() -> void:
	Events.emit_signal("game_ended")
