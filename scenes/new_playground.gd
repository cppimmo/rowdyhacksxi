extends Node2D

var total_cows := 0

@onready var player_ref: Player = $Player
@onready var hud: CanvasLayer   = $"Health and Cow Counter/CanvasLayer"

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
