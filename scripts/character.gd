class_name Character extends RigidBody2D

func _on_body_entered(body) -> void:
    # We just hit something
    if body is Obstacle:
        # We bonked an obstacle
        body.get_bonked()
    else:
        print("Hit something unknown")
