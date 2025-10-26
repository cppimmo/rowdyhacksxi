extends Node2D

var total_cows := 0

@onready var player_ref: Player = $Player
@onready var hud: CanvasLayer   = $"Health and Cow Counter/CanvasLayer"


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
	# 1) wire existing cows
	for c in get_tree().get_nodes_in_group("cows"):
		_wire_cow(c)

	# 2) wire future cows (defer one frame so the cow has time to join the group)
	get_tree().node_added.connect(func(n):
		await get_tree().process_frame
		if n.is_in_group("cows"):
			_wire_cow(n)
	)

	# health hookup
	player_ref.health_changed.connect(hud.set_health)
	hud.set_health(player_ref.current_health, player_ref.max_health)

	
	#_spawn_mobs_from_tiles()


	# init HUD cows
	hud.set_cows(0)

func _wire_cow(cow: Node) -> void:
	if cow.has_signal("cow_picked_up") and not cow.cow_picked_up.is_connected(_on_cow_picked_up):
		cow.cow_picked_up.connect(_on_cow_picked_up)
	print("[WIRE] cow:", cow.name, "connected:", cow.has_signal("cow_picked_up") and cow.cow_picked_up.is_connected(_on_cow_picked_up))

func _on_cow_picked_up(_count_from_that_cow: int) -> void:
	total_cows += 1
	print("[PARENT] TOTAL cows picked:", total_cows)
	hud.set_cows(total_cows)
