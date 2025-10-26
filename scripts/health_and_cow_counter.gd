extends Control


var numOfCows = 0
var numOfHearts = 3
#sets the number of hearts and cows to numOfCows and numOfHearts
@onready var health_label= $"CanvasLayer/VBoxContainer/Health Counter/health num text"
@onready var cow_label= $"CanvasLayer/VBoxContainer/Cows Counter/cow collector num text"
func _ready():
	updateCowLabel()

func updateCowLabel():
	#health_label.text = str(numOfHearts)  #converts numOfHearts to a string and gives to to health_label text
	cow_label.text = str(numOfCows)       #converts numOfCows to a string and gives to to cow_label text
	
func increaseCows():    #increases cow count
	numOfCows = numOfCows +1
	print("cowsIncreased")
	updateCowLabel()
	
func resetCows():   #when player dies, reset
	numOfCows = 0
	
func decreaseHearts():      #decreases number of hearts
	numOfHearts = numOfHearts-1;
	
func resetHearts():     #resets numOfHearts (after dieing)
	numOfHearts = 3
