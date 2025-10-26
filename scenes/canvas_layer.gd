extends CanvasLayer

@export var player_path: NodePath
@onready var health_label: Label = $"VBoxContainer/Health Counter/health num text"
@onready var cow_label: Label    = $"VBoxContainer/Cows Counter/cow collector num text"
var numOfCows = 0 #AAAAAAAAAA

func updateCowLabel():
	#health_label.text = str(numOfHearts)  #converts numOfHearts to a string and gives to to health_label text
	cow_label.text = str(numOfCows)       #converts numOfCows to a string and gives to to cow_label text
	
func increaseCows():    #increases cow count
	numOfCows = numOfCows +1
	print("cowsIncreased")
	updateCowLabel()
	
func set_health(current: int, maxv: int) -> void:
	health_label.text = "%d / %d" % [current, maxv]

func set_cows(collected: int, total: int = -1) -> void:
	if total >= 0:
		cow_label.text = "%d / %d" % [collected, total]
	else:
		cow_label.text = str(collected)

func _ready() -> void:
	pass
