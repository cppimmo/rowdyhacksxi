extends CanvasLayer

@export var player_path: NodePath
@onready var health_label: Label = $"VBoxContainer/Health Counter/health num text"


func set_health(current: int, maxv: int) -> void:
	health_label.text = "%d / %d" % [current, maxv]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if player:
		#player.health_changed.connect(set_health)
		#set_health(player.current_health, player.max_health)
		pass #Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
