extends Node2D

var rng: RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()
	rng.seed = hash("Godot")  # TODO: fill seed
