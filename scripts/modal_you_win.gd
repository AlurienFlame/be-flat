extends PanelContainer

@onready var scene_manager = $"/root/SceneManager"
@onready var next_puzzle_button = $VBoxContainer/HBoxContainer/ButtonNextPuzzle

func _ready() -> void:
    EventBus.connect("win", _on_win)
    EventBus.connect("reset", _on_reset)
    # Hide the modal when the game starts
    hide()

func _on_button_next_puzzle_pressed() -> void:
    scene_manager.increment_level()
    EventBus.emit_signal("reset")
    EventBus.emit_signal("clear_scene")

func _on_reset():
    # Hide the modal when the game is reset
    hide()

func _on_win():
    # Show or hide the next puzzle button based on whether a next puzzle exists
    if scene_manager.does_next_level_exist():
        next_puzzle_button.show()
    else:
        next_puzzle_button.hide()
    # Show the win modal
    show()
    # Pause the game
    EventBus.emit_signal("pause")
