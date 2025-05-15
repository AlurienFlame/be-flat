extends PanelContainer

@onready var scene_manager = $"/root/SceneManager"
@onready var next_puzzle_button = $VBoxContainer/HBoxContainer/ButtonNextPuzzle

func _ready() -> void:
    EventBus.connect("win", _on_win)
    # Hide the modal when the game starts
    hide()

func _on_button_next_puzzle_pressed() -> void:
    scene_manager.increment_level()
    EventBus.emit_signal("reset")
    EventBus.emit_signal("clear_scene")
    hide()

func _on_win():
    # Show or hide the next puzzle button based on whether a next puzzle exists
    next_puzzle_button.disabled = not scene_manager.does_next_level_exist()
    # Show the win modal
    show()
    # Pause the game
    EventBus.emit_signal("pause")
