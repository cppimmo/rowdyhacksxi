extends Node

@onready var main_menu = get_node("RootMenu")
# Submenu for the game credits
@onready var credits_menu = get_node("CreditsMenu")
@onready var credits_box = credits_menu.find_child("CreditsBox")
@onready var background = get_node("BackgroundPanel")

const _FIRST_GAME_LEVEL: String = "res://game_level.tscn"
const _CREDITS_TEXT_PATH: String = "res://ui/credits_menu_content.txt"

# Scences for the different types of stars/planets (they are TextureRect's)
var star_data = {
	"circle": "res://ui/circle_star.tscn",
	# "cross": ""
}

func _load_from_file(file_path: String) -> String:
	# Attempt to open a file
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	if not file:
		push_error("Error opening file: ", file)
		return ""
		
	var contents = file.get_as_text() # Get the content of the file
	
	file.close() # Close the file
	
	return contents
	
	
func _rand_num_between(min: int, max: int) -> int:
	return randi() % (max + 1 - min) + min
	

# Use to draw stars randomly above the background pane
func _draw_background(num_stars: int) -> void:
	for i in range(num_stars):
		var key = star_data.keys().pick_random()
		var star_scene = load(star_data[key])
		var star_instance = star_scene.instantiate()
		background.add_child(star_instance)
		
		var bg_size = background.size
		var star_size = star_instance.size
		
		var pos_x = _rand_num_between(star_size.x / 2, bg_size.x - star_size.x / 2)
		var pos_y = _rand_num_between(star_size.y / 2, bg_size.y - star_size.y / 2)
		var pos = Vector2i(pos_x, pos_y)
		print("Background: ", bg_size, " Star: ", star_size, " -> Position: ", pos)
		
		print("Random position:", pos)
		
		star_instance.position = pos
		#star_instance.set_size(star_size * 0.5)


func _on_ready() -> void:
	#_draw_background(50)
	
	main_menu.visible = true
	credits_menu.visible = false
	
	var text = _load_from_file(_CREDITS_TEXT_PATH)
	if text != null:
		credits_box.text = text
	else:
		printerr("Empty credits text!")


func _on_play_button_pressed() -> void:
	print("Clicked the PLAY button!")
	# Change to the main game scene
	get_tree().change_scene_to_file(_FIRST_GAME_LEVEL)


func _on_credits_button_pressed() -> void:
	print("Clicked the CREDITS button!")
	main_menu.visible = false
	credits_menu.visible = true


func _on_quit_button_pressed() -> void:
	print("Clicked the QUIT button!")
	# Exit the game: https://docs.godotengine.org/en/stable/tutorials/inputs/handling_quit_requests.html
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_credits_back_button_pressed() -> void:
	print("Clicked the Credit's menu BACK button!")
	credits_menu.visible = false
	main_menu.visible = true
