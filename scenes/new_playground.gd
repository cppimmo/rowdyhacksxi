extends Node2D


@onready var player_ref: Player = $Player
@onready var hud: CanvasLayer = $"Health and Cow Counter/CanvasLayer"

@onready var tilemap = $"platform layer"
@export var mob_scenes = {
	"enemy_spaceship_a": {
		"scene_path": preload("res://entities/enemy_spaceship_a.tscn"),
		"probabaility": 0.25
	}
}
@export var max_mobs: int = 20
var _mob_count: int = 0

func _spawn_mobs_from_tiles():
	for cell: Vector2i in tilemap.get_used_cells(0):
		if _mob_count >= max_mobs:
			break
		
		var tile_data: TileData = tilemap.get_cell_tile_data(0, cell)
		if not tile_data:
			continue
		
		var spawn_type: bool = tile_data.get_custom_data("spawn_type")
		if not (spawn_type and mob_scenes.has(spawn_type)):
			continue
			
		#var mob_info = mob_scenes[]
		
		var mob = mob_scenes[spawn_type].instantiate()
		mob.global_position = tilemap.map_to_local(cell)
		get_tree().current_scene.add_child(mob)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_ref.health_changed.connect(hud.set_health)
	hud.set_health(player_ref.current_health, player_ref.max_health)
	
	#_spawn_mobs_from_tiles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#const Asteroid = preload("res://scenes/asteroid.tscn")

# Called when the node enters the scene tree for the first time.
#func _ready():
	#var asteroidInstance = Asteroid.instantiate()
	#add_child(asteroidInstance)
	#asteroidInstance.startDespawnTimer()
	
