class_name Obstacle extends StaticBody2D

var draggable = false

# make static cur object
static var cur_object = null

# put $PlayPauseButton in scene tree, directly ask its global variable for if something is paused

func _process(delta: float) -> void:
	if draggable:
		# Check if the mouse is pressed
		if Input.is_action_pressed("click"):
			# Check if the mouse is over the obstacle
			if not cur_object or cur_object == self:
				# Cur object is the object that was clicked
				cur_object = self
				var mouse_pos = get_global_mouse_position()
				global_position = mouse_pos

	# Check if the mouse is released
	if Input.is_action_just_released("click"):
		cur_object = null
		print("RELEASE")
		
		print("HOVERING OVER OBSTACLE")

func get_bonked():
	$AudioStreamPlayer2D.play()
	print("Bonk!")
	
	# TODO: Play sound


func _on_mouse_obstacle_entered(shape_idx: int) -> void:
	draggable = true
	print("Mouse entered obstacle")

func _on_mouse_obstacle_exited(shape_idx: int) -> void:
	draggable = false
	print("Mouse exited obstacle")
