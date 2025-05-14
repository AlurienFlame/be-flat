extends CanvasLayer

@onready var options_screen = $OptionsScreen
@onready var main_screen = $MainScreen
@onready var level_select = $LevelSelect
@onready var scene_manager = $"/root/SceneManager"


# Animation Settings
const duration = 0.2


# Main Screen
func _on_puzzles_pressed() -> void:
    var tween = get_tree().create_tween().set_parallel(true)
    tween.tween_property(main_screen, "anchor_bottom", 2, duration).from_current()
    tween.tween_property(main_screen, "anchor_top", 1, duration).from_current()
    tween.tween_property(level_select, "anchor_bottom", 1, duration).from_current()
    tween.tween_property(level_select, "anchor_top", 0, duration).from_current()

func _on_free_play_pressed() -> void:
    # Load into an empty game board
    scene_manager.load_free_play()

func _on_options_pressed():
    # Slide to options
    var tween = get_tree().create_tween().set_parallel(true)
    tween.tween_property(main_screen, "anchor_left", -1, duration).from_current()
    tween.tween_property(main_screen, "anchor_right", 0, duration).from_current()
    tween.tween_property(options_screen, "anchor_left", 0, duration).from_current()
    tween.tween_property(options_screen, "anchor_right", 1, duration).from_current()

func _on_quit_pressed():
    # Close application
    get_tree().quit()

# Level Select Screen
func _on_back_pressed_from_level_select() -> void:
    var tween = get_tree().create_tween().set_parallel(true)
    tween.tween_property(level_select, "anchor_top", -1, duration).from_current()
    tween.tween_property(level_select, "anchor_bottom", 0, duration).from_current()
    tween.tween_property(main_screen, "anchor_top", 0, duration).from_current()
    tween.tween_property(main_screen, "anchor_bottom", 1, duration).from_current()

# Options Screen
func _on_back_pressed_from_options() -> void:
    var tween = get_tree().create_tween().set_parallel(true)
    tween.tween_property(options_screen, "anchor_right", 2, duration).from_current()
    tween.tween_property(options_screen, "anchor_left", 1, duration).from_current()
    tween.tween_property(main_screen, "anchor_right", 1, duration).from_current()
    tween.tween_property(main_screen, "anchor_left", 0, duration).from_current()
