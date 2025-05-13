class_name PuzzleButton extends AspectRatioContainer

@onready var button = $Button
@onready var subviewport = $SubViewport
@export var index: int
@onready var scene_manager = $"/root/SceneManager"

func _ready() -> void:
    # Thumbnails don't work because the instantiated scene UI breaks the menu UI
    # And we can't create the scene without UI because too much depends on it
    # var instantiated = scene.instantiate()
    # subviewport.add_child(instantiated)
    # await RenderingServer.frame_post_draw
    # button.icon = subviewport.get_texture()
    # instantiated.queue_free()
    pass

func init(filename, enabled) -> void:
    button.text = filename
    index = filename.to_int()
    button.disabled = !enabled

func _on_button_pressed() -> void:
    scene_manager.load_level(index)

func unlock() -> void:
    button.disabled = false

func is_unlocked() -> bool:
    return !button.disabled
