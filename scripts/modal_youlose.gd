extends PanelContainer

@onready var scene_manager = $"/root/SceneManager"
@onready var reset = $VBoxContainer/HBoxContainer/Reset

func _ready() -> void:
	EventBus.connect("reset", _on_reset)
	EventBus.connect("lose", _on_lose)
	hide()

func _on_pressed() -> void:
	EventBus.emit_signal("reset")
	EventBus.emit_signal("clear_scene")

func _on_reset():
	hide()

func _on_lose():
	show()
