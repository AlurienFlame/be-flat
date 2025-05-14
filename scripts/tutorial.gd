extends Node2D

func _ready() -> void:
    if Dialogic.current_timeline != null:
        return
    # Dialogic.start("tutorial")