extends Node

static func randi_num_between(min: int, max: int) -> int:
	return randi() % (max + 1 - min) + min


static func randf_num_between(min: float, max: float) -> float:
	return randf() * (max - min) + min
	
	
# Utility function to get a random direction
static func get_random_direction() -> int:
	return 1 if randi_num_between(0, 1) == 1 else -1
