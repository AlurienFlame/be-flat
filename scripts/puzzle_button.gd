extends AspectRatioContainer

@onready var button = $Button
@onready var subviewport = $SubViewport
@export var scene: PackedScene

func _ready() -> void:
    # TODO: Figure out why these lines break the puzzle button
    # var instantiated = scene.instantiate()
    # subviewport.add_child(instantiated)
    # await RenderingServer.frame_post_draw
    # button.icon = subviewport.get_texture()
    # instantiated.queue_free()
    pass

func _on_button_pressed() -> void:
    get_tree().change_scene_to_file(scene.resource_path)
