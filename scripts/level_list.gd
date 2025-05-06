extends HFlowContainer

@onready var puzzle_button: PackedScene = preload("res://scenes/UI/puzzle_button.tscn")

func _ready() -> void:
    var levels = DirAccess.get_files_at("res://scenes/levels")
    for filename in levels:
        var button: AspectRatioContainer = puzzle_button.instantiate()
        button.get_node("Button").text = filename
        button.index = filename.to_int()
        add_child(button)
