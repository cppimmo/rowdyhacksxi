extends RigidBody2D

@export var speed: float = 350.0
@export var launch_dir: Vector2 = Vector2(-1, 0.6) #from top-right twoards left/down
@export var damage: int = 25


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = 0.0
	linear_damp = 0.0
	angular_damp = 0.0
	lock_rotation = true
	freeze = false
	
	#set inital velocity
	#linear_velocity = launch_dir.normalized() * speed
	
	#Impluse instead of preset vewlocity
	apply_impulse(launch_dir.normalized() * speed)
	
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
