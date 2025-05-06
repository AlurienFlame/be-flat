extends PanelContainer

func _ready() -> void:
	EventBus.connect("reset", _on_reset)
	EventBus.connect("win", _on_win)
	# Hide the modal when the game starts
	hide()

var next_level_path: String = ""
func _on_button_next_puzzle_pressed() -> void:
	if next_level_path != "":
		print(next_level_path)
		get_tree().paused = false
		get_tree().change_scene_to_file(next_level_path)

	else:
		print("no path")

func _on_reset():
	hide()

func _on_win():
	# get current scene filepath
	var current_scene = get_tree().current_scene
	var current_scene_file = ""
	if current_scene != null:
		current_scene_file = current_scene.scene_file_path
	#calculate next level
	var next_level_number = current_scene_file.to_int() + 1
	#next level path 
	next_level_path = "res://scenes/levels/lvl" + str(next_level_number) + ".tscn"

	# Show the win modal
	show()
