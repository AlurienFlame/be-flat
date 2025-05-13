extends HFlowContainer

@onready var puzzle_button: PackedScene = preload("res://scenes/UI/puzzle_button.tscn")

func _ready() -> void:
    var levels = DirAccess.get_files_at("res://scenes/levels")
    var unlocked_first_level = false
    for filename in levels:
        var button: AspectRatioContainer = puzzle_button.instantiate()
        add_child(button)
        if unlocked_first_level:
            button.init(filename, false)
        else:
            button.init(filename, true)
            unlocked_first_level = true
