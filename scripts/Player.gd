class_name Player extends CharacterBody2D

@onready var hit_sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

#@onready var zPlayer = $ZoeyPlayer
#@onready var hud: CanvasLayer = $"VBoxContainer/Health Counter/health num text"

var move_speed : float = 150.0
var max_health: int = 100
var current_health: int = max_health

#signals for communicating health changes
signal health_changed(new_health, max_health)
signal died

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health
	emit_signal("health_changed", current_health, max_health)
	#zPlayer.health_changed.connect(hud.set_health)
	#hud.set_health(zPlayer.current_health, zPlayer.max_health)
	#pass # Replace with function body.


func take_damage(amount: int) -> void:
	#if damage is 0 or less, do nothing
	
	
		#hit_sfx.play()
	
	if amount <= 0:
		return
		
	if hit_sfx: hit_sfx.play()
		
	#current_health -= amount
	current_health = clamp(current_health - amount, 0, max_health) #Clamp health between 0 and max_health
	emit_signal("health_changed" , current_health, max_health)
	
	#self explanatory
	if current_health <= 0:
		died.emit()
		
func heal(amount: int):
	if amount <= 0:
		return

	current_health += amount
	current_health = clamp(current_health, 0, max_health) #Clamp health between 0 and max_health
	emit_signal("health changed", current_health, max_health)

func die():
	print("Player has died!")
	#emit_signal("died")
	died.emit()
	#add game over logic here
	
#func _on_Player_body_entered(_body):
	#hit_sfx.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	velocity = direction * move_speed
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider and collider.is_in_group("destroyable"):
			collider.queue_free()
