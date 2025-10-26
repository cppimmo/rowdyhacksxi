extends Area2D

@onready var target: Node = get_tree().get_first_node_in_group("player")

func _on_ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if not target:
		return
	var dir = (target.global_position - global_position).normalized()
	# sprite art in editor points UP, so offset +90
	var angle = dir.angle() + deg_to_rad(90)
	$Sprite2D.rotation = angle
