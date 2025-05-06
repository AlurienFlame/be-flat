extends Area2D
class_name Collectibles

signal collected

func _on_body_entered(body: Node2D) -> void:
    if not play_pause_button.is_playing:
		return
	if body is Character:
		emit_signal("collected")
		queue_free()