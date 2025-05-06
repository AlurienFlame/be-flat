class_name Objective extends Area2D

@onready var play_pause_button: TextureButton = $"/root/Game/UI/MenuBar/PlayPauseButton"

func _on_body_entered(body:Node2D) -> void:
	if not play_pause_button.is_playing:
		return

	if body is Character:
		# We hit a character

		# get current scene filepath
		var current_scene = get_tree().current_scene
		var current_scene_file = ""
		if current_scene != null:
			current_scene_file = current_scene.scene_file_path
		#calculate next level
		var next_level_number = current_scene_file.to_int() + 1
		#next level path 
		var next_level_path = "res://scenes/levels/lvl" + str(next_level_number) + ".tscn"
		

		# Show the win modal
		var modal = %UI/ModalYouWin
		modal.next_level_path = next_level_path
		modal.show()

		# Pause the game
		play_pause_button.emit_signal("pause")
	else:
		print("Something unknown hit the objective")
