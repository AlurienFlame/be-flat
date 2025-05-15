extends Node2D

func _ready() -> void:
    Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
    EventBus.connect("lose", _on_lose)

    if Dialogic.current_timeline != null:
        return
    Dialogic.start("tutorial").process_mode = Node.PROCESS_MODE_ALWAYS

func _on_lose():
    if Dialogic.current_timeline != null:
        return
    Dialogic.start("tutorial-you-lost").process_mode = Node.PROCESS_MODE_ALWAYS