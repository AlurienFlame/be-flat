class_name Objective extends Area2D

@onready var play_pause_button: TextureButton = $"/root/SceneManager/UI/MenuBar/PlayPauseButton"

func _on_body_entered(body:Node2D) -> void:
    if not play_pause_button.is_playing:
        return

    if body is Character:
        # We hit a character
        EventBus.emit_signal("win")
    else:
        print("Something unknown hit the objective")
