extends Area2D

@export var speed: float = 400.0
@export var lifetime: float = 3.0 # Seconds before deletion
var velocity: Vector2 = Vector2.ZERO
var time_alive: float = 0.0


func _process(delta: float) -> void:
	time_alive += delta
	position += velocity * delta
	
	if time_alive >= lifetime:
		queue_free() # Destroy this obj


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Ha! I hit the player.")
		queue_free() # Remove this obj
