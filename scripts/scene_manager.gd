extends Node2D

@onready var menu = $MainMenu
@onready var game_ui = $UI
@onready var level_list = $"MainMenu/LevelSelect/LevelList"

var current_level: int = -1
var level_node: Node2D

func is_current_level(level: int) -> bool:
    return current_level == level

func _ready():
    EventBus.connect("win", _on_win)
    process_mode = PROCESS_MODE_ALWAYS

func _on_win():
    # Unlock the next level
    if does_next_level_exist():
        level_list.unlock_level(current_level + 1)

func load_free_play():
    menu.hide()
    game_ui.show()
    if level_node:
        # print("FREEING LEVEL NODE", level_node)
        level_node.queue_free()
    current_level = -1 # Free play mode
    Analytics.add_event("Free play", {"version": 1.0})
    var scene = load("res://scenes/free_play.tscn")
    level_node = scene.instantiate()
    level_node.process_mode = PROCESS_MODE_PAUSABLE
    add_child(level_node)

func load_level(level: int):
    menu.hide()
    game_ui.show()
    if level_node:
        print("FREEING LEVEL NODE", level_node)
        level_node.queue_free()
        
    current_level = level

    var scene = load("res://scenes/levels/lvl" + str(level) + ".tscn")
    level_node = scene.instantiate()
    level_node.process_mode = PROCESS_MODE_PAUSABLE
    add_child(level_node)

func increment_level():
    Analytics.add_event("Completed level", {"level": current_level, "version": 1.0})
    print("Added analytic")
    # await Analytics.handle_exit()
    current_level += 1
    
    load_level(current_level)

func does_next_level_exist() -> bool:
    print(current_level)
    if current_level == -1:
        return false
    var next_level_path = "res://scenes/levels/lvl" + str(current_level + 1) + ".tscn"
    return ResourceLoader.exists(next_level_path)

func return_to_menu():
    if level_node:
        level_node.queue_free()
    menu.show()
    EventBus.emit_signal("reset")
    game_ui.hide()
    current_level = -1
