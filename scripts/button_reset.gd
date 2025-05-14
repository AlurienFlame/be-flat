extends TextureButton

func _on_pressed() -> void:
	EventBus.emit_signal("reset")
