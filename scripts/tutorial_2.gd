extends Node2D

func _ready() -> void:
    if Dialogic.current_timeline != null:
        return
    Dialogic.start("tutorial-2").process_mode = Node.PROCESS_MODE_ALWAYS