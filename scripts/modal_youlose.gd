extends PanelContainer

@onready var scene_manager = $"/root/SceneManager"
@onready var reset = $VBoxContainer/HBoxContainer/Reset

var showed_death_tutorial = false

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
	# Pause the game
	EventBus.emit_signal("pause")
	if not showed_death_tutorial:
		Dialogic.start("tutorial-you-lost").process_mode = Node.PROCESS_MODE_ALWAYS
		showed_death_tutorial = true
