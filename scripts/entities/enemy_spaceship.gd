extends Area2D

var utils = preload("res://scripts/utils.gd")

@export var hover_amplitude: float = 10.0 # How far the ship moves in either dir (pixels)
@export var hover_speed: float = utils.randf_num_between(1.0, 2.0) # Oscillation speed
var initial_pos
var hover_dir
var time_passed: float = 0.0

@export var speed: float = 250.0
@export var fire_interval: float = 3.0 # Seconds between blasts
var next_fire_interval: float = fire_interval
@export var laser_scene: PackedScene # Assign laser scene in the editor

@onready var target = get_tree().get_first_node_in_group("player")
var time_since_last_shot: float = 0.0

const _LASER_SFX_PATH: String = "res://assets/sounds/lasers"
const _LASER_SFX_COUNT: int = 13
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
var sfx_resources: Array[AudioStream] = []


func _on_ready() -> void:
	initial_pos = self.position # Remember initial position
	hover_dir = Vector2i(utils.get_random_direction(), utils.get_random_direction())
	
	# Load all laser sound effects
	for i in range(1, _LASER_SFX_COUNT + 1):
		var path = "%s/laser%02d.wav" % [_LASER_SFX_PATH, i]
		if ResourceLoader.exists(path):
			var sfx = load(path)
			sfx_resources.append(sfx)
		else:
			push_warning("Missing SFX file: " + path)
	

func _process(delta: float) -> void:
	time_passed += delta
	self.position.x = initial_pos.x + sin(time_passed * hover_speed) * hover_amplitude * hover_dir.x
	self.position.y = initial_pos.y + sin(time_passed * hover_speed) * hover_amplitude * hover_dir.y

	if target:
		time_since_last_shot += delta

		# Fire a laser when the time elapses
		if time_since_last_shot >= next_fire_interval:
			_fire_laser()
			time_since_last_shot = 0.0
			
			next_fire_interval = randf_range(fire_interval / 2, fire_interval * 2)

func _fire_laser() -> void:
	if not laser_scene:
		push_error("Laser scene not set!")
		return
		
	var laser = laser_scene.instantiate()
	get_tree().current_scene.add_child(laser) # Add newly fired laser to current scene
	
	laser.global_position = global_position
	
	# Calculate direction towards the player
	var dir = (target.global_position - global_position).normalized()
	
	laser.rotation = dir.angle() #deg_to_rad(rad_to_deg(dir.angle()) + 90.0)
	
	#if laser.has_variable("velocity"):
	laser.velocity = dir * laser.speed
	
	if sfx_resources.size() > 0:
		var random_sfx = sfx_resources[randi() % sfx_resources.size()]
		audio_stream_player_2d.stream = random_sfx
		audio_stream_player_2d.play()
