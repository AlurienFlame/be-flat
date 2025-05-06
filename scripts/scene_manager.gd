extends Node2D

@onready var menu = $MainMenu
@onready var game_ui = $UI

var current_level: int
var level_node: Node2D

func load_free_play():
    menu.hide()
    game_ui.show()
    if level_node:
        level_node.queue_free()

    var scene = load("res://scenes/free_play.tscn")
    level_node = scene.instantiate()
    add_child(level_node)

func load_level(level: int):
    menu.hide()
    game_ui.show()
    if level_node:
        level_node.queue_free()
    current_level = level

    var scene = load("res://scenes/levels/lvl" + str(level) + ".tscn")
    level_node = scene.instantiate()
    add_child(level_node)

func increment_level():
    current_level += 1
    load_level(current_level)
