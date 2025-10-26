extends Node2D

@export var burn_time: float = 3.0 
var time_elapsed: float = 0.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_ready() -> void:
	animated_sprite_2d.play("burn")

func _process(delta: float) -> void:
	time_elapsed += delta
	if time_elapsed >= burn_time:
		animated_sprite_2d.play("fuel_spent")
