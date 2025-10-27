extends Area2D
@onready var HEALTH_AND_COW_COUNTER = preload("res://scenes/health_and_cow_counter.tscn")
#@onready var canvas_layer: CanvasLayer = $CanvasLayer

<<<<<<< HEAD
func _ready():
	self.body_entered.connect(_on_body_entered)
@onready var health_and_cow_counter: Control = $"Health and Cow Counter"

func _on_body_entered(body: Node2D) -> void:
	var p: = body 
	if p.is_in_group("destroyable"):
		health_and_cow_counter.increaseCows()
=======
signal cow_picked_up(count: int)
var cowCount := 0

func _enter_tree() -> void:
	add_to_group("cows")
	print("[COW] enter:", get_path())

func _ready() -> void:
	monitoring = true
	monitorable = true
	body_entered.connect(_on_body_entered)
	print("[COW] ready:", name, "connected?", body_entered.is_connected(_on_body_entered))

func _on_body_entered(body: Node) -> void:
	var p := body
	if not p.is_in_group("player") and body.get_parent() and body.get_parent().is_in_group("player"):
		p = body.get_parent()

	if p.is_in_group("player"):

		print("signal emitted: cow_picked_up")
#		HEALTH_AND_COW_COUNTER.increaseCows()
		#cowCount+=1

		emit_signal("cow_picked_up", cowCount)
>>>>>>> 56b89ad22b30450882c701932c4dc65e5f360634
		queue_free()
