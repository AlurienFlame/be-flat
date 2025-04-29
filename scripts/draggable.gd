extends Node2D

@onready var play_pause_button: TextureButton = $"/root/Game/UI/MenuBar/PlayPauseButton"
@onready var trashcan = $"/root/Game/UI/ToolBar/trashcan"

var draggable = false

# make static cur object
static var cur_object = null


func _process(_delta: float) -> void:
	if (draggable or cur_object) and not play_pause_button.is_playing:
		# Check if the mouse is pressed
		if Input.is_action_pressed("click"):
			# Check if the mouse is over the obstacle
			if not cur_object or cur_object == get_parent():
				# Cur object is the object that was clicked
				cur_object = get_parent()
				
				# show trash
				trashcan.visible = true

				var mouse_pos = get_global_mouse_position()
				cur_object.global_position = mouse_pos

	# Check if the mouse is released
	if Input.is_action_just_released("click"):
		if trashcan.can_delete:
			# Check if the mouse is over the trash
			# Delete the object
			trashcan.can_delete = false
			cur_object.queue_free()
			
		cur_object = null
		
		# hide trash
		trashcan.visible = false
		
		

func _on_mouse_obstacle_entered(_shape_idx: int) -> void:
	draggable = true

func _on_mouse_obstacle_exited(_shape_idx: int) -> void:
	draggable = false
