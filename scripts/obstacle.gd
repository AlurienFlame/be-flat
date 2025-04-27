class_name Obstacle extends StaticBody2D

var draggable = false

# put $PlayPauseButton in scene tree, directly ask its global variable for if something is paused

func _process(delta: float) -> void:
	if draggable:
		# Check if the mouse is pressed
		if Input.is_action_pressed("click"):
			# Check if the mouse is over the obstacle
			print("CLICK")
			var mouse_pos = get_global_mouse_position()
			global_position = mouse_pos

		# Handle dragging logic here
		
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
