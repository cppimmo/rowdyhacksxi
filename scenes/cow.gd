extends Area2D

var cowCount: int = 0
signal cow_picked_up(count: int)

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	print("cow ready on:", name, "connected?", body_entered.is_connected(_on_body_entered))

func _on_body_entered(body: Node) -> void:
	print("cow body_entered by:", body.name, "groups:", body.get_groups())

	var p := body
	# if we hit a child collider of the player, climb to the parent
	if not p.is_in_group("player") and body.get_parent():
		if body.get_parent().is_in_group("player"):
			p = body.get_parent()

	if p.is_in_group("player"):
		print("signal emitted: cow_picked_up")
		cowCount += 1
		emit_signal("cow_picked_up", cowCount)
		queue_free()
