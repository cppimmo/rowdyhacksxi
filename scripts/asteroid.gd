extends CharacterBody2D
@onready var timer= $Timer
@onready var sprite= $Sprite2D

const AsteroidSpawner = preload("uid://djumrgouyfqhh")

@export var SPEED = 100.0

var direction : float
var spawnPosition: Vector2
var spawnRotation: float
var asteroidSpawner = AsteroidSpawner.instantiate()

func _ready():
	global_position = spawnPosition
	global_rotation = spawnRotation
	add_child(asteroidSpawner)
	asteroidSpawner.spawnAsteroids()
	asteroidSpawner.spawnAsteroids()
	asteroidSpawner.spawnAsteroids()

func _physics_process(delta):
	velocity = Vector2(0,-SPEED).rotated(direction)
	move_and_slide()
	
func startDespawnTimer():
	asteroidSpawner.spawnAsteroids()
	timer.start()

func _on_timer_timeout():
	queue_free()
	asteroidSpawner.startDespawnTime()
	
func addSprite():
	sprite.
		
		
