extends Node2D

@onready var main = get_tree().get_root().get_node("main")  #gets a reference to main class
@onready var asteroid  = load("res://asteroid.tscn")  #was "res://scene/asteroid.tscn"
var instanceAsteroid

var xcord
var ycord
var random
var numOfAsteroids = 3
var numOfAliens = 3
var numOfCows = 3

#Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instanceAsteroid = asteroid.instantiate()
	

func spawnAsteroids():
	random = randi()%4
	if random == 1:    #spawns on top
		numOfAsteroids = 1
		xcord = 150
		ycord = 1500
	if random == 3:    #spawns on bottom
		numOfAsteroids = 1
		xcord = 900
		ycord = 1500
	if random == 0:     #spawns on left
		numOfAsteroids = 1
		xcord = -100    #-50
		ycord = -900     #-900
	if random == 2:     #spawns on right
		numOfAsteroids = 1
		xcord = 1500
		ycord = -900    #-900
	shootAsteroid()
		
func shootAsteroid():
	instanceAsteroid= asteroid.instantiate()
	instanceAsteroid.direction = rotation
	if  random % 2 :
		instanceAsteroid.spawnPosition = Vector2(xcord, randi()%ycord)
	else:
		instanceAsteroid.spawnPosition = Vector2(randi()%xcord, ycord)
	
	var screen_center = get_viewport_rect().size / 2
	var direction = (screen_center - instanceAsteroid.spawnPosition).normalized()
	instanceAsteroid.spawnRotation = direction.angle()  # Use angle(), not 180
	main.add_child.call_deferred(instanceAsteroid)
	
func spawnAliens():
	pass
	
func spawnCows():
	pass
	
func resetCords():
	xcord = 0
	ycord = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
