class_name Character extends RigidBody2D

func _on_body_entered(body: Obstacle) -> void:
    # We just hit something
	body.get_bonked()
