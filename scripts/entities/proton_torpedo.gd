extends Node2D

@export var speed: float = 200.0
@export var homing_strength: float = 2.0
@export var burn_time: float = 3.5 
@export var lifespan: float = 8.5
var time_elapsed: float = 0.0
var target: Node

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_ready() -> void:
	animated_sprite_2d.play("burn")
	audio_stream_player_2d.play()
	target = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	time_elapsed += delta
	if time_elapsed >= burn_time:
		animated_sprite_2d.play("fuel_spent")
		
	if time_elapsed >= lifespan:
		queue_free()
		
	if target:
		var dir_to_target = (target.position - position).normalized()
		
		var curr_dir = Vector2(1, 0).rotated(rotation)
		var new_dir = curr_dir.lerp(dir_to_target, homing_strength * delta).normalized()
		
		rotation = new_dir.angle()
		
		position += new_dir * speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.queue_free()
		queue_free()
