extends TextureButton

func _on_pressed() -> void:
    $AudioStreamPlayer2D.play()
    # Scene manager is not considered "owned"
    var scene_manager = get_tree().root.find_child("SceneManager", false, false)
    scene_manager.return_to_menu()
