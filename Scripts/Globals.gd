extends Node2D

var rng: RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	

func set_seed(seed_word: String) -> void:
	return
	#rng.seed = hash(seed_word)  # TODO: fill seed
