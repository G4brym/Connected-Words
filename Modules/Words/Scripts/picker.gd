extends Node2D

var Letter = preload("res://Modules/Words/Letra.tscn")
const radius = 170

var letters
var game_ended = false

func _ready() -> void:
	Events.connect("update_picker_letters", self, "_update_picker_letters")
	Events.connect("shuffle", self, "_shuffle_and_build")
	
	Events.connect("word_found", self, "_reset_picker")
	Events.connect("optional_word_found", self, "_reset_picker")
	
	Events.connect("game_ended", self, "_on_game_ended")

func _on_game_ended():
	game_ended = true

func _reset_picker(word: String = "") -> void:
	is_listening = false
	current_line.queue_free()
	current_line = null
	Events.emit_signal("try_word", "")

	
func _update_picker_letters(word: String):
	connected_letters = []
	letters = []
	for letter in word:
		letters.append(letter)
	
	_shuffle_and_build()
	
func _shuffle_and_build():	
	letters.shuffle()
	
	_build_childs(letters)

func _build_childs(word: Array):
	for child in self.get_children():
		child.queue_free()
	
	var _total = len(word)
	var total = 270.0

	var step = 360 / _total
	for _letter in word:
		var letter_node = Letter.instance()
		letter_node.position = Vector2(radius*cos(deg2rad(total)), radius*sin(deg2rad(total)))
		letter_node.setup(_letter)
		
		add_child(letter_node)
		total += step
	

var is_listening = false
var current_line = null
var update_delta = 0

func _input(event):
	if event.is_action_released("Click") and current_line != null:
		_reset_picker()

func _process(delta):
	if update_delta < 0 and is_listening:
		update_line()
		update_delta = 0.02

	update_delta -= delta


var connected_letters = []


func add_node_to_line(node):
	if game_ended == true:
		if current_line != null:
			_reset_picker()
			
		return
	
	if current_line == null:
		create_line(node)
	
	elif is_listening:
		if connected_letters.has(node):
			var _postion = connected_letters.find(node)
			connected_letters = connected_letters.slice(0, _postion)
			current_line.clear_points()
			for point in connected_letters:
				current_line.add_point(point.global_position)
				
			current_line.add_point(get_global_mouse_position())
		else:
			connected_letters.append(node)
			current_line.add_point(node.global_position, current_line.points.size()-1)
		
	var final_word = ""
	for letter in connected_letters:
		final_word += letter.letter

	Events.emit_signal("try_word", final_word)
	

func create_line(node):
	connected_letters = [node]
	is_listening = true
	current_line = Line2D.new()
	current_line.set_joint_mode(1)
	current_line.set_default_color(Color(0.91, 0.64, 0.14 ,1))
	current_line.set_width(10)
	current_line.set_antialiased(true)
	current_line.set_begin_cap_mode(2)
	current_line.set_end_cap_mode(2)
	var pool = PoolVector2Array([node.global_position, get_global_mouse_position()])
	
	current_line.points = pool
	self.get_parent().add_child(current_line)

	
func update_line():
	current_line.set_point_position(current_line.points.size()-1, get_global_mouse_position())
