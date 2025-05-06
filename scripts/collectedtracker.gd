extends Node
class_name CollectedTracker

var collected_parts: int = 0
signal parts_updated(new_count: int)

func increment():
	collected_parts += 1
	emit_signal("parts_updated", collected_parts)