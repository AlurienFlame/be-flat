class_name Obstacle extends StaticBody2D


func get_bonked():
	$AudioStreamPlayer2D.play()
	print("Bonk!")
	
	# TODO: Play sound

