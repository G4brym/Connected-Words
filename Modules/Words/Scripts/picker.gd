extends Node2D

var Letter = preload("res://Modules/Words/Letra.tscn")

func _ready() -> void:
	Events.connect("update_picker_letters", self, "_shuffle")

	
func _shuffle(word: String):
	var word_splitted = []
	for letter in word:
		word_splitted.append(letter)
	
	word_splitted.shuffle()
	
	_build_childs(word_splitted)

func _build_childs(word: Array):
	for child in self.get_children():
		child.queue_free()
	
	var _total = len(word)
	
	var total = 270.0
	var radius = 175

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
		is_listening = false
		current_line.queue_free()
		current_line = null
		Events.emit_signal("try_word", "")

func _process(delta):
	if update_delta < 0 and is_listening:
		update_line()
		update_delta = 0.02

	update_delta -= delta


var connected_letters = []


func add_node_to_line(node):
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
		final_word += letter.get_node("Label").text

	Events.emit_signal("try_word", final_word)
	

func create_line(node):
	connected_letters = [node]
	is_listening = true
	current_line = Line2D.new()
	current_line.set_joint_mode(1)
	current_line.set_default_color(Color(0.95, 0.61, 0.07,1))
	current_line.set_width(10)
	current_line.set_antialiased(true)
	current_line.set_begin_cap_mode(2)
	current_line.set_end_cap_mode(2)
	var pool = PoolVector2Array([node.global_position, get_global_mouse_position()])
	
	current_line.points = pool
	self.get_parent().add_child(current_line)

	
func update_line():
	current_line.set_point_position(current_line.points.size()-1, get_global_mouse_position())
