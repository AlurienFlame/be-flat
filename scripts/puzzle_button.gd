extends AspectRatioContainer

@onready var button = $Button
@onready var subviewport = $SubViewport
@export var scene: PackedScene

func _ready() -> void:
    # TODO: fix scene hierarchy so it can be instantiated in a subviewport
    # var instantiated = scene.instantiate()
    # subviewport.add_child(instantiated)
    button.icon = subviewport.get_texture()

func _on_button_pressed() -> void:
    get_tree().change_scene_to_file(scene.resource_path)
