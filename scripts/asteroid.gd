extends CharacterBody2D

@export var SPEED = 100.0

var direction : float
var spawnPosition: Vector2
var spawnRotation: float

func _ready():
	global_position = spawnPosition
	global_rotation = spawnRotation

func _physics_process(delta):
	velocity = Vector2(0,-SPEED).rotated(direction)
	move_and_slide()
