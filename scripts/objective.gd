class_name Objective extends Area2D

func _on_body_entered(body:Node2D) -> void:
	if body is Character:
		# We hit a character

		# Show the win modal
		var modal = %UI/ModalYouWin
		modal.show()
	else:
		print("Something unknown hit the objective")
