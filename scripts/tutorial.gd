extends Node2D

func _ready() -> void:
    Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS

    if Dialogic.current_timeline != null:
        return
    Dialogic.start("tutorial").process_mode = Node.PROCESS_MODE_ALWAYS