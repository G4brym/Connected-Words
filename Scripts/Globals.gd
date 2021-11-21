extends Node2D

var rng: RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()


func get_random_seed() -> int:
	var local_rng = RandomNumberGenerator.new()
	local_rng.randomize()
	
	return local_rng.randi_range(0, 4967295)
	

func set_seed(seed_word: String) -> void:
	return
	#rng.seed = hash(seed_word)  # TODO: fill seed
