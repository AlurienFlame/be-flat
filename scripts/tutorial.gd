extends Node2D

@export var timeline: DialogicTimeline

func _ready() -> void:
    Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS

    if Dialogic.current_timeline != null:
        return

    Dialogic.start(timeline).process_mode = Node.PROCESS_MODE_ALWAYS
