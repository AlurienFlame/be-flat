extends Area2D
class_name Collectible

signal collected

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body is Character:
		emit_signal("collected")
		print("collectible")
		queue_free()
