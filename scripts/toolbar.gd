extends Control

func make_instance(obj: Resource) -> void:
	# Called when the button is pressed
	print("Instantiating object")

	var instance = obj.instantiate()
	instance.position = Vector2(0, 0) # Set the position as needed
	get_parent().add_child(instance)

func _on_rectangle_pressed() -> void:
	print("Instantiating rectangle")

	var rectangle_scene = load("res://scenes/obstacle.tscn")
	make_instance(rectangle_scene)

func _on_circle_pressed() -> void:
	print("Instantiating circle")

	var circle_scene = load("res://scenes/circleObstacle.tscn")
	

func _on_triangle_pressed() -> void:
	print("Instantiating triangle")
	var triangle_scene = load("res://scenes/triangleObstacle.tscn")
	var triangle_instance = triangle_scene.instantiate()
	triangle_instance.position = Vector2(0, 0) # Set the position as needed
	get_parent().add_child(triangle_instance)

func _on_trapezoid_pressed() -> void:
	print("Instantiating trapezoid")

	var trapezoid_scene = load("res://scenes/trapezoidObstacle.tscn")
	var trapezoid_instance = trapezoid_scene.instantiate()
	trapezoid_instance.position = Vector2(0, 0) # Set the position as needed
	get_parent().add_child(trapezoid_instance)

func _on_objective_pressed() -> void:
	print("Instantiating objective")

	var objective_scene = load("res://scenes/objective.tscn")
	var objective_instance = objective_scene.instantiate()
	objective_instance.position = Vector2(0, 0) # Set the position as needed
	get_parent().add_child(objective_instance)
