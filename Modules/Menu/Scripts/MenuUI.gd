extends Node2D

onready var tween = $Tween
onready var start_menu = $StartMenu
onready var difficulty_menu = $DifficultyMenu

var RIGHT_POSITION = Vector2(-576, 300)
var MIDDLE_POSITION = Vector2(0, 300)
var LEFT_POSITION = Vector2(576, 300)


func _move(node, target):
	tween.interpolate_property(node, "rect_position", node.rect_position, target, 1, Tween.TRANS_QUINT, Tween.EASE_OUT)
	tween.start()
	
	
func _on_Start_pressed():
	_move(start_menu, RIGHT_POSITION)
	_move(difficulty_menu, MIDDLE_POSITION)


func _on_Quit_pressed():
	get_tree().quit()


func _on_Back_pressed():
	_move(difficulty_menu, LEFT_POSITION)
	_move(start_menu, MIDDLE_POSITION)


func _on_Easy_pressed():
	get_tree().change_scene("res://Modules/Game.tscn")
	
