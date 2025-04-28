extends Button

@onready var modal_you_win: PanelContainer = $"/root/Game/UI/ModalYouWin"

func _on_pressed() -> void:
	modal_you_win.emit_signal("reset")
	modal_you_win.hide()
