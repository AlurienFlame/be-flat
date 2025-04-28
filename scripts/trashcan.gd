extends Area2D

var can_delete = false

func _on_mouse_shape_entered(shape_idx: int) -> void:
	can_delete = true
	print("Mouse entered trash")


func _on_mouse_shape_exited(shape_idx: int) -> void:
	can_delete = false
	print("Mouse exited trash")
