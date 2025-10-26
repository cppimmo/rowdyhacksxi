extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#randomly pick one of the animation types and play it
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()
	$Area2D.body_entered.connect(_on_hurtbox_body_entered)
	pass # Replace with function body.

#when the enemy leaves the screen, delete mob
#func _on_visable_on_screen_notifier_2d_screen_exited():
	#queue_free()
	
#If mob touches player
func _on_hurtbox_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		if body.has_method("take_damage"):
			body.take_damage(25)
			



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
