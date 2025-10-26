extends Area2D
const HEALTH_AND_COW_COUNTER = preload("res://scenes/health_and_cow_counter.tscn")

signal cow_picked_up(count: int)
var cowCount := 0

func _enter_tree() -> void:
	add_to_group("cows")
	print("[COW] enter:", get_path())

func _ready() -> void:
	monitoring = true
	monitorable = true
	body_entered.connect(_on_body_entered)
	print("[COW] ready:", name, "connected?", body_entered.is_connected(_on_body_entered))

func _on_body_entered(body: Node) -> void:
	var p := body
	if not p.is_in_group("player") and body.get_parent() and body.get_parent().is_in_group("player"):
		p = body.get_parent()

	if p.is_in_group("player"):

		print("signal emitted: cow_picked_up")
		HEALTH_AND_COW_COUNTER.increaseCows()
		#cowCount+=1

		emit_signal("cow_picked_up", cowCount)
		queue_free()
