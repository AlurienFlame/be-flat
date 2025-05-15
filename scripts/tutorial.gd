extends Node2D

func _ready() -> void:
    if Dialogic.current_timeline != null:
        return
    Dialogic.start("tutorial").process_mode = Node.PROCESS_MODE_ALWAYS
    Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
    
    EventBus.connect("lose", _on_lose)

func _on_lose():
    Dialogic.start("tutorial-you-lost").process_mode = Node.PROCESS_MODE_ALWAYS