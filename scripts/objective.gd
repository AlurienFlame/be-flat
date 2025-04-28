class_name Objective extends Area2D

@onready var play_pause_button: TextureButton = $"/root/Game/UI/MenuBar/PlayPauseButton"

func _on_body_entered(body:Node2D) -> void:
	if body is Character:
		# We hit a character

		# Show the win modal
		var modal = %UI/ModalYouWin
		modal.show()

		# Pause the game
		play_pause_button.emit_signal("pause")
	else:
		print("Something unknown hit the objective")
