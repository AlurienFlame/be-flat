class_name Character extends RigidBody2D

func _ready() -> void:
	var play_pause_button = $"/root/Game/UI/MenuBar/PlayPauseButton"
	play_pause_button.connect("play", _on_play)
	play_pause_button.connect("pause", _on_pause)
	Engine.time_scale = 0.0

func _on_play() -> void:
	Engine.time_scale = 1.0

func _on_pause() -> void:
	Engine.time_scale = 0.0

func _on_body_entered(body) -> void:
	# We just hit something
	if body is Obstacle:
		# We bonked an obstacle
		body.get_bonked()
	else:
		print("Hit something unknown")
