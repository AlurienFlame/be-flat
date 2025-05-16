extends TextureButton

func _on_pressed() -> void:
    $AudioStreamPlayer2D.play()
    EventBus.emit_signal("reset")
