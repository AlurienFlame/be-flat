extends Control

@onready var options_screen = $"./OptionsScreen"
@onready var main_screen = $MainScreen

# Animation Settings
const duration = 0.2
const left = -0.5
const middle = 0.5
const right = 1.5

func _on_puzzles_pressed() -> void:
	# Slide to puzzle list
	print("Not Implemented")

# Main Screen
func _on_free_play_pressed() -> void:
	# Load into an empty game board
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_options_pressed():
	# Slide to options
	var tween = get_tree().create_tween()
	tween.tween_property(main_screen, "anchor_right", left, duration).from_current()
	tween.tween_property(options_screen, "anchor_right", middle, duration).from_current()

func _on_quit_pressed():
	# Close application
	get_tree().quit()

# Options Screen
func _on_back_pressed():
	var tween = get_tree().create_tween()
	tween.tween_property(options_screen, "anchor_left", right, duration).from_current()
	tween.tween_property(main_screen, "anchor_left", middle, duration).from_current()
