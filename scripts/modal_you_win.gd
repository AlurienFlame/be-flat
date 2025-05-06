extends PanelContainer

signal reset

var next_level_path: String = ""
func _on_button_next_puzzle_pressed() -> void:
	if next_level_path != "":
		print(next_level_path)
		get_tree().paused = false
		get_tree().change_scene_to_file(next_level_path)
		
	else:
		print("no path")
