extends Node
class_name CollectedTracker

var collected_parts: int = 0
signal parts_updated(new_count: int)

func _ready():
	# Connect to the reset signal
	EventBus.connect("reset", _on_reset)
	

func increment():
	collected_parts += 1
	
	emit_signal("parts_updated", collected_parts)
	

func _on_reset():
	collected_parts = 0
	emit_signal("parts_updated", collected_parts)
