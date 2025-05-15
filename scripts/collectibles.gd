extends Area2D
class_name Collectible

signal collected

var parent : Node

func _ready():
	parent = get_parent()
	# print("READY AND PARENT IS: ", parent)
	if not parent:
		parent = get_tree().root
	connect("body_entered", _on_body_entered)
	EventBus.connect("reset", _on_reset)

func _on_body_entered(body: Node) -> void:
    if is_inside_tree() and body is Character:
        emit_signal("collected")
        print("collectible")
        parent.remove_child.call_deferred(self)



func _on_reset() -> void:
	var new_collectible = self.duplicate()
	# print("Parent: ", parent)
	parent.add_child(new_collectible)
	self.queue_free()
