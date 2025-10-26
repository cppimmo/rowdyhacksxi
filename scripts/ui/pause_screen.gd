extends Control

@onready var ui_root: Control = $CenterContainer

func _on_ready() -> void:
	ui_root.visible = false
	

func _process(delta: float) -> void:
	if Input.action_press("Pause"):
		ui_root.visible = not ui_root.visible
		
	
func _on_resume_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	pass # Replace with function body.
