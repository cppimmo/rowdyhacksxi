extends Node2D


@onready var player_ref: Player = $Player
@onready var hud: CanvasLayer = $"Health and Cow Counter/CanvasLayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_ref.health_changed.connect(hud.set_health)
	hud.set_health(player_ref.current_health, player_ref.max_health)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#const Asteroid = preload("res://scenes/asteroid.tscn")

# Called when the node enters the scene tree for the first time.
#func _ready():
	#var asteroidInstance = Asteroid.instantiate()
	#add_child(asteroidInstance)
	#asteroidInstance.startDespawnTimer()
	

