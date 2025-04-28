extends PanelContainer

signal reset

func _on_button_reset_pressed() -> void:
    emit_signal("reset")
    hide()