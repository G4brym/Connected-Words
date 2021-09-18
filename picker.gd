extends Node2D


func _ready():
	var _childs = self.get_children()
	var _total = len(_childs)
	
	var total = 270.0
	var radius = 50
	var step = 360 / _total
	for _child in _childs:
		_child.position = Vector2(radius*cos(deg2rad(total)), radius*sin(deg2rad(total)))
		total += step
		

var is_listening = false
var current_line = null
var update_delta = 0

func _input(event):
	if event.is_action_released("Click") and current_line != null:
		is_listening = false
		current_line.queue_free()
		current_line = null

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
	

func create_line(node):
	connected_letters = [node]
	is_listening = true
	current_line = Line2D.new()
	current_line.default_color = Color(255,255,255,1)
	current_line.width = 5
	var pool = PoolVector2Array([node.global_position, get_global_mouse_position()])
	
	current_line.points = pool
	self.get_parent().add_child(current_line)

	
func update_line():
	current_line.set_point_position(current_line.points.size()-1, get_global_mouse_position())
