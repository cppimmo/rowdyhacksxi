class_name player extends CharacterBody2D

var move_speed : float = 150.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Up") - Input.get_action_strength("Down")
	
	velocity = direction * move_speed
	pass

func _physics_process(delta):
	move_and_slide()
