extends CanvasLayer

@onready var options_screen = $OptionsScreen
@onready var main_screen = $MainScreen
@onready var level_select = $LevelSelect
@onready var scene_manager = $"/root/SceneManager"
@onready var levelList = $LevelSelect/LevelList
@onready var audio = $AudioStreamPlayer


# Animation Settings
const duration = 0.2




# Main Screen
func _on_puzzles_pressed() -> void:
    var tween = create_tween().set_parallel(true)
    tween.tween_property(main_screen, "anchor_bottom", 2, duration).from_current()
    tween.tween_property(main_screen, "anchor_top", 1, duration).from_current()
    tween.tween_property(level_select, "anchor_bottom", 1, duration).from_current()
    tween.tween_property(level_select, "anchor_top", 0, duration).from_current()
    for child in levelList.get_children():
        child.top_level = true

func _on_free_play_pressed() -> void:
    audio.stop()
    # Load into an empty game board
    scene_manager.load_free_play()

func _on_options_pressed():
    # Slide to options
    var tween = create_tween().set_parallel(true)
    var scene_manager = get_tree().root.get_node("SceneManager")
    print("Found scene manager:", scene_manager)
    if not scene_manager:
        print("Scene manager not found!")
        # return
    tween.tween_property(main_screen, "anchor_left", -1, duration).from_current()
    tween.tween_property(main_screen, "anchor_right", 0, duration).from_current()
    tween.tween_property(options_screen, "anchor_left", 0, duration).from_current()
    tween.tween_property(options_screen, "anchor_right", 1, duration).from_current()
    print("Opening options menu with version: %s" % scene_manager.get_version())
    Analytics.add_event("Opened options menu", {"version": scene_manager.get_version()})

func _notification(what):
    if what == NOTIFICATION_WM_CLOSE_REQUEST:
        print("Intercepting close request")
        _on_quit_pressed()

func _on_quit_pressed():
    # Close application
    print("Quit pressed")
    await Analytics.handle_exit()
    get_tree().quit()

# Level Select Screen
func _on_back_pressed_from_level_select() -> void:
    print("level select node: %s" % level_select)
    print("main screen node: %s" % main_screen)
    var tween = create_tween().set_parallel(true)
    tween.tween_property(level_select, "anchor_top", -1, duration).from_current()
    tween.tween_property(level_select, "anchor_bottom", 0, duration).from_current()
    tween.tween_property(main_screen, "anchor_top", 0, duration).from_current()
    tween.tween_property(main_screen, "anchor_bottom", 1, duration).from_current()
    tween.connect("finished", func():
        print("Back tween finished")
       
    )
    for child in levelList.get_children():
        print("Setting child %s to top level" % child.name)
        child.top_level = false

# Options Screen
func _on_back_pressed_from_options() -> void:
    var tween = create_tween().set_parallel(true)
    tween.tween_property(options_screen, "anchor_right", 2, duration).from_current()
    tween.tween_property(options_screen, "anchor_left", 1, duration).from_current()
    tween.tween_property(main_screen, "anchor_right", 1, duration).from_current()
    tween.tween_property(main_screen, "anchor_left", 0, duration).from_current()
