extends Node2D

@onready var play_pause_button: TextureButton = $"/root/Game/UI/MenuBar/PlayPauseButton"

var draggable = false

# make static cur object
static var cur_object = null


func _process(delta: float) -> void:
	if draggable and not play_pause_button.is_playing:
		# Check if the mouse is pressed
		if Input.is_action_pressed("click"):
			# Check if the mouse is over the obstacle
			if not cur_object or cur_object == get_parent():
				# Cur object is the object that was clicked
				cur_object = get_parent()
				var mouse_pos = get_global_mouse_position()
				cur_object.global_position = mouse_pos

	# Check if the mouse is released
	if Input.is_action_just_released("click"):
		cur_object = null
		print("RELEASE")
		
		print("HOVERING OVER OBJECT")

func _on_mouse_obstacle_entered(shape_idx: int) -> void:
	draggable = true
	print("Mouse entered object")

func _on_mouse_obstacle_exited(shape_idx: int) -> void:
	draggable = false
	print("Mouse exited object")