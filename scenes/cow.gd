extends Area2D

func _ready():
	self.body_entered.connect(_on_body_entered)
@onready var health_and_cow_counter: Control = $"Health and Cow Counter"

func _on_body_entered(body: Node2D) -> void:
	var p: = body 
	if p.is_in_group("destroyable"):
		health_and_cow_counter.increaseCows()
		queue_free()
