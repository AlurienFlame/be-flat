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

    var scene_manager = get_tree().root.get_node("SceneManager")
    if not scene_manager:
        print("SceneManager not found in on_lose!!!")
        return

    var metadata = {
        "level": scene_manager.get_level(),
        "version": scene_manager.get_version()
    }
    var level_info = scene_manager.get_level_info()
    # add all of level_info to metadata
    metadata.merge(level_info)
    print("Metadata for YouLose: ", metadata)
    print("YouLose got level info: ", level_info)

    Analytics.add_event("Player died", metadata)

    # Pause the game
    EventBus.emit_signal("pause")
    if not showed_death_tutorial and scene_manager.is_current_level(1):
        Dialogic.start("timelines/tutorial-you-lost").process_mode = Node.PROCESS_MODE_ALWAYS
        showed_death_tutorial = true
